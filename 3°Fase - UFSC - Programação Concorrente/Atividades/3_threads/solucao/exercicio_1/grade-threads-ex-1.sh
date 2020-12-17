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
�      �=mW�8���_����!����]�.g)������I⧉�������s??��O�?vg�bK~IhKٽ�A����h4�F�ȍi�S�?Zy��R���>�k�)ӣf{���h�V[�G�f������};��4�b'$�3��nT7���h����}}-���o����^R���B'��^?v};��Wכ��__m����T?;������+箷r�D����;o�{����ng�Yy�����iV�~H���#?l��_!����@H�~$r�E���L�>&�!YP�j0����'�K$��y~L���<6$��&{���\��z΄sf���!��b�T�,$��6�W4�=
?�8�읋�Qa��¿���8����;�����j��o�VW��}�a��Gz�z��t@�wQ<p���vE�
]�"�7��z^H/�5fU\/&���'�)��q���F�0�Ĥ?r�* Y[�:���N<F�c��Pi�CU	g1C��O�
W���:tԘ^#C�8�g�'��'�˥E~�V��B�C�2S L�C�x9t�<�Hbw��SϨ1B'�3�Mb�4��i�
��aH:���R��iا��w5R���6���M��4S�g�((	�a�+$N��Dy�N"��I1i�H��F���,�ʁ2�bP��B�8�Z��q�a@�(H���i�h�lc�������-�(���(�ݐ�l@��ା3�}�YC�S�dYdI��~m�YI���%�@�k	��@�J�ty � �>�IKj$�0��5n���ad����~��6?՝T�YN�09MI��)��wA�J5�侺"��ˑЊ�P�����j�8��v��٨���gU�Y�wzZ忖��HOO͓_?�Z���hR��g�l|�	X���D�l5�&7��$��Zτ3�J����?��7�;�)M��@��O쳜�e���������>���"|1�h��?�%���:�-��>y�󚁈���0v[g
C�CpRU]�is��̹IYaС�̍0���}������j�"����b��4�ڝ���*�]�lRQj�nSS�\R��<����D�Մ<kB�̐	*�|R��w!z����Z��C�TxO|V Z��pT"	��#��O�M��4�&zq7��'Kg�;�ye�H�d��u����������{ݽ?����`��*���C��S R~�k��6申��tHn:��RSsbs���P�%w^�;p�׉^3�����T�L�s��ݸ%P%C�"C?`� Fh�N�(�`�w�?� EQ�̃+f�"!�����Kq��=�!�ViXd}9�D�ػxq5���I�k�-KC�V��V�tRs��sA�c?�i#�`9|����|�#�+Ci%�m�Ph�5���t<`�BHIj�X"���/��A������C� ��Q��ǸgbM-�f����4)]����!�>8�C���I5�րi�7(��_�Vl��)r�Ͼ�i1�P���E����M��?�z(Sɕڜ��D	HTN���->�i�ĆTeR���	S�-��������
̍�O���nH��SS�?�=G�U�(�u�ԑ� 8b�N�e�uM��W��,��i��'��2�vz�,[,���\�*� u��l+����R:A���pbS������a����9�B%�f� ��4�T	d%������s�v'��/b9	E[D3���Y�������]W5�ۥ%�.n)���7R�/�mL�,�-c*4� �gP��	��6���تg P|QI�ʅ�W*�>�I�)�DJzx�M|��+�-�j_������8e��/Bg@�W��]s��Z������F�a��>�z��f�������B��{���Yh�������j�e������ϝ��
��{�X���������7�+�����F}�\6�F����gV�B�uL�/�>	�A���<�����Zq|�#?����e+,�ų=q����%.c��D�y0�s�$���@��#��6�
nߐ$]G�����HXg�s�hLi@X��+r��d;�:${k�� g�@+9���|�Gџ���c�ʦ4t����+�NH�O����!��)^z��ay.Ӊ�nŸd��~Lؠ�? ]�9%uGUv��Z�D��|Nw��š?�Pa�E)�9,㉨�5�Pz�\��o$��BɩI�
���n�Gd �W�GF�x��p��"^$����Э]B*,���}z�ۧ��4�>��y�{#;������%����۝��}��Ǣ����J����'�3��a�(B���.9Xu���-�
�|9�!��s��a%��R� .N��KF�"�o D�q�6�p}�!�s?!'�%g0}�34���������uXuƸ2>ď�W������ ���<�~x���BsӀ&�p��3�!i��`^G���մ ]/A���r ��{���q���`�v�iY��<'�n�U7�1�{ `5Zp׼J%%,f�u	�6ߒ ��t����S�;�9��@��O;������N#����-��p�OkCn1�4�V��2��3�o��<`����	=ƂkX2 N-NFB���k.�dC��J ���y S����EޒUT��M2����*�
�gB~络��x���5�j�W�I�X���G�A�mHe]L��G Ә!F��`��ܥe�j#L��x2 T��ջ�Y�r��h��\<����ʃ�!R:��Oa��w��^]_}��������3vN��$oyt'u̎�l�Z��ϵF�������z:$����������[��=���=����ɶ+OX���G�:a>b4X��,^�l%�g��68�����Fk�r��zT��s����B9Oj􆓸F�a+�`�9����:��M�.�9��Ge&�G�$�,�'@��i?f[#Q@�:V��;@C���}S/r/<��RR�(~`fȃ ������F�>ؽ�̨����v���<��=�uHZݎ;΁;`���k���h��){�n$	��I�1��4���(��ckDgk��]ST�׎�I0���7Z��Y\ UK^G.���d��p��lώ�߬�ߖɎ�ku�j�j4?2��F4�,DU$�ZS�WW����7v��?��~���<��Ͳ�~Qo ��J���TW��I���{����^����n<����4s�v"���	�a�e���Au�z��s[ϛ8�(��)ZA#�������iR�qx�����|�ZsWb����V�����Ha8���`N;8�Uw�pB6��B�����iI0�bCj.������&C'3$ ����!����%�9�w�9�~{p\���E*d�#�B�b*���'�����Yb�A��W&V"��k�T,:��7�J:7(�J��S@Q����>4w���0/�N*:YÖ;'�$q��_����S/ު��~���Z1L����$��<�C���1>���R SvhbmeTiP�$σ�k2�\��.��@91�2V�|fB��0+�D�	���Jd8�iG�މ�cO^�U	�	x��qR8wn��|f�*����S�$F��eiuN��n�Iy$�X�b��kE=PS4#��a�4 K]�$Y�ؚ��|�yK?!�"���n+�"�-�}C<Gv�F%riĤnд�|OdS��M��2Yъ6'�N�9-������0`���3{�t����x�#����+f�!a,m%Y}�>�b�@dPVR[K�Z�lB�̓�iIja�œ�D�ԛg<t��B�a�(B��RS�k�	1��H*�"B����|���z9�#��jE�-ZZ*��y�t��Ԭ���s�9�6P	��1y���L�ҍ�v>N�S�P��Þ�P��O���Fd����G3u����K�TRQ�2��4��,�HB���yF��\.�8+��`���|"l��uF�KƤt��������e%��S���l��Q�嶕A���L'KIr��9����[p	���O��M1�%t����������4al�S��U�e>�W���9�ϩ/ƑpOK�V��7�/ႧGz������6g2#��>�j_�a�]6��>:<����0�ܛ���L$���MC�i�(���ϒ�y���`�4
 k|1lB�r|iC��m�<��6P,��c萴J�aq���8NU���������%�OOg�K�1�ږ:D���%��o����z�.��"t��E�
���j �Rž�_��\���U֚����I�N_�v/�lk�"����觝�WV����/q㾻��H �:�T�/`�=��vz��� ���`|�\T�b7�4�+SL���O1n ���ӈ<�X�$���2�g�&�#�N9�(��!��;��*�+�d{ݷ�}�X�T�?�}�!�Ԟ3�R�)<~��P8���rD&���]s�1Y����r:����f�E�����dq�:�����~�|�r!�����|삐~�gS�,m�F�����(2�ʉ3��g_v|r�&�x��|�]#��r����r�Y#��x[[~��=Z��5����|k�&>Z/6��\]�V�- h/�h7��|�������������c�?�rm�{��n
Аi;�W���a��Z%���ɟ�*1C��u����N����~W��d.`�q./�M
v��vY<�c�Kn���4�rr➉Z�d�KS�nM<b����胃�A��jv��#6q�YoJ#���o��U1Ϊ��i�W�q0�n {ʞ�5׵K��c���� 1j ��i��cۯ8����ۯ8����r�8NZg��7�fX����A ����^�	(�T�]L�-���LSt��h�_�z.�?��-��r�מЬ��ծ�N����DԪ��_�e�M)����'�m�ԫ�~�>8i��_2�㣆��8�~֮6%��;���k��@"�sf�\6�ԭ �%ԊG	l(!�����%P��&�ƿ��ͯNE������1'�����Ξ������}����䘸,�O���+��eG�)���8&k�VQa���tqX����-r�~��!�NHmzͿ$d_Q��`i�4��5��~�������72�!;�t`���)E�^1vJө�$]Fc۵�S���^�_��a�<�NfA"�e8��,B��B&��'�����ʱf�`��oغ-~�D*�/"qs{�2�C�5�A�o͇�#%��(H'Jb�[
	�'Ӣ:��U�t�+m�q0���h�ŗd�A#��ԉ�R���^�̷Sd�>S}�$��A�y���H`Z3��AFi
��V���T�?��K����t�X>s8���Q�p*P��1����M�7KH���޼�Z/��{	K�̆aQ�:��u�k��'��&9�_s����l������}���ј�c��$r��N��Z��]��͉����:�/����{��B��|���[��n������GǛ�����y�#1�K������>�i�d���z����t�Y6*�t ����U������ߘ&�{��]� �0�%�j
B# �����凟�\v=1������� �p��H7y<�n�Xa
�ND�ڂ��j�:~ݸ��Z^��ނ���J��g_�s��jc��@C���0������1t6�k�o�ڞ^�^3{��b!�����/�;���k�r��{���9����b���G���v;�F�y��Aq^�ھ�M����}�Y�����s��m������������T�����mwg�t����h{�C�̘��y6<D1Tq��Y�:sמL���Kҋ�9JC���J�09�jhT�z�⭩�^:�l��<�� �m4���j���o{��ݶq�g�W�h�!e>$�v�K��$;�W�TInҦ)H@b�`PN����SOsN?��_�?vg��}`���m�pZGvggfggfwgv�!:�d��i����{�n|����u\(]��/E��
58��΃K(l��5��:�h莢8���'(C�v[����fQd<����BH��</bZڜ��&Jm�w||�O?�篛h�a�c�P�"��!`�J拀�N�#ѲCaa+JY�$� ��!.\-�_�l�{5F���	Fg<��Ȱ�>����!Fq�tQi�E���ixV�>-'�1Gɐqv�{�4�O���X���b&�"���*+9E���\�O������/'����?���6����;yl	o��j(˛���7K���	P�����>qaT�qհ/L��k�}Sp���K%\�Ԟ~���t�c<�0��-Z�X�{�K�%���5��ۖ4)4�~+ڲ� ��z���`zaΙ��J>$�V?NR� �A�_���E<��0t���J��;��<�E)d�=�>�*+�8+�,�z�%~i�o�C���3�Jg�,.&D���0-,��`�e06�@���ǘ�%l�뷧{_�4�}�;��I�>2p~��}>mx-���Ӭ@�C�,
��ǖ��`���p���`f3��(�W�L�Q�.������_��@9e+WOTH��4���	�h�E'/r-|U��ipǛ��
��w|z�;<���~��:8�b[�,%� �\l��Fo��= �Ǹ�+�_M,����T�T�W�X���q쟃�0��Č��FY(�d�7aAI��W:���kp+keM���H�r�E_��Md���2�R�!��?�Q4�!��/�S��Ԡm�`-Ɯj6�Xdc��}�D�d�������lF�A��/�/>�i�W�����Y�n,f�-���-�D��Y��N�ec���j��5bJ"�4�\C'O���TZMA*#�Cٴ )�ИI22�Qi���ҽ�z|5&�"NbSE�rĀm�iv���ER�^��¬��1�����gc�����{1j�ѼU��jv-߃Y25�P�1X)b��TTKr��Q�M�h�
i����G���t�X��xtp�"\��-T)3e����p��l"�'a�\���n�B�!,�dr��J;E8C��g�@L�q3W]#�K��`C�B��w�06���qM�j�
�*��(���"�/!�E�IG��WB���eV�l��Z8�ΖL=�����N#}Ku��ylB%��q�]6z�O���-VcͤE8���̆�U�֝OT��_��2��&�Ro�.���5�5��ލ��gt#�-�U.-l*��Z�r`y-_Zޢ^󜭡��rϰP��z��M�r&j�ҫ,����Н�+"��`�������7/ՙ+i6m[�-,�Q�`>�B�(���۽״�c�p��aP�G�M$����ˡ�+-��R�/�|��n��-tX���勠"��7;�WE?������������w��u����ro���{'�Ǉ���(u������\�d`���e xQ��?E�t���4"Tא��'�]�̶�����"<1Hk�?�i3-�D��Y�_��Hu\p�nش��L{�"V]g������{�m�u�w���*c���V3�B��O�~�z	�����sIÄdS�"D�Q��%��t�)S"}��{
�gn� ه�M �s�A�ȃ�?}�����	jI<φ���pw��]�jM]yti��-L�&LXL=8�{���2�Z���ץ�|(&
6�'�����Wa,���Ֆs�Ţ��\ v��+Ӄ`����yxL5W_�`тvt_�<h`*���0xc�YцW͖��v����qOO����U�	��ǆ#��N���{�FSգ�<I�x���������+�LaPu�ȖZE��d5�j%����qRл�O��nD��d�ۗDT��&>���8�1��Q~��-�]1d��R/�G�iC�������0�@�R�B��ːSE8�0ќV����[�m~?���$x�Od�8�s�\F�1+�:�Yt��u:{��)����9Bei�Q�9�B@�TD�FD|�p|�g��2�މu�K-ط�E>�f����#�L{S���+�ɨ2�!�=MzbF�)d!fH	��:9gQPr�'{�
��]K�VJ�Mc5te^�(]3c/�[Q��!�yņ]RM�{>wcO�B�ۂ،	WN���p\��YfgE�PU�#���<�����(_��m�Y�tӪJ�uZ.�F}�;�<��Sd)��6s.�s��A޲�c� h~�e���T�xV�l)h,�gg�*��l��|��g8�J6�+�L�"��.���$����+GQ
m���jn�[s֞�&������ku9�ok����-������C<���(�=%݇�N�rh�����⪡��+��ʎħ����t+>Oی%}�O.���1�T�cAr�g98ƴ�9�۠φ��N��4�?+Z[3���V��A�z����y��<*�M�W���:�e�tV���r줟U^ݎ��܍�y���P�*�R����0D�\�,v����a�4�ց�H����S�J��x�f�V6F�4��<�^A���W��fd� ��q!|f�[�3õ,7=���d�ˁ6�x>�u��yZb�!�ZP��Y6]Р^�r�D��_T�g��O�f���|��r��T��q�R'!�7��|{<(��h��&NK\_����^mԏ�����'|j�b%$��\&��1׽�Bʬ1&�,N\�NY/��P��.&�ULl��XH�u�T�p*K��7�{�����,�G��ٝWE�����e���P�:-Q��˴e-��h�b]�ة�`�d�~� �cu�Q�ACH��R}9��@�o*���A��P�x�ٶ[�DsZs�ϊ뫬�u^���v�i�Jk��rQk"9��L=o��������jԬ�"��L�ꂙWpiR�-!���dYJ�n�Q�t��'~���������Y~�Nӕ͵�8��Ewu1}����j
��X����F�P�N�(+��M��}+�����-��SE;Sl�]�����h[�[U�z.;�x��n71��4ؙ�*1~��˄�Nt�BҐ��)�O%1##��K��	�W	g-�|Q`�rj加�ު���ܪ��.�&�@��]!5y�WK�`q^h��*��܌���Bc�8칕䨉jP�:`="9i2^�h����Y�Ι��0���-Ehhp�+��D4���S�Fs(�zx(q�it	Ӕi
3� ��Kc�ҍqi�ŀ ���h��� L�t�)�= �FO���P{ّ5�&�59SLe)�
�;�@�ȝIW��Sq�D��_&޷N�ZH�ekz��M@.�����O�ɓ�(Tj�:����8x{3i�V�t����>漸A�Ȅ]��9�����Koz�݊s �\m��<z����ik�Nb�^���<�JI�Ҟ�a?�Z�� V�3y��*n�e�:O�v6۝���{����2\��n�W�1Zxb����ʨ%XMt,n����+6��>����LKp&v:c�B3��X0�(N�o�i >Z��>�s�S-�>�M2k�jPA�D��`.��M�t%u���H��X�%��1Q%��0�`v�rh�����?��EW�5��7ҭܺ��6 ��(�D��<3��3Ifą��sa��6CK�����1Q�U 9�c�8h�I�u�g�[���BL)H���Q�LQ�e���8�Z;��p*���"��	�]���]�הo��S�kȂ٘g�H(r�˒�:}ZD��:�Gk�g����#5 {����vߞfL���I�G���#�jʇd�bBR�*_Gd�[K��F�����z~�����et;��B�^|�@�NW*߶�ͥ黈�.��h�u����2���жH���x�O�"%֌Ů+�yv�lWK�\�.��\9�c�����:��ȚQ�����=Mյ���_JO��^+�W[o8s1f<�b��\�����B�r�ot��bk,	�r�	w%�4��Z7��(��_97������c��t;��4��uƜ_�7���6��q��-̆b(~��N���m���PD!̶�.�.qc�+1�[�V,��;Ii�+�d��.��W�yx��?'�8:��]� "GCe��ǵ�n�]�� ՋhN�l|���G<��U\?��΅�kk�h��킇:��j�8ɥ��SC�+F_�Жb�ɪ�R�-�;�脂 i������G�/�W:�K+��S�`Ţ�2}Y+�"���:;=e-�,�&n��Xھe+ϊŭ��"�NXI|=��x��6k�z��W�����<8eYL�^0k�WW�vJ�.����V�v
��P�DTR<_�����|�ou�3�=;f��,���7����Qu��������Ϟ���r�����������o��J�W�L�Q�5.E�Y��r�u~}i95!����%��\���ᬥƮk'%(�x�ˋ��������/��a.��0������/�;��)'p�L�����8�� ��)6u��4�}\1�a��-���#ʄ �5�H�܇ק�E}�_Ǯ�c�ߒ���
.F�v�\Ta�r�y�u�8g�!e������Y��`�e�-� Y�Y�ɢ+��1��k������/��
���?g��?���w�^Ɇ�;>��Uk�,��n��Z�1rQ�F�5�f|&�Y���88�H�	���F�͚I]l%(.���Q��VEq��0���d�;�P<���ti�1`���_�}�m�/�J�����y���Q3͛���-�d�U��b��9tr����;Ѐr���+�$`9��C��;j�2��k�lrj�	���k5>���=������#<�A�h-�݌�'&#8ko�a(��Y4�zJ���3to�A�0�L�vU���i�H��Am���ҏ�(�}!�@��C/����Ny!z�ܟ�����9�c�	�"���fa���J�7��Ը?�Z�횫�
�o(��/�r gC�2
�T��L(�V���*Y��c֓���	��;����ۼ��`>��+����('��j�-�۸�x����uqm�mT��<5��������{'�������x��8���$]~��߼���|��w����(	3?N�u|����O����O�?����x�d��-�b��k����¤�^��$���b�A�PT�����6;��F:\��Z�KI��!�-42�£�Gd"�X��o1��#�m��|N���۸��)ӡU���AS���VM��~�S�UY7*<�?�9�O�mq�cApeǧmI�5�(;i��Q����`=Z�MXD�K6�,

ҋ棉O��NH67d�eì*���,
�yA'�q����!���k�(8>�mgeeŤ8�G[���0*:�T�3�h�ΣY��3?H#J�����]m�6��X�6!�5B���@��Q$8�D7��{i>�Z]Ґ4�'�"d����p�'9}�hz�Ҕ��\����mg���,?T���a �o�l��	`����d9���A]�ٳgE�s㹹�����g���.���Q0����T|uĸ&�H|E�~O~"���%RpD�>��uB���*ӿߞ�=p[��^���_�����:�N��w�A�{%����#���L�h�V�X%H@��b�3]g<#��Y���w�I�E��d�BP�g&�8c?��g����E�J���1����x?�c�I�#ULÙ���d��V��'�D6�����Ȑ\d
�AVQ:B?���;ݞ`ۧ�	��9����rd{:�E����>!�6��~"
F�w�iƮ��������O�Q�:���B{�,��!F���(��mn|�4?������g���������������d����������� ��m��霓��(���7�\k���_a���d���0Pxz�%.������xY��j>�'�;4.�9�qptK��'!qv�^��;���KP�{s����ď/��Z ���Ы��A���̓K���1���	�@���E���(�;�}�I"xM¹�I��
P����3��1 �8p����v]��Aj��P��s`����vv(�;�����{�]�
�`&W�,��	m�ݻ ?a�&��S�`��? �qx��-({����^�醮�I��	 �S?��\\��ޥ;�^ǝ�Q�sn:��s�O��G3߃.9���mz���]���������뭭wO=�ecw����m��5S��n�y=��-&�'���{ 4vcL���|����wl�� �d�4��XOb[�j �)�0�H(��˸�R��8�_��X�sH����@�֝T<<�-�k�sq
CS.�_o�Ѻb��(�Ћ��~�?'[@��M��(I�C������V@����%���S����g�#�#�����`S�Z3��'��HgF֚З���-F	y�9g��W��G×o�����x��c7%b��K�8l�s�.b����,�~����=�r���dh�@~��!9����	�Йx<)g�A�)5 u�{;�{��C�9�M:	y���&t�Vh׍�S��5�tSeJ�V��}�p��c�.6�O���\�]3���������fա�WT�i�q�	�T�#j`�������6[I %��m��v�I�C��`-hq5�@*�<����#�������#8�f\D���d���;��>PIB'%�O�O��BT�!��a����&M�T��z��d�����r�G_���6����0�������_�N.#������˦:��/�F�/�E�6x�#/5>����o��s���؇��
��{���`5�/4N\'�J�s'�!�-�C�ʕ.�Ü*j̘i�U�hh���0e]��LgQ�Ն2����N+��(
"1�,B4R�j��G�U`,��3|�A����͠G�'����Q���!�|%�'}��n5�C�E0[z��=�D��'D����g�����^�A��"����i��~b��ƫ��_�oowp��b�cb��wU�P�f�t�df���'�笔����8%��WG��L�ש݉`J�9���-������(��H1_Xm�h ��}H�'�$=e[�F6��?њ���"��pPv���`:Ro0��$��eF��ݡ �|��Y	/�b�ߑ��4���]�=��_Q��H]D��2���U�H���i0���=�1G%^��I�\��\��)#��U�]����n(A�]�c��Nﺨbџ�`E'�$F	��W��T/֑ƶ�AX9�����B�FiVW�؁&a��@��_i!�A��n"1:_�F�+`HB-�䓣[�-g��T;��m|��gO77�%ۗA�|0rx���c\�oX���K/�WMۋ�1�I�_�_�H�Q3�ĝ��6���7�Y�E8U��'s�(��:oz�&j��p�Q0��a�P4�!HP�}Y�G8��1!0�|�� ����X	s����4���rL�kZ,��6����O���_0y@����y�V6j�-�G���f���#)̻ܘYt�4��C��o�=:���?|{�%�qj�o��`��i3�}6���O�BM��`]����k1�:?�t�fn�"�Yr�B*s5���^��Gn�S�_����c���?���s��?�Ͽ���h��]  