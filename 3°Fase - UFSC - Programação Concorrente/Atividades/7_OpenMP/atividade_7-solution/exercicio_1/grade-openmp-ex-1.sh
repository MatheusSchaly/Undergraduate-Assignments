#!/bin/bash
# Usage: grade dir_or_archive [output]

# Ensure realpath 
realpath . &>/dev/null
HAD_REALPATH=$(test "$?" -eq 127 && echo no || echo yes)
if [ "$HAD_REALPATH" = "no" ]; then
  cat > /tmp/realpath-grade.c <<EOF
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
  char* path = argv[1];
  char result[8192];
  memset(result, 0, 8192);

  if (argc == 1) {
      printf("Usage: %s path\n", argv[0]);
      return 2;
  }
  
  if (realpath(path, result)) {
    printf("%s\n", result);
    return 0;
  } else {
    printf("%s\n", argv[1]);
    return 1;
  }
}
EOF
  cc -o /tmp/realpath-grade /tmp/realpath-grade.c
  function realpath () {
    /tmp/realpath-grade $@
  }
fi

INFILE=$1
if [ -z "$INFILE" ]; then
  CWD_KBS=$(du -d 0 . | cut -f 1)
  if [ -n "$CWD_KBS" -a "$CWD_KBS" -gt 20000 ]; then
    echo "Chamado sem argumentos."\
         "Supus que \".\" deve ser avaliado, mas esse diretório é muito grande!"\
         "Se realmente deseja avaliar \".\", execute $0 ."
    exit 1
  fi
fi
test -z "$INFILE" && INFILE="."
INFILE=$(realpath "$INFILE")
# grades.csv is optional
OUTPUT=""
test -z "$2" || OUTPUT=$(realpath "$2")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Absolute path to this script
THEPACK="${DIR}/$(basename "${BASH_SOURCE[0]}")"
STARTDIR=$(pwd)

# Split basename and extension
BASE=$(basename "$INFILE")
EXT=""
if [ ! -d "$INFILE" ]; then
  BASE=$(echo $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\1/g')
  EXT=$(echo  $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\2/g')
fi

# Setup working dir
rm -fr "/tmp/$BASE-test" || true
mkdir "/tmp/$BASE-test" || ( echo "Could not mkdir /tmp/$BASE-test"; exit 1 )
UNPACK_ROOT="/tmp/$BASE-test"
cd "$UNPACK_ROOT"

function cleanup () {
  test -n "$1" && echo "$1"
  cd "$STARTDIR"
  rm -fr "/tmp/$BASE-test"
  test "$HAD_REALPATH" = "yes" || rm /tmp/realpath-grade* &>/dev/null
  return 1 # helps with precedence
}

# Avoid messing up with the running user's home directory
# Not entirely safe, running as another user is recommended
export HOME=.

# Check if file is a tar archive
ISTAR=no
if [ ! -d "$INFILE" ]; then
  ISTAR=$( (tar tf "$INFILE" &> /dev/null && echo yes) || echo no )
fi

# Unpack the submission (or copy the dir)
if [ -d "$INFILE" ]; then
  cp -r "$INFILE" . || cleanup || exit 1 
elif [ "$EXT" = ".c" ]; then
  echo "Corrigindo um único arquivo .c. O recomendado é corrigir uma pasta ou  arquivo .tar.{gz,bz2,xz}, zip, como enviado ao moodle"
  mkdir c-files || cleanup || exit 1
  cp "$INFILE" c-files/ ||  cleanup || exit 1
elif [ "$EXT" = ".zip" ]; then
  unzip "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.gz" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.bz2" ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.xz" ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "yes" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "no" ]; then
  gzip -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "yes"  ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "no" ]; then
  bzip2 -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "yes"  ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "no" ]; then
  xz -cdk "$INFILE" > "$BASE" || cleanup || exit 1
else
  echo "Unknown extension $EXT"; cleanup; exit 1
fi

