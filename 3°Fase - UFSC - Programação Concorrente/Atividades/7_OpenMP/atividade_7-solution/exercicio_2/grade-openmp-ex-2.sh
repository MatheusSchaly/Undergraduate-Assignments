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
3Y"�� d�00���aQ~�I�e�#:�������`? '��t�7�c����!��`��ĭ-�9�V��׍�K�U@����(���T@9|��='����6q�4ī�C|{���Ag�V�֪:��1s|��.������m���:�/�o:'��������/��}v���A��j4�7^��a����z<>t�g��i�����vk3k��P���R���M��������Z΢��543c��;��L��P�}N@g��0�]{:�R/I/�(���*���T��Qi�����cxa輲%�l0�ĶEd�8 2��nr���޳-�q#�l~D_BʼH���#{�v�+YZI�$'ɲF�H��afH�}L��v���T���я��0`0ʊ��8��3@��h�h4@��&{��7���z{{�	ϗ�r������m4 ť�K����w�]�=�������=�4�	`#�	�P�n��]�w���)�?�뽙���l
V�8�9�@�z�0��ݣ�c��H>SCe�顨ED=���L;�	C�n��?�+KY�D��NVC��ꖮ~#v�����O�D�ݻ{"�Rt��)�@�x�1#e�r��x-�¢�aY-3�4��b����8H�,��M���X�����I�y:�fkR��5N��JU������<�<�3�����g���������[yl�b�UU4�`t�_�x��(`vN���48���
���}�QA������w��_Ķ��D��Z�9����T$DlI+�Ǣ?٦��^��ga�<y��(�'����S�c(��4ʌE�L��@�-H"\?�����x,�JE��$J_7����� ��I��t���ѩ(E5i뎝ӑ+�\�
a�J�&�
���D��&�����a��9ƞ i�+N&�-9��Iq9�I_�o{�̒�	�vz}s��`�wn�GΤ"�q����f������Q�<}��￧�}ޓmF�y#�ٝ���~-+��yJK:<���ý.�P��,�������-���[���N��sWI핪'+DA\Zwc/M�]'�)Y�_R)`����(�#9xt�������o����|���+�v>�T@��j{�m�|�S��E��X&&��S�S)Z�s��䄡{�����yW6�y�[	�#	e��i\3>X#j����5f�4Y�����վ7Xr�6��2�R� ����`Dq�W�'��T�0��b�8�dJ��FG�;L	/���	��ұ����������4į���}1m�J�._��_O�(E2�<�����V��jd���s�ҔrU�{j� �R�ɮ�NQg����e�*��1�G:�>s{�aV�����C<�:�`S�+%��ͭ5���|���pnR$�g������s��"���͟���l��W��~�Z��sý��'�����e՜Xs�	���h�2�4*I��x4of(���o��AٮH�xl7՞JOFY����l�(vM�#6K����C#H:����D�j�R�N��r�l��i�AV&��i�`C(�0:߷�06tǻ�o��{\�c޾�8��<��<�VJ�uc%E�m�mfeЎ�ǥL�;^V0�8�,#��se��ylB���"���R� k/'��ƚI��n�{A��u��-�O�p�dyvqI��hY�6K6���Z7ʉA�k�hٴrnaS���W�KK����l	��I6*3�H�͆Nė3Q�ȕ^e1�O-��ΤSX��������7�ϟ��+��l��u,�Q5�@��@J�ow�Z���:Z#�D~#�K�$m�t��l����ῠ,:�h1Qb����^H���Y�����m���O�t��!�l>{<L�o�]�`���n����=>9:���#@Q�|S�X	\��`�@��I�y��~w�v���q�Hְ�0&/�~�O���LS��ҧĈ5��RB�Ӥ�#>:Zx<.8[7l��j��u ��F���x�˽�h����.�I(��I�lՕ<ˡA§�8�\�q`�78�jB�?�1�.�}B���F�mpgA���y�=ҵ��� ٧�u �s�ITM��?U}������	�hO�����.M��d=/�@kL��f�/T������\<����+�֙�#���^GN���d�e�4b�ڕ&Uԓn�ͰCw&�6��:�*����-��r
�\2W��ē��>�V /-�����nG��-�a��M0��k�;n����Qw�����߻zN�RX^ft<=�d�ݑ7���xt�?8�E�1�n6y|��li�J>Q8T�,IK��Q��}��Q#�DW�6�O��N�^�l���dL���&�$�&Nߟp�˰1V�!3��]�+���������&t)� ��G��dB!��ȩ,�&�lN+F�� "t*�Nb��$ϗ9�T�K�y`��8�cx�e�� |�� 4Uc�k�&Wԧ:����̂2<��RE�hD�4��C7N��Q{%W=.���2�fy�4[2�?fe3�eV�*���$��h�Q�� ��m>*��hg����?�9 ����*��X2��cUveQ*�kL*Q������1M�vQqߝ�0���!;Გ�n8o��,�e��Ju$���R3�� �y	� �J����YDPZ��;���^�?�ĻDb{�̂�z�?H[�����6�fNa���!�Y�$??Oת���Y(���/���8!�����Τ�)`w��!�TJH&V ���zh���H��7�#G*#c���p�`�b\��a3uC�>J��C�ldlndɞ��Æ���ǎp�8�`������U���O�1��V|b�68	r��TTc�)���23�ǖ�CQ�٠{DJ@*�K�@�.�kk�x�5&�Z��ͬW_[|KB�i�diW�ʯ�D�ze���؉���%vV~u;v�T%^�%7���ˀҼ��y���nM�27�$N<^^\���(X�r�?)�}�3�9����g�f�z졣�쟢A���v�%��2�E�h���	��u[x�آzx�5V)+�Λ�y)�~�)��hy2�b~@V��zY$��[�e�ɪ	�K�%u��f���45c��oԼ����g��WM'�kAf�z��p.��h�7�h~	[��K�	����Z�÷����zu};����O�/��I��ۇ��>�'a!$�� �'`fqﯣB�:<�6���r��398J�ţ����ls1엕��ӊ�0��*=z٣� �������i.�tt>�fI�-Z�N;}}����R}."]۩G,{����p��c�aF�X'B$�q�^�a�	��U��B4��b��# /d���//��k*�BQ�ʲo�<[خ5��Қ[�՚<�Z�M=[{/��8#��>���@&e:V;ټ�N�x"�5)��^ZLpc�=��;r�n�q_�s��z�������jlǉ��n���3s%��{l?ޮ�3��>�{��Kƶp$��jAC��L,Y���/�T�����Vj�n,L��{�u-ٛ�Y��<�E9���PR[���.�y>����92��t A��rz���y�[�����ޢ��0g� ω*��������^u�ļ?�3�� �,
Wݍ=�;�-��VtV�7
_;���,P̿��i&���ƅ����a��11�z�L��S�؃,���Kq����V�F����vC�E���OF�M�L@qb��7u��`Ŝ�l�B6.��O������i�\8!�b�� @��ӆ)�Hb~GFY&X�{2�� ΦR�ⶤ� ��iRJn����������x�;h3�_��7�>���ܳ0iQ?��ǟ�����G���'���P�9�=?�	��"0�������~���[:rB	��<��i��W���58�D"��U����TO�@w��&|�=��9-q3�fi[\P���!>�պn��z���0y�vAf��6Kr��:m��,�t�줷�u�� ;xgmL��Q�UqȈ�&�#K��z���X�����z�)���� ��� b��!�
$lj�����'T#O��b��ҁP��I�ɬ �z��T*������#7&����|a�nL��x)���e"�e����R�����
��	�"��u0�?K&/H�~�3��a��������-�X^�^��L��tL�(�a�acŐR�f��\/�.��RgIF*���@���1}�6C�q���1��h("j`�!��iQr�d�g�ԼN�HfP|���|8�P�0�1�;`��Ii���nsq�5�Ȕ�Lz�J��ES�mn�O�pX]o��D 7Z�+��R�����ww^����t�EMy��ܚ�p>���T�+ ?�يn�S��>�z����&�P�m.���T� ����q�-Ǐ��j�;J�J�;��5T}!]ccwD�3�Y�[ٹb����b�M�3x�T.+����G[�g�L�0�5�N���ןLյ��!��H�sKD���/���x�?�r=F����ev틤�R氬���
$d�i�s�s��bI�$�]��&>NN��(x��_N�����L��zW��\����rԵ��JLQ[�5��яv|�7���PD�7�H��,��$��;sFSJm�7����0�	���ܝ�I��@�r ���;b\�}rA�L_Sc��Y�ꗁw��zU!��cwH�ԩ;m����y;g&���ư��}��z�`�e1m.&1�V������qr�L�_Y��W���}��xc��v|���X�؜�kE[̷6Pf�:�}C��ć�i�o	D�b�A�,�b���<�z|Z�ɇ����f_&�e�2��)˩J��>]]�4���\�J������d�=X@in�$�{L���\S>߆�����-r�wN�wrӰ�����i���ߕ����>�lq��m<�������of� ��Я�y�9��e�+�O:�oU���ｺ��O���j˔�����STZ�'ŷf���V��
\�I�E��"�������^�e|g�nȋ.�����9s:z 0��b������������w�p|��?���"]�q�<Q�����8>�ҘdK*�������Z�J��,�/��1g������"�f�8,�hQ��<�jMf]����.�]<͓��o���������__y������^ɋ�;<��U���#g��T�Y�r�%��|F��T��w>�f=��E@�fM���%��YZ�(�XK�8y��~r��7+�v�"|�0&Y>�ɘ�oI����f��f�i>�"�eQ7�j૴-l��A�l�)(t|�����������5���2�g���AJo���īĬ��~��Ђ�j�9��[r)z���!m��J���OݘG{�&!i?��P�`6(���:F�Z��㩰ܡ��r?m*�iP{Q�빉%��X���g/M�cvX��娘��X�?��?���[��c���ØJ����|}Y�k��+�#�.�r3�,e���q�H6�l�TA$�>�#��{���37C<ܼq�f�R,�(����럦8�dC���s��V�%����%��(��|�>���h���wO2��L��Lp�m��i�?Z[[]��m<8�9�x~�������atC���_][_K���V����$ξ���W |g:L�	��<g�����7�1XQX���/F��M#�����B��zP�"b>��#�U��g#'��w����F� �����t�.�`F���W*�/�L+6˕_��:���<9�(���rtD`�P~{����OFN��Nbl�sa�b1ۍۘ��x���$t�}���	��qGh(g���0��b/y��PL4�%_�n����,�>|����C�Rsz7E���!T!�)8�8�AN�	��r�B�L+�����X�/�~!�W�4Al�n5�{���8M�{��|�C: L�ᘁWo��ة�#u�b���%�� ƣ%jX�^�G�b���No� Y����	r!�`�ɯz��c�U}���*�ǥ@����+�p,��z��qOD&Ao���o%�ӣ�qpQ6I���{�ev6Q���KtԺ���l��P�;
v��e�.zW�~�Bq�ǘ������|M���O�*�O.��񂏽��\q`vL3��|٧�>�%A��lX�'y�5- �Z{��/k�O��|�Y��a�3x'��=Z<�&�AVq�
r8#�u�RUt���"�x�j(�(C��J��=\^WK�H)3Ր�Б�QXYQv��ǩ��/��!�g���g5�s���paF�l`s���S�f���JHm��n�Ի�� ���4��� �Ȃ~քA�_�'��v��L�{���Ym�������qZП&AD�M�ƞ����:�g��B�M	��H�aC��!�����H���c��qF���V/;d�"�y����З^�1�ƀ�dj_��h����Dde�s�,X�F���g$�2MQ��G�8f%�<��M充��_5���$'��������Xg���v�����v�����w�|�y*G�����Aߍ"g��`z:���܈������S���[=	]oL��а����B�qþ�������?͢a������9��C�w��q6�m_�(��D���D�U�%�E��z��OFn���ٛv�)�ˆ�$��.Ղ��"Nѽ�z2Q��Љz�+��ܜ3}�f��`�V0��Q��`��Cw����g���#<q�G ��`��>��G-֥�p�`��?�������Ci�����`*B?�����(�����@U��Q@�ű��՘�8��%��[���ϼو.(	pp��L�7�>-�i=�f@鑫ux&�[�,׈+	=� �Ra��~b\j�-|L�����!�`N���?Õ$! v捆�(���1��5���>�D���p���r�3s�3L��'���0��O6
�T��sZ�����sKx����`����{|���k�5a^V2���[{dTЊĉ��2BG��|��=F^y��`�r9�*LX_K�/�1�N�������2n��'��5�h��|�I����
Q�]O�"6�H�d�U�峄Kп�7�`��aB�I�rd�La�!�,�}V�����M`�E�3PUȁ-�1�p<��.���|	�?(�ڝ{W?������5z��!^%~�UU�P�Q'Q )z��`���g���2�j��o��;ǓZ�w[��D�'��������������������]j�z���+�M���AS�!Fw�+v���'6u]�tX�8�`fbb4}��+�_/N_�l
݂�����h�g�֭�eہ�^����$�Bͮ@I���gs�e�Ti�a/r"P]��;����C���]��Zf��;+���d����'���9O* 3�@A��G�3f�!���Cws^'R�P�L:d�'`x%-vc�6j��sBl�r��~�A7*ri|7��(�p'�I�Ֆd��b�Ҷ�Q?0�	�P:N�
=��  �u�<V����h�Q*�>/��-<�O���o6��k��z/���o�����'|qxp��Mo�w|��h��	���V�k�$�	��?���ǬyLܱ?a�s�<Xa��̨��#�ݫ�_���Q��I�r�7��T�L����t�#��l,�v��Y�ʞ�wE�.���/����N��.X��8q�����#�X.�OR�w&.p3ǋ��8�.@J��`�@������ �,0l�=�?�&&?�\�	�Ok����i�i 6@�/�/�!����d=�Y�l>�u�h��R�͠�f>�A@�g�ۄ:�F��������f�NA99B������*`�l�>�D<���;�94��L�C��t:�h������d �5v�퉃mgp����̦ASPn��<w�ଠjhÐ���?A=���߁�����ә7��-�N|��������muh��8����ҝΤǛ�j�P�	 ����Wݭ���~K*@O�n����zJ0D� �D9	�qDf�&r���̷~���� �ml�3�i>>����`�K/�r䷞m5P���Ȏ0��1��td�L��i4e�k���V �����&`�_�c'j@óhF;�R�P`�T�^-���_^�9a�j0�;�Gu��8V����G[���/�o��<'�x��3e2ذ.J!;llV�i	�&�&ə�~>��_�a9���8j/�_ J+�������`����.���ຓ�68���^KȚ[{�`T+�ㄯ�q�.�57*�2.ʔ��/	�L����zN:��)?����`�Iħ�1KJIk^���J:�9�1s���!P�vd�#8� ]�AI}d댖��_�M�.�����w�� ,}D�Vd܆r�D���*�R�j:����H<big4j0��E��|��;�����0�ei�����������%��_���:x��6����0�[����r�)�]2�prF-non�6"���_�n�w0�bV�O������9w��]x�I�����^XQ����*'!�P$�m,3�ȡ@�J��mF�WmTEj1���~IU�B��e!�6�>��/�R8��`��ɁR�1uIR�_�|r��8��߫#��{�C�а��B�F������	�� J�Q`w�D�>���2
�y�ɽ��J�O�:��o�7|��lރY�zP�`�Y���UU0U\��M>���rw��h���l	[�3,�+��b6V��J�>���;90&�yNNi�Ք`��2���\�3l߲�+w�!ʯ� �K�V].�\0y=�t�'Q[ف�h���'ZS S���5N��ה�T�t��_]e���JQ��$����/*w��b�$Ӊ�i0y{��8���~AA2����|���ġ��Tc&��ꗩ7	"���s�8^� ���c"���0�a�|ɪ�!N3MIp��!P��y��Lo9(b)7d��\(/�Q���G���^��(�z��y�_�7��l5�Ej]�c{�i6��P!p����DW��K�4��D�i:Utm�Q��g�N�����Z���ۺ�"P,`���c୩۟b�xK��4�2�.2�OC|�﫸�H:Am���«ւ���_�ju����^.:s�iH�o<t�*��=ϟ8���eUH�CC8(��F#����B�πB����'U� )���~�z}޴PCS�&��M����=w�-Vs/<p�mp�ǖaY�g�`�u�,v�%��(2��	�F�M����4��Qw{����F�h��ؿ!���m�y8����č�B5twp�����LhW��G䁟�p'č0W��cR��T�76x�B>u"���1B��^�Y<�g�,�ųx��Y<�g�,�ųx��Y<�g�,�ųx>���D�  @ 