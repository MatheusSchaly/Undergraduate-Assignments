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
�      ��R�H6�����	���/v`a'��P��L-f\Bj۪Ȓ#���/�%[�0U[���~l����H�0���}������JX�������b��mc}�������T�^���l6����{�z��Ѽ�_�����Ď ��>����p׍���$��~�E����O/��E���yd�*�q�$^ܒ���m���õ��=���������/��z��
?��<�>}��n녧�_��^A��xm� �C��@����lA2`���%����c�� 0g��P���0�^8�%C�^x	��K��
5���3ӱ0r�KrK-��PL�ENrÀ��ǌ��
�*��v����_un��q\�s��A�}r�o�/��]��^��c��7q�zau�]л"/�O���w��X�]PW��.�N8�2�@7)�'ep0�$�쨄@�VA�d�ۥ%h� #; G�F��h�"VP%,N��C$�y�%l6��Ԅ]�>ih{�I?����̂w*ʙ4K-h�Nj#d*�ƫ��M�*�4���(sDǵ��fE,G�Eχ����(��D?��8Gk����+C	U�Z��ľ�7&�Y�>������M{��8H�ePH��c���a��!�޲���eYS�Ay6(�]]��=�r�fQRGm(Cmu:�n��V�ؚ	� �N��%@9�9�M	
�%�dLg9�Y/���,09C��wn�����uN[�4~+�&!�[��ї�#da���f*I&�bfn�H7En���7cR�~���֤���d��{R����;Lّ��{�0�L�fD���jd\�Ղ�Dz�鸓�I�<�+ow+�U��NJ�sV_�S�V�)�v:��O�NJV���&-J}��筏y
��ܝ�y��|`�`�%�z�L9��l���$�gv0�6w�	k�~�M�'S�W�13�g����>��GQ�L89ޮW?�%1�Bܝ�lK�8����9��ki�g�q�1��Z@IU/���9\Pχ�^Ѐ�z^��2�D�v�RRER�m�r��,�j�䞠�U_MG*6%����P��3F�*@:�L%Z�&�Y���Lb�{����z��W�����TZ��{Z�����|��$�z$8��H���&Uq>�NVŦ(����	�ɧFe8l?�<j�?i?yO/�������5�#tT	�*�aY� �V�
v�{:�ᤡ�b��+b���I���@U��&xU'UͼN��-}MdZ�ڼv!�#��(����G�0"C1f�����e��]�(ǈy,�1,��aH��ϝ��}�+�P��fE_�4�#YW?x@�e��)t�(��t�r7���S�Yi/�s�0f�R�>��O�>]��sC����ccOz�5��ñ��S!¤<Cn3��o��E�히�R�d��%?�=Wk�ra�����@3���9N����k'6��1�j��`h�h���6X�!Zw��G�n?
ǣ����vĺA<>M���N��M�L�Wys���#�Q�8up:�3��Bg�I���pYR�@�}VVt�u�Y]���B8&	ߌ���p�s�),�љ��ە�J'�u�Nj)w��Z'�2�zN�#����-�\�8�#�?�����r��<9������Y"P�����\��JKj阦�T�a��8k�3�H>�C����	��_��GQ�8�50��;��⟢8�oȜ� ���
��H1kRF2�D��ni��J&r��b����}S{:%|����u�o�3�ix�!}��zO�mMrZ�\[�	 ��ZT�;�0�*'ȧ<�0��&�vs��&	�����
����n�����vY����ۣq��_�1u������8������<B�~O�{G��b���ū��V�)~t�^�?k�
O��'��>��U\/��@% ��zx�R�U���c�/|/N�.��6.�.�Fg`�H�y��1*{���U4����0��T*#|"��A�Eqz�+?5!��$������͞`�-����aq���B�X�)qw���ɠ�\���JG��Ҙ��"7���}�FP�&�W�_�`;5�=�=�kqJ�p����
}�q|����xC�S�G,�7���C�c'�V��������	��e:�؍W�	���/
���E�3�غ�k3�v����Md~�w�%�_{H���\�<��������{ ��Xs]�;4Ҥ��!&!6�|�L$���1�Xz%alL��z<B?0��z��
=��;j����o��?z~eȢ>�n��u���1��>l.�������³��'��WG����{�P��������=2$xqLU7�#�r�p������u�����G�c�=���WaҸ�(u��V�X\vic�u�B<�~�E��Q�3�c8�=r��N(��0����>K*��Lhg,k�o�Ϟ�w��>��~*��<�ѣG���/�7�A	�Af*=�C�����]���VZ P�%����������Hl�'���i*ؕ�e)"�,��yRڼ�ab�S2rw]GTa�a>�����[�֕x��k�Ԃ�N4$�'|���_w�S�����ZV�GF�6����0|r����jLC5u�s�͉��8+�;|�F=As�z��gX�8}8]��=%.W�b#O�8I�Ňtܑ2.<���;�2���D�@��ϑ<7����1��6z���,u���.̀�f#,=41s��� �	CDA�෗���ts+L��|r r��Uڰ�v����j�2`;(
��C�,��پ��	�ƃ[�qM��VkN������E�������ժXW�G�W$F!�̖�~�~� �ÑG���Q�e�� �=��E��{�9����˸��Z�����������$��1�R����'��(>ʶ`�۪y[�!�膕���	\����c0gcl�mH�4�p�Cv��Ma޲(��q9�� f���
yy�]��������n�ox' �1������;R��T��p�R�w��!���]k8.s9ǰib�;2Y�r��O�$��y���7�8��/0�~���g��`���BU�!���YԒ�SI��U�X��i��y��3%��POL��}�ѵQ� �7���қQ�����\�W�R�ϭ�N��;����s���k�%��6����p�q���{8w��˴J95.QJ%��8��ey"�I��l����,��o��L�߇cky��>��RV8��l_�c��Ҵ�ΰpa�M��)��?t�Mz�*_��|6��$E�K+�h\bpz�ϱ7a�O#�Y<(\~Ĩ�K.�'�B��?��9^�T�g<Tw�q⢣Zr�j�(c�5��}3���@����_h�����b��`�h���H���)���G�U�C����J�j^���ɫ�B�D�O���*�Z�*]�A��Z��;��N��^m�W�x��MN�й������S�(@���2q
	�
II$�?ce>�{��a,��sD��oE��q*�8'a��9M�ɢ��)|�sӎ�� �+`c�4���
�A9y����XP�|��PO�+�,���{+�3�+۲<c��/���;R���D���PT�|1w5C��_��]��u���S!�}�����/���*�~������!w�������`�Ɲڡqc;(��g��r�-آ-ڢ-ڢ-ڢ-ڢ-ڢ-ڢ-ڢ-�m�'޼� P  