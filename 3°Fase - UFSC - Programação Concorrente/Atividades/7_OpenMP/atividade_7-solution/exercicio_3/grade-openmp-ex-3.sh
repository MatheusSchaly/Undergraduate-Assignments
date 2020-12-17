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
3Y"�� d�00���aQ~�I�e�#:�������`? '��t�7�c����!��`��ĭ-�9�V��׍�K�U@����(���T@9|��='����6q�4ī�C|{���Ag�V�֪:��1s|��.������m���:�/�o:'��������/��}v���A��j4�7^��a����z<>t�g��i�����vk3k��P���R���M��������Z΢��543c��;��L��P�}N@g��0�]{:�R/I/�(���*���T��Qi�����cxa輲%�l0�ĶEd�8 2��nr�����n�m#�;z
X�����N�v׮�um7�]���ζ�mW�i��(�$�i�0��g���qO�}���3�@�C��9�9m,��03���G�ä���탎�wr�}����� Hq)�jp@����P�Mr��(�3��i%`��	ʐ�n{�� �@��Slt*;"�{!��yZĴ�9% T>̤���ѱn~d��h�b�i��EDC����=ʙE�m��?�+KY�Ğ�NQC��ږ�~!N����$���=�{"�rtj�)�@�x�1�be�J��x-��□Yu|ZNL>G�Sv�z�H'�2V�6WG�	�H�Qm�*5��	PQ�j7����X���L�_����O>|�_������������X��l4�^x�-�8'@�qB���āY���}q��m�x�������ֈ.q�
sr�D�R��5������ڏ��7�G1���[\�"�/� �6�>�b�I�B_T���҂$���4����,İ4+��I��^+]��- �����$2��p͇��P�j�֛:�O8��*�M4t-u�*���dc}��(Q�H���hq"� ��t�g��H&}��0L
K"&���̍���x��Ʌ��˓�/(6k���m����5����χ�w����^��ZE޼���)9,i��^���JV���������q�����w��UR{���
q��
���J�m��b�6�WT
�.�u�	�td!�G'�;������'�����'[��bi�0�9$ّh�q4��8�E���e�b	<:բ�>W��MNy�{܏Ɂ�we�Y濕۝pO(��-M����QKl��1���Ҽ�;A�W��eY�mF(e�.A�����h]Oҧ(`�I�s1N�j2�Hd#��#�Lq/JW&nԷ�S3=��/��/?8I�W�Wھ��މ��ߖ���ogD�"����@�XA+Ylճ
c)1A�R��wOu�T�-�U�)�E�i�Y6��b�u#%�H��soHf�� k.�=ģ�s6U�R���Zs���q��J�e &E�|A�ύtNTQC�V�����֘͋�#Qү�C+~n�7��D`p]�g[��Z�� ������v)�&qM*�ƣy3C)w?�~�vE��S�Z��TZ2��`�Šf�]@�i*�y.,��o� �2��QK�;!�"��i f��Yݘ�ۧ�;�Ut��h|�
���M ���k�UK�UpU1�E���X�b�Ns7�[(��M��q���E��A;�W
-�t[������Tvr/.���S�	�Kԏ��^�K�l���u�=�6�Pςn�ڨj��=Q	��U��M���5A�j�ua\[���[cX��(�@�R
Ѳ�ʥ�MA[Zx�ըX^ʗ����<ek��젲P�l��|;%���U6���Fo��6*"�T0=�y~���������Z-�aE���1�f(t�Hq��}N�ЈQF������~�ep�6vv?�zc��aE�Tؐ��XD�qF��~X{!���AD�{�x�E��r���C��{*�x��;=@�L�l����������ᗻ;�.�0� ����HFq��1�:/
����`�����d�c������i~�7�4E�/}�A�X�K)��=O
��cCs��g�M;�ʹ�.�u���_o}��+ڦ��+2ʮp�*Gu5c94H���K0��Ú&$�Ӝ��2 :"D>n��.�q�L�\����S ];\$�>-�	��N�f��i��M�'}�LP7D�t��w�h��k���1q�[_��E9�h���x���WN��#�,�{9��s�����R��o�T����4sl��3��)������o��~V[��[�
rE�x�bUӧ�
`��ΡA����P�lA�v�ks�L�<�Z�7Ɖ5�b�|�����x��zN�ZX^t<=�dҳ݉?�/6�(�?<����7�<>����S��(�N���vѨ�iM��Z	�v�+����`'d�=6���Uҧc#�����&�(�q����W�+3���n+/��2�g0��h�;wУ�5
��r�T�L6����m�:�x'�BE���g*a�e�,��I�͂><�2�Yd��e����)�p�+�s�J�cfA��r�"j4"]�������娽���t\�,�l���?fe3W�""U\*R�J��֢$#a���*�
�hg�_��?�: ����*�_2��c]�8ʢTQ�kJ*Q���u��&�O������܉\L8�}��ΦD�l�N�`7�mYdE�Rɥ�)��̛A�	Q�v��R�d�$�dV�v��&p����O(�.�X�^!�����G�Җ{l�9�Ņ�]��S�$�x�F�(���ӵ*��d���t��U>�fd�7VҙV'D
��u���2��H�S�@Qm��-7��E��ђQ0rA2v�L݌���:l�����G��c����Í"�S2|�0�4����>�y���2=�H|��m�q�ΰ�Ҵ�IP2��伲��O��-,��9[2�tEj�n)��/a��H����ט�{�"7�^A|��#	Ӽ���T^=��%��`�n2Z�_˱�����v��J
�hKne��J����f%_\��5Y��3?�2xe~���`�-8T�|��c K���#(�=�
��BG�9:E��T{��Kr\We؋x�6ը>Wڶ$�Zآ<��k��T��
����K?���hy
�bq@V��zY$b�²LeՄե8��	Jj���II�V���p/�7j^��d,�ת�d1-H�W�I�"{�v{s�f���(ݪ� uZ���ӆo7�����q���n�WF�Vo��I��ۇ��>�'a%$��'`fq�oC��*t��x�ҍ�z�˅g�b�m�m,%�B�G
�e�"rZY%�+�j�^�(=(�s6<�1�o�+"�'�,�M�
�i���']*/k�.��*ҕ��b9��A�E�0�Y���N�H^#�^�a�	��U��B4��b�# /d����,��k��BYB�m��S[ٮ5��Қ�[QԚ�w����(��#�}Ps���lX�d��;�k�S���,W{i1��c��]o�%^�r�Ns������C|Pk5���D�g7��㙹�x��=���+�L����i����������v�[����K���U��8J-<��I��r_����е輕��(��x%�Ux k�R���o�#s��Ib��Ӌ�F/��:#3h����Üe�ī�i��_�XCOT{�]���ͼ@l�<���u7�4T�Џ4[�YU?(�l�rγ@5�J�Y��JWFo-���]b`5�L��S�؃,���Kq����U�F����v]�E���O�F�=�LH~bx��x�$�C1�Ŕ�~Ħ����,Jo/M"���/ �����vO�L�;2�2�
ݓ���Tj^ܖ�D50�J��\���P6�~UO6bm��+Q�f�[G�.<��h�?�t̅�V�b%���h�g��%�ND���'��K�8^�wV
�18N\k�K��'/����Jh<幤L�Ǽ���W���5!,̨�ħz��{�?㣠���,����7k���mt	PwU��[���JSP~@��5�� V�,ٝ��Y)���ײ��Zױ�n8u��ڔW�"O�j�M+F�T	�cVc���n(��i��
g҃0�v���^�������+7/3�?���e�H��F�w�q$��&��Tj��)�T�	ta%�GnLXi���ª�ݘ<��RT��L�i۴x��S�J���9ᖸ}�ю�ߟg�$|����<�j���SM�e����v��3����:��#l�0�p��O�	v�]�Vf	��� G�I k�옡,\��f�3����Xh�
rZ�"Y��"5�Sx��_ˡ�N%�:c�G��.sRڮ�<��B�w�,259S�^��d�\j����:VD�c5�ȍZ�*.�)0IO�����<I��� 5g�VskF��X�0P]�� �C��g+�Un����p�����M0���B,X�ϩ&* �4Oo#��Ď�P�؛�������.��K_��kl�M�x�:k��՝+��/:�����챀wL�a��	q��>{&/��C[��ɸx�Y��pIWF�H�[ë�đ��p����k����v>��=�o��J�Ê���*��-�5.Υ�ՒzE��ݞ�f>NN��(x��_N��NϏP&`���?� Wk��G�u-!prS��5�SЏCv|��yX(��O|�E�2!6�z!pg�$��&��:��3�����$�ޜ͢�<r���i�����u��3@u�i�FW���y(���BĥawH�\ԝvz��A��]0�w͉HPSXF����O����}EL[�Iʫ�;�B`�9(� Dn���+K�U|��dv_�8ޘ+��"�:+5��Z�6��9�.kA?��7�~��[�X�U/��X�o���V|D�6g#z��ٗY{��yp�v�R����WW,M��5����m;+j;�{P�Y� )��@t{�T�/�ᭊ~���w�\����Nn����ݡv#mT���������,�����z��>����[/�o �J�W�M�Ӓk����N���{aI_]P��LR��qfm5�JK����L��Ǫ-[�5�A�H'-��a�� o��_�w�ꊼ�`�M�Xx��)��� �)m��T����ܞ02�n��-��bG��C�k.�E"�9ޢ>���+��@���л
���\T�>� ���8������>�bW�Ҭ������K(���dѕ��^������<����� \������'���d��r�����J^\���k_��|2��;J���/g�PRk���;Kt�����P�n�7k��U�p)���WekEg�#OR�O�v���ơ]��.��I��i2&�[ֶ�+����Y:~��szOA��NY�ï��*u�.[m�x�:~�w��?í��i@�����%���-|�G�R��{�:��1[��_�����e���\��j��K���%ڋS7%����IAڷ�0E�,�O]%?өSt�5@+0F��U���iS�Nc��؋v[�M,Q4�BE:{iꥸ���7x�+G�<5H�J����󈭳�6��b�q{�O�7�ܰB�owD��޺�+�/73k�RF����g�� �FODV��C>�
��1�q�:�
���+�yf��������i�CM6��[>��ŽƓ���՟��ͷQ���c��W?|���n�������	n����7��Ǐ�-��6�?��Z>��c��Q̼(�!�b���~h��_]��[y2c_�f�; ���s{�6�٣�ó?��|
Z�k���������$�ߑ��*f9�̣e/"�s܌0�Y���h>q�ass���Ӊ�.S׉0˅�`"���a ���ͨX����a�_����o':uyqr��hg�/Љ�-�'4[Qֹ8�츻��9`3'ě��y���C�v�u�-�-�{�&n���HC�!vD!v� ���Y��%�`=Ī��ـ��5�v2�wQҊ]����FP�OL���*��I"=q�D#9�;B�(El_���to���f�O�v��Z�#�[�6�+v_x�+|�{�b&z��T���<�_,%��,��H��7a��RmYIsb �gpKqW.�3?��Y�_�'ʨk@�ᗸX�|��[m#�M�7&�G��}5+��M�FkI����è� ��>m젯�����Hwg`��������}��k�ϲ��{��u���l�Dr+(�6��<k=HR��Ap��3ūwP�ա=����>m�e]�҃��������i�oKTֲbil;/�뙅{k��8DJ�����䬅��y���tV;�ȣ�Z.'���&�5�y�|���DRN�,�=UZ�RiYdE
	?k�"�Ҏi��=&s���#gz֚eth��X0l���IQy�=.^�|��y""ќ�i8W�y����eW��b!{c��`�W1I;86və�]#0>�z�Q@@)��rj��2������kH����A��U�MDV\C��m�|�5�W�	С������xܖh���_:i�*PS��U����3�Mq34�!��H������������ã�����A�sA�u��E�ȋc�a\��N�Lǔ5"���_�{:�u��n�Wݾ��j*�q�$��)ŋ��E���l�?����:���&�xk��**a���$���� "w`������4�TZ ����D�	J�0v��ċ�Z{�M�A�ړ�hC��'�/׆��"�+���"R_�&a��}�W@���-@�	`���}t�H�'�ᱏ�Y�:���� ��w�����8���Ϟ���������yy�a��A�%t������M����hj$9
�-v!P!u)O�o�����:3�a���₌ �����>[�m���z�[���'m��="����#"�j�\��.R8a��~b\���&�s^�)��(B7w�8�Gs����A���1��Zb6C��mgǋ/|87���^D������ܰi4��:�^�qY�4_�^FHmE��Nz�q�=��8����N'��1���
_�R �L�ǹ{�y�YȂ��	�S�f�. �D�X"��$[����`.�� ����:�.ǋ�j����`}<�?�3��x~RǱϞ;1^���~y�J��0�����J'0o^x.�f����-�����sZY���@i�m���~Η1XN�d����������x�fj>yR��������O?Y����swep�O�N<n����7�=�Ό�*�W��_�O,�<�sX�8��L�����+�_�/O^�<�1q�)��;��'�۸˶����'_g��5�
%i^�)���R���U�E�~�4F3�<XS<��wX�E���\��q���qc��'��̟87@j��r#:0�xΔm��
���)L?�H�2֏$ш�ᕔ؍9[o57�	��ƙ�����Q��ûiMD��7�I6|-��)m��"��a&8t�T�������X����G�s��y9�o���t���fO�����p��xw���݃G��xqx���p{x|��h{w�?��y�d�������c�;g�4���9����^f����������1��u<<8i7���QɁ���i��x���Fx[��j>W;6ȗ�����ХKc��8����������&N��E�;��	q�����������1�������s=��`~�������4�z�S�����s��7���:�����@� 	�A�zGD#\�t=��$��P��s`��be�mo������`�k����o�ɏ��fs���a�c��#�`,�_ �@� �T����8If�����B �S/�<18�3ynϙ'aOPn:��w�MA�ƥa C�B���\zϟ���^���ӹ?q�:���șz�3�1F����a`��AZ���%a�3����k 4r"�����lwkg��x?��e����@�fZ�r�5@"QN"g�A�$j"�h(��J��;p��&;s���Ǉ������	*��:�~��,�zvx��EA�c ;�(��L֡#3'��qf��۸��W@<d����h%z��>F�_��|xD��0l�q���Ʉ� /֛�{-˝��6�	{�.����G[/���<�>�;< �x푓0�l����7紻l������~>����a9��.�z�� PZ������Л��-:�в�� ם�n���\�x-�����k0�Z�'z�Ow��y��PA�qQ��lwyI�gJΝ��w�ȡ-;�I�G��� {����uƬ)%a�yu�;*�4���1�
b�@4�wԑ���>�mF;���'�M��{~[�黙���P�>"i��V�1������Խ�g���!H<big2�2�]��1)�B}����xf� �`�0�ei��&HI�;$\1Iڍ�o�`�v���Ã/ױ�ކ1�b��Q:�*��2��E(�P`g�����&�a#�/�E�m�nf^�jb�Iޚ9����/1���q�G�(P|��$d�$��a��9�T鳿�I��bƗ6�"W1����KYe;�Y���P*����>�J�0ʂ#��J��F⑤L���|r��q(]9�|k��u(��P�"�@]�+���Ag�Gh(����7��`1
� y�ɽ��J���:��o�7|��v7���{���e�aML7�x�϶���ut���i������UAC1�.��F�0|&��;%0f�yNIi�Փ`���:�{!�\�3l߲�w��!ʯ� �+�ֵ\6{�������r�Bސ�����@�n�Y�s����)7,��9Z[c��勢��GFs/?�5��cE���&��$��������W�� ��\EdN�T�P���2)��%�ga,��`��kD��{�!cd�q��g<2ΐ�Y�>�y��	�4���4��}E,�kܽ�;��3J�{�h44ыu�Ŷ�B�s>U�3V6�+�E�����5�tZ��A����G3}�@��^�E�s HL+MF�����7������o�+0��<^[��m]�1,,����c��%��n)�<Ͻl����I�ob�u�rI'l%kx޹�e}x��ǯ�|Y��h��ps�v�O#Z�a�c'nҺ��3���S��-���( ��.���%|
�P�s�`5�|�I]x��`�W?'��7-������+Lp�6�"�����Y˻��x@����j�e;���:�@���(�D��.'�+�l����s}��_�n��<^���j��oHc�~s5g�۾��x�V�����տ������,�0Fn�Dx��Vr�B*����
/jȧN���Fh��{2�g�,��|���Y>�g�,��|���Y>�g�,��|���Y>�g�\���M{ @ 