# There must be exactly one top-level dir inside the submission
# As a fallback, if there is no directory, will work directly on 
# tmp/$BASE-test, but in this case there must be files! 
function get-legit-dirs  {
  find . -mindepth 1 -maxdepth 1 -type d | grep -vE '^\./__MACOS' | grep -vE '^\./\.'
}
NDIRS=$(get-legit-dirs | wc -l)
test "$NDIRS" -lt 2 || \
  cleanup "Malformed archive! Expected exactly one directory, found $NDIRS" || exit 1
test  "$NDIRS" -eq  1 -o  "$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)" -gt 0  || \
  cleanup "Empty archive!" || exit 1
if [ "$NDIRS" -eq 1 ]; then #only cd if there is a dir
  cd "$(get-legit-dirs)"
fi

# Unpack the testbench
tail -n +$(($(grep -ahn  '^__TESTBENCH_MARKER__' "$THEPACK" | cut -f1 -d:) +1)) "$THEPACK" | tar zx
cd testbench || cleanup || exit 1

# Deploy additional binaries so that validate.sh can use them
test "$HAD_REALPATH" = "yes" || cp /tmp/realpath-grade "tools/realpath"
cc -std=c11 tools/wrap-function.c -o tools/wrap-function \
  || echo "Compilation of wrap-function.c failed. If you are on a Mac, brace for impact"
export PATH="$PATH:$(realpath "tools")"

# Run validate
(./validate.sh 2>&1 | tee validate.log) || cleanup || exit 1

# Write output file
if [ -n "$OUTPUT" ]; then
  #write grade
  echo "@@@###grade:" > result
  cat grade >> result || cleanup || exit 1
  #write feedback, falling back to validate.log
  echo "@@@###feedback:" >> result
  (test -f feedback && cat feedback >> result) || \
    (test -f validate.log && cat validate.log >> result) || \
    cleanup "No feedback file!" || exit 1
  #Copy result to output
  test ! -d "$OUTPUT" || cleanup "$OUTPUT is a directory!" || exit 1
  rm -f "$OUTPUT"
  cp result "$OUTPUT"
fi

if ( ! grep -E -- '-[0-9]+' grade &> /dev/null ); then
   echo -e "Grade for $BASE$EXT: $(cat grade)"
fi

cleanup || true

exit 0

__TESTBENCH_MARKER__
�      �=�v۶����@�%eɖ�Įܺ���Ա��rӳ�.-A7ɐ����������>B_lg�A����q�k�Sf��`0 LL���z���7_-5 mon⳹��P�2}�\������ln6�i4[��o���c)M�(vBB�q&�ƍ������8����'�Wт��|y���H�����>�y����{j����jf�k�I�~��������'k��v�D�����o�Ϻ�ˣ�N{�Yyy����nVF~HF��#K?쒡_!��s��@H�~$��%�zP&J����,�T5B�`��%���<?&#���ƍI���\�@�@Q=g�93NL��a	n1i�M�\c	�+��tQ��EШ�ZY�_�a�������ԁc|kc�d��d�����͍�����&�!%�E���W�{5+t��l�p�^�y!��7�Uq���7���0�LV`�U2�������	� d�V�O�m��
8�@AL��B-�5U%��m?�^,(\�nL���Qcz�8i긞�?��r�T/W�MZ9ɓ6Y���`*�ƻȹ�;�YD��L�<���7�P��
i<=��9�^0@Ð�I��#���p@�'k�
")Nld_ɛa�i����QP��&9VH��5"���)�F46��bҨ�����#�Y��ejŠvm�$�q��>�&HÀVQ�V�״m�Z��[�B�^���A��uJ~3d�P`28k�L&��l�P�&�3CY��_�}+�֒��h�Y�H�i�]�<�m��̤%5�e��sL^��7y��0�����K��6?՝T�YN�09MQ�Cd��_��]Z(״���T8�2GrH+"BI����~�<w�����QaW�U�Y���U��++T��3���[�j�z�xR��g�l��	X���D̬5�&7��4���τ3�J����d0��7�;�)M��@��O�~N��#�j��� h���탴��NS����n@%"�c�)|��Y�'o�_3��V<�n��0$���W�Y��6wK���۔�ڐ!���
�;�'+�I�K��-��k�|f��H��ݙ�������&�&�.5E��I˃z*�H�Mȳ&d�����W�!�ڸ���J��<�L���bR��G%���9�ywش�I��?w�y�t;�K�Wvz�dL������+��K�sr�9�_N:N:���!9��8 �H��Y��aCqS9; a_�F�4�I�45w6GL q�O��r�������?3�Y`[�H�ʤ�pE!ڍ�U2B+2�f�p)`���Ĉ��(`~�Y��Re�<8�`�.�1R��dB �����\3hň�E֗M䈽+���Q���x����в4�nej�aI'5�N>�h0�#�6B��'��y�¾6�Vbq�6��f���i�q��&C�?���f��b�y�BJ4�:
+}2b2��N~�{&��rifz4�̢����!q@��rⓡ;�ډ�Tch��|�2�gĊQ�#E.P�ٗ�?"f�{!��hv�����Xoe*�R��՝(�J��.���:�ؐ�lB
\5�!b��KVVT�U�Y[��qH������\|�a
�G��(�=�JŸN��RG��I�����9`�J�څev�8T��~TC����z�f�e?\���YE�N�m|���K�]i)�#Z5����lf��Dn�vg(bN;�P���Y<��"UY	k�8,����|���:���YNB��̆h#vV&�~��Iy�UM�ve�®�;J����p���{�.KxKĘ
M!���'<k�|��i-;�� E_Tһva�J�Oy�`�/��j"��u���4��V�WI�����������Wǂ�V+w����\�������9:�c���qw��Ԫ��;鶗������U{i���9�q�����fՇ�=b,�\���;I@ֆ�j͛M&��čb{H���)<�+br�	�ߙ�-v'Ðz�%���Ow�&�z O��i�?�����O"$�|�J `�lO��q��|���'�i�)�ja;��E툾����7$�B��r�iD?�%֙�\4�P�%������+(�K��^���? ����JNw�<��Q��?���	�Fo���JDfS������j��xe���fX^�t"�;1.Y�r��6(�HdNI�Q�]�����V:�0���`q�.TXQ
�A�x*jyk�^�����T���FrjR��B"�����������b:\>���r~?r+#��
�h�{N��B�x�ͯOixI���c���������6�$������Î}��ˢ����J����'�3��a�(B_��.4Xk���]�
�|9���g�a%��Rw .N��K�C�"�oD�I̶�pU�!�i?'��%}��Hͻ0s�_%9�q֚1����c��щ}��%�2H�3�9����>}���1�	-�p�L}D��>܁�1u��m5��@�KPc������!�"v�	�,���]iZ��$����w�՝E�@XM�ܵ�RI	�z]B�-�$ k.e�5���N8E�3:Py��>��u~y��H}"c�ChC8���Ð[�-���ZW�׀�3�o��<`y���	=ƒkX2 N-NFB���k.�dC��J ��|y S����eޒT��M2����*��gB~�{��g<[m�zF���n��e0�����Q-F�wRA�!n~���,�@���̒���^m�	��O���z�|��V����o-��i����w����3X3���7��"���Lܡ�a=�[�K��?��v.�{���� �;�tDl�o��G���ӷv�s���sr���mW��X:B�u�|�h6��X�(;�J4ώ/lk0��D���n�ʇ����8�?���r��荦q���V��&^s��.��c/j����]s⃏��L#:�
IzYPO��A̶F��t�(��kvl��c�f^�^z0���JQ��̐AF9"s�%$� }��?�]�Qa%����rԅy:�{v�ꄴ
�w�w��m�Yc�b�X����P��;�H�U��`c�{�)c��CQ���ֈ�ָ��&�*��9�`B%+�N�
�@����]x!�Z}�̳ٞk�Ye�-����T՚�h~*dV'�h�Y��HX�6
����dC�E8(n��u1~D-���yg�e1���ǵj�ɩ�=:p�����r�ck}#����j>����N�N�2��;!4��u0��Dϛy.`�yS'g0?Ekhd�\��c5��>Mj<NN������o_k�J�O�֊�Q�z�i#��iǧ���N�F{Xqtr�5-	SlH�euX��d�d�`��9:a����;���D ��o��J��������x��gRL%"P��7v<O:(s�ʄ�b�J䡓A��v햊E�1��QI��Y�
(�p�x����^����IE'k�U#��$n7��k^��Ż�[ݏ��]+���֝d��y�Ps4Ƨ>8üA���c�pMl��,n*��y�xM����܅T('�Pƚ��L��f���6!Vܼ����5�A����;�x��KX� �*?�o5��Ν���F����;�b��Y��V�g<�p+N�#��Ɗ��]+ꁚ���X�Y�RO$�r��4W���[�	�q�$p�y(ml���a8��4*ɐK�$u��E�a�{� ;R�n���ɊV�91vZ�iyE�g���*�������cl<�Ƌ��_�\1��	c)h+��0�Y��!C���Z�"R�m
'MKR)�������=O��E�d(+M-�]�'�P[#�Ȋ�^Oq�J��7�r�G %�Ҋ:[��R��m�\�;��Y��s�9�6P	��	y���L�ʍ�v>�ܞg�����`�`�'��y#2U��^�����/h��ݕ `*��N�G�rj$!���<':}�	�U��-8��	�#���'e����1)]m8�������fY�����+��bzl�me�F.�?��R�\�x�t����\'��S;w[�q���2�����c kM����i�d���պ�5z��s��q$���������K��Ƒ��9�����Ź�Ⱥ���ڗ4F�M~�OON��'G5L(�%�k4�bg�����n�cǳ�u�-&��@�_���_��%d<�����T��� �$���R`X\��*�SUk��+c>)b�CI����RdL���6Q��*l��+�[!&纞�K������{т��+� ,�T����?��gt�����#|����݋�!���<�?9�i��Ut����Kܸ���s H��"U��}�hg���3D-�� ��s;_�Ճ����������3��v;�,"φs5��f��ٿ���S�;
/z������|�J=�ʟ(�n��k@�/�/���c�~>��L�T~
�_ <��%E���#t=FW�\`L��k����oŠf�Y"A �4�3Y\�N����6�߱X�\�9n0a -� ����/�D[�.���5�L�rb��`�ٗ����/_o>_]��Vku}=��V�F�W�����{��kdcu��&>6M|�^l㣹�!Hm�6Z ���b����-|l?�f�����|�=6��� 7�_��f�� ���_q%�o�J�5Q������	�3tJX�0�]��
j�w��N����2ݤ`ݐk����;� ��� ,L�)'�n_�
%k\��hxg����צF �$oS������5��zS�f~�6���ѯ.��^,��̺�){:�\׮΋���'XI Ĩ��b��������/:����w;�U��y��J:pj�uۊ� �O���E���I5ؕ�����4E7���E�g��-������*�|�	�j�_���dؚ=ND������]f�ޔ�H�~�ۆI�P?�7��F_�~�l5���'	��v�(���,�^n�-�h�3+��W�$�P+%���L�:V���<t@M�.�����6�1�����Sǂ�������׷�<H*��K�����4�J�q��=Svt�K(��3��lvώ�Aw�5��\�"=��stwBj��� ��:�- K�AŬ�G���`�mg��4���Ĺ�C��`�N)z���S�z��tMl�FO��N{q-#�]0��;qH�y�d����h���XW؟\
���-ǚG���a��9�(����ݑ�H��7���3z���� �(����*$��LTL�� 
V��᮴���X���_����S'bK���	3_O��\�-�<�GE�IW�/"�Ih��w��)����S���.Mbכ�Eb���$~�`rD%é@���ƈ�^�3�6��, 9�ﻋ�j�h���&,�0�E���t{ߑ�E����~��:�͍V.�s���G��맧��t;�'��t����Bg���lN�=�׉~q �4����b������v���n��>=�i/��gx�ϣ��^j�]o�_G�IW�%;m�����7c��Ȫ�1P���M�Ư��e�� ��4	��/��

3Y"�� d�00���aQ~�I�e�#:�������`? '��t�7�c����!��`��ĭ-�9�V��׍�K�U@����(���T@9|��='����6q�4ī�C|{���Ag�V�֪:��1s|��.������m���:�/�o:'��������/��}v���A��j4�7^��a����z<>t�g��i�����vk3k��P���R���M��������Z΢��543c��;��L��P�}N@g��0�]{:�R/I/�(���*���T��Qi�����cxa輲%�l0�ĶEd�8 2��nr���޳6�m#���+������d�ٓ";�$;��k%y�����f(�񐜐3rbG?&��v���U����]w |��(Yߠ*���F��@? ����q���ۻNt�Е���<(]�).E�\�=H�s���ɵI�5k�a�9�q
�pq�:��\˯�;����ʎ���\H��dZDP؜���~���X�~���n�bs��V-� ^3[�(g(��
	{XY�R%vew��մt�ka�V�W#�?�1F�����X	��SMLA��cv�a+CT��ſ"-,n���WS����(�q�N��T���d��U����=����㨶����	PQ�j�"*"y�b��;�e��ӧ+�.g������[�[�bՕk0<�7����(5'd����U��j��
�V����{_��0KX#��i��Z���b!b+
X	?���ڋ{�۟D1���S\�"�� �֬>�b�ǹ���	\��I��i(ٽ�,İ4+��I��n+]��- �;����9$2��p͇�SS�j���ӡ+�\�*a�*U�&�*������MW^�6��ǿ(P�H��hq"� ��t���H&}�����DLе��/��s#9��ޫ���)6k��m��NE�k���U�>��6C-�H�v�I��'���͋�O�a�Oo��pw�P�Yo�z��Ox'�~�g���Jj��w�8Lj��~�K�m7iǔ�ϩ0]J���ӑ���n�v7�뛟鯗�_l���� �dG�ޝ�Q:��T��ѯ"���%�T�T�V�\�;79Q䞃��0&fޕ�z��VJ���{B��mi7�V�Zbk`e��eM���Cd}��-��ۦԁZ&Q�$���ɏv�J��L�	�U�!ƉSN��l�~D }�)�E����m���t��A��K����x�[�W�}1m��-~S>��~3%���g�O��rZI0`��UK�q�Ҕru�{�� ��lȮ�NQg(zN�̲Q��	�G
U��=2�U���r��!e�K�)땒����5�ީ|W�ZpjR�������\K�D5Dj�6���y�^q$
�Uqh���{3MO��i�*dՂ �)yԄt��K��tW���<��3��������jW�J��B��r'���q�Qj6��lM�Fl�	����C#H:����D�n|���N����4��hAV&��i�`C%��0n��al�6N��oU�{%\�cھ&8��������NJ�uc%E�]�mfU�N��s�;��X����XF*;���)�؄�%��er��H�]H��ƙI��n��������[u?Q
��U��M��Aj�Ua�X���cX��(�@7RrѲ�ʅ�MA[Xy�ըXV�ַ��,e+���P�+D�]v���8%�<�U���A���J+"�T1���|����@ݹ�F�f�Xhj`A��� 
-� R}���1ʨ�5�� ��X
'mck�E��k_�+��5Z�Ug�o釵|�~t@������/zՒG����3a�a��Āv����r{�Ͻ��㓣�o��(��b�A�+�G���H�>�:��wd�KG�?!#Y�|�7<M��51M��K�-�kq)���gI�{|�i��x�l5�4��L{��A^'�X�����ۢm:N��Rv��V1�U��� a�>$�`����MH�R�u��7�n��8R&GN[ne�H7�@�O��@�r�ITς���>��|���uK4O���qok�&������k�	�o^|���T��s�8ӧ�X�s�#�,�{9��s�����R��O�*MKQOnsl�ng2gSm-�	W�����Zm9\�+���I�UM�r+�.-c�	pDrwM��-�a��M0���k�7jx�l�h{�����_��������x,0��d���&?�C<��O'�8����&�O6v�-�T)&
���%m��7jq�D_��Q=�DWP7�W��V�޺,p��Uҧc#�������e��В�j�n6����MO����&t)���G���B!��ȩ,�%�lN�F�� "t&�N���$�W�Tb��#ځe|Ho��ɗAX�"��.�PUM�O���^Q��hZ[��e�˕��шti��/�$�.G�<����������H�ٜ��cV6s��� Rŕ�"��>(mJ2F���Ǡ2�Б�vz�QyQ�P�4Ui���a6�b�Q��"\R�z�U�Ǯ�i�������O�h�	ǰ�-�لW�v��x�f�[���U���R�Ujf�A�	Z¶��R�d�$�d��N��&p���)�.�X�^!�����G�Җ{l�9�Ņ�-��S�$.�AV?���ӵ*��d���t��U>R2��K�L�"��:Dݒ�R��ȁ�d���2��Zn�E��ђ�3r��b�b�a\	��a3uK�>ʎ�C�ld7�dO��a�|В�#8N,��x�9��@��t ��A��~�aŒд�IP0�X2^Y|���b{�dfN�m��
�A�)��/a��H����ט$g�"7���x��&	Ӽβ[=����Ի�Ы�]r�h�N�-�.ճ�?�cgOU�����fP�*��]��v�7W�nM�25��O�^�_�iC�b����}R6��1�������=���eg��S����q]�	�_DC����д%�����<�XJ5��tV8o��J,=��X���Rr�bz@V��zY$b�²HeՄՕ0I�%���Ǥ$��L�D��7j^��d,ӷ��d�Z�Z�Ɠ������f��/a��:�����TMx�h=߮���I&N�x�^m[~ܮ'yJo�)NX*O�RH�2_�0���oM��(t�6}璃�j�˹��b�m��XJ�����ZI䴲JWNU��Q�/�s:<�f��4�G:�O�]�i�V%��£oN�D^V"]��e�+b;5ĲO|ߍ� a6�
3ja�	��A��@��%��7�[��z���� <�ݫҿ�D���e	U�}��d@li���Jk�oE^k2޵��z��^�)،���A�e�2��fՓ͋�4�I����\���7����Cw��*��$�{��Y�n?��V��$�.��h��3�$7��;��ޮؙ��>�Nˏ�m�H|c�9�h�`��r11�,P������\k,L��W��u-�F�<{+�{Q���Jj+� kZ)x��)�7s͑y�\� qV���S��o����4k���0g� /�*���70k艃*��Kb>5�닃w��&��Swæ�r�n�P8lQgU�P�y8���+I�ea�*El\�55ď���3�{O�b��,���Cq����Q�F�-���vU�E�C��#p["��Z��n0'P�`�v/bAx	��`;Jo/GΥ��/ z9Wo��O�T�;2�2�ݓ��X�l*/nK�D50MkI�O&ˋ�R(�i��'��6���(E��#E���i�z4��t̄���b%>�Li�e��%�JD���'�~L�8^�wV
�{p������/^C!'��8๤L�Ǽ���Wo��!Lͨ��ħz��{�7⣠�|����䛕uqA�&:����T��U���J(?���L��%:Kz��:m�4�l��w�u�� ��6���?�Ӫ�e�Bc#k��z���Xǲ�Q��4W|�#�A�H;A�v;GF�H��ԕ��)�����"y$f�]��:B��?�N�YA*5��T*������#�&�4�n���q7&Oa�UG�*�p�1�<��3N
�@)r��%'��/";��'�����!�)��j�T]xnY���e�L�c�D�
�d�,�%�t��e���aC�����Y�����$�_�ᘾ��P.XW3�TM��CDL5D99-*����"5{��_ɡ�N)�*c�G��.sR�.�<��T�w�,29S��{�oɢ��6�ŧU8,����j��E\�R�%=����:xu�7��[����[SNǲ�9��re
�#�G=[ѝrc��w��/7v�o�	ݦb��|NYP��im�����}���n0����w��5\�"]c�;$�u�a�:W,�g�,�����û�vU�憮��8�Y�=��`ꔡ�it�d\���X==�������<��W}�#�B�����S�B��(׶������7��7 �SU��l9'�q�p.��(��s"8����7����TH��G��r:}�0�^�2C����\��<�jԵ���ELY��kb'�����yX("�{$��K42!6
�j!pg�pL�M��:�;3���p�I��	E�y�)�A�����U��3@�"�А��x�֫���!�3Qw�����y;e&���&���}��U2����Wk�J����pP�Aȉ�"�7���U|��`v_�8ޚ+��<�:+�sE�h����ة�Z���&>�O��}�#���eY��-�����M$b��/9;J��9e΂S�S��sv��ϕ��������m'+j;�gPڶX��{�����|�oU��=�[�(N�rӰ�����[i����ť��O>}:���.����]Ы{{��7 k5�+���i�5~y���H'�'u�{iI���\R��LR�J����j���I�[3Q_�U�
�j�l���
W|��a�|��W��٫+�l���{ -��N�� ��U�^RU��b\,��x�Ȉ�Vt�p���ZPf���q�v$�{"�|O���Jc.�-�,����ߪ<� �U�����^s�ZpHXYqq*biV��`�G��%QVk2��XuOwi�|4�x����K���+�W��e��l���Rx%/������ڍGm��=J���/g�PRk���=�3��/ƆZ�����Y���K�䬼�(�Xs�:y��~��o?S4��Exui$L��L�1i�Ҷ�_�T%���;̞�~EjeQ�_�yx+u�[l�9�:>���П���_4�B��e������-<�G�R��g�:�1�����:�X�2���\����Y�6L]%k4��nB���c����a(��Y8	J~�S'��h��8`�
+����� ��ͦ��X�h���d���Kp1f��o��+GŴ$c%�x.�XXf�l��YY:c�)�ĒV���Ѯy���{M8]��z���Qh�����"5��詂Hk=z�GR��"�5��7G<ܾr�e�J,vQv!�4�?�p�Ɇ}���ｸW(���GZ�a<��6J�?,���d����w%�=獋'�~�㿴�d�If���l��l���xy��g٬���:��}}p�����?�Ã㝯{���WG���ˋ�Z��]x�&��?{;�Ǭ}�ט��>g�E���Լ����54�������6��4k�x�o���sם� ���G�@�v��YFmWǻv�����ɺ���vw���C�ն�_��o��j��vc���Ž��pG���F��`#�'�0q��9��2�Y��.th �`w@�
�����ێ]x�L�c�ON���A�P��<�]h���Z�G�����At]@�OK6��g��O�4���$�v]�:�<�xp�O$t�''��р�<}8�!�����]�
���;�9��Eʄ&Խ�G��.���A;�{�& ��;�Eq�\:A����8l�����n�F�r����;a>g���-��!����N���`�s2�C�wpF:�,ԇ&pX�x�0�߻�ƙ�x�A�- �;р-t��ڗ�[�G���X��t�F�p��R۸,b�:���r9ALf�&r���ķ���Y�s�V�ٙ���p70��o=��a�#r��xyp��b.�g�an}W�##gONAC}X�6vB�_�P�67�F`�~��'nAÓxr�����_8��j�;2����#��c��s��=aϺ��L�Ch᫣��ދW��';����T6�����z��j�6��0Iμ��K������`|\��a (�p��c���c��M��;��<���(�L0-!k�l����Viˉ�zA�>�5��*�2.ʔ���	�L����zN9d,��d����L'�jUg̊RƚC}O%��	s\�b���jT�����t�AM}d�ȂA��հզ�� 4j.��>�CAXz����3$匉�����&)���Gp��q$�4��`69��8QS�?t�{�'�,���������:�	RRy	Wt��O��߂������߬b3j+�c��z�"�t�|�s����CCNg�!�gY�/�F�_�\���*̼�����������9w���\x�N�����@��d@񅋓�I(�0��G�r(T��a���Ō/m�\� .d�K.e��\f�jC�샎>�L���(+"0�(D4�.I����0��*|���'"��/�u�{?t�u���a�"u����/BV��b���-'��'*�?a�N����z�v�� f��A�N�Qf��;VW����?3��ˍ�/v6��6�8���>3��2h(f�Ŵ_K�F����A�^�o^�SP��q"�|��2l��ok��e!ʷ� �s�ֵ\6���z���O�p�@i֥���52u���_�lE�y�t����%�\�(��Pp��Y��=V���o:����>�	}|�+
�IE�[��T�P�:�2i|�����p��Ü#��^�.���C.�A.��E�#)�?�q�i*��!] u���w���"�bCj���Bю.�Q�=�[���^�&]l�	�{��~9�0ce#@��Q_�+ylW�0MG���oT	�A�|�/��h��
�J�ҩ��f��{��t2������ʓ����ƥ��:;8���1��[��e���M��������:��"�N�/�+�R�u����u���Bܪ��37s�iD�;^p��uZ�w=�S/ �0��}�|�H��p��÷�:� � �	��i�.<@J���׿��>oZ,C5s�5W,��rm�E�sw�a�҃����D� ,�ɬ��5T�]����@þˉ��.�&}�w׍;�Gۛ;��W�u��*�oHc��h;����č�J���x]��7�Ү�яi~ƨ�h�Twɉ
���T�7QxQC>ub��ec�[���L�.����.���F��履.g��O�f��;)��_n�4 �_d|l~�� ��?C`��$ �10�E^�;|6�|o��(,O
|��B���`���;����ss��n���d�<���`q�f0�x���MwD����т���v�A89�]�BC�䏦�Æ�Kl��&[ P��tV�s��C�{��;$�V0�e3�������6L��z�H5��_{�A��L�<^n�G�ϥ��������x���*�G������4@��>Z�������������r�<�o�W���,v���bgw{��FҌ>��R1̉'z2\�J�3<�<k �����bz��&��숏��{�a��!*�uYLi=���a�E����g�܍J���3��u��SƂ�x�ȼiҿk	�)j�������\��� C�D�Y��y��*2;�@���A���2!`���J�-��`��t&p����]e������=�@��bZ���e�F��I3�f4X�[R�o��+HP�ט�9AckH��[p���M	,{��t�Cn���I`$� L�{�y�����͖:��z����6�4*�X���R��r��${��Ŝ��r���	���e�S V���έ,�i-�Ǚ(���6s1 HN~�dy�K���a=j����æ��;�����|pt�;����x�kq���B��W#7�E'������Äo_VE�� 8*~'�lV?�\/�U\���;�"���F}�%}agg�I|� -	�'�ҵ2����y����E�;����_1�`�*�J�:՚%��b�����w��|+���r�Y8l>Ӿ���?�v�J�󷁌�j�0l�O{�\����5L4��������Th�!jAK+@�������
�/2?����{N���c�~�a/Cg�u�����x�q�%���:��˅����2�hj9
�iv)P!��0r~�@�wn��t���`�CoAD �\��?`����'Vc���.ߊ�/	c�]*�*N�G� ���A�8����x�0W�Jrs�^G��%��_���3�����*�\S�#��Zvc|�N �%Ϻ��I�X��N\2���oCF"������GT l������g��*�d�%�a5MX˫�c��S�cц�����@�Ǔ3��\~C �Ov�����7 �5s����Y�ɦ������C��E��X:B��R`E�~I�C�V$;�hM=��5�����:�i*������ۉo'�3-tȳ������㧦��ʓ����]��s�S/�:�EM��!�-y��]�t&��s�3L����gYqfBb���>��t-���%�"�-����{�w�ȼs��F�.BM��g;�߲Q�h�>MܡO��������{�-tXͺu<�o�(3`:ǵ� _������j�gx�qMv�����ӉT?��^�̝ے�I��1a�����l�v��~,C7R*r1x?��N߹����I,7�X��R�^7�G�;I�nA�ةQ)�\,�8v�<V��k��>Y^^����(8����2+�2+�2+�2+�2+�2+�2+�2+�2+�2+�2+�2+�2+�2+i�?��� @ 