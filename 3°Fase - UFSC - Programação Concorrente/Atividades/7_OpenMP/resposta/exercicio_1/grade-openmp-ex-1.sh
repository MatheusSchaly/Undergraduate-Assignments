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
�      �<�r۶����@ǡdIև�v��M��S�΍ݏ����(��dH�N��iο;s~ܹop�bww� ?$'u�s��c��bw�X,�'N.<���O�:pmx�n:�]^_t��A�������oo}�Kٵ�;b��s޺q5ܪ���W��^��h������������ud����'n��QsW��֣n��mm��`��!�������m^����j?��yxrj}wp8�[�־;xur�׭M��M]�a��־�e��Ƙ;egl�@X�y�:l�˒���;��kMٚ�U�a��f|��u0?H�4X��{�}�&�KS�ߐ+PTߞs�̱�0CCd��xi���Һ�6���?/v虋�S#����;������Nh��]1����A??������)���?��}'7hϞ�Ԣ��/�eϽ��"��y�E5�OX���ƔI/���&q�dc�Q6��Q��5�ӱ'AS�d ��	={�`��&�j0�b7��;~"0\Gn��Ы&�[�C����Î.�)Ax���_��3�%�������J���cl_:;�A�R��L��F��uF@M֊�d���Knj�0�D�c^�|�F,���w���a�5@� E�B�����
������6-�B�L�o2����;��I���5�4Y�w���z� J�����R�8�Z�EI�a@����yײ�jY�n)p���{��0W��(�Ր�l����c���m��y�oCu�!��_��zڭ׆���G�A��u1��<�f�3Ӗ4Y�a��kju�A�)pS䯪F�=��n�����g��i2��
S�U;DQV�#z��KK��T��	GX�XiED(����'l�0������vZ_Z�Q�����7���z^����y��_G���y:�;��!UV�|:������Z��U��rV�gC�2H6��_��EJ��-�/�kT��H���y=Ц�?�2:�,� ����݀J̮g�S����r�^�� Q��x2�no�0$��N����9��Vp�%7+�ڰ�3u}�
����zJI�K�֭s��l>���X���9Z$�x9!ؔPf�nC)����|�S�D�xmB�M!k2h�_F���{!zY����"��R��zA�B
����HR>�D��w�M��u��s7�1K����Eew.�IU��M�j���r:<z6|�>><8��+����� U!�&g����M�� �u��B�97�b����d���P�/^�=p����3y̢v]�TI�+W��h�)Z�i�=¥��c�ymNC�SO��,��x�̃Sf�2�!���<��uO���k��:Q���HS9b�
��u�,{"��,�nBC�hY:j��rXE�)���炜�� v�F�r�TS?l!�B�׆�J|]��S���$-2�oB�!�$5C,3��Rʠ��QH�ޔd�9*���{kf�43=�z�x�tyNz�*ԫr�����ڎI�	�Lc�A9��bņ(ű"x�[�Q�c2	�'�c���"5{s;ϐn
e*�R��՝x��S�(����36�!ل�)(�!"E�e*���ln��8a�[�f�F΄]�K`
�}��Y�ŸN+�Iu���i���9$y�\��2;$NC�?���T������k����-�l 
�b;wp)�{BJgXmԎ�@�|a�Hn(�Y�����U��,F�؉cUy	k�8)��ba�����r��P�E4�#ڈ��+�ۮ�W�u��بc�E�-�}��F8PJ�����.KxJŘ	MA@��n�5a9ڎങ[��� �/*�]�0�J%Ч<�0�/+�=<�&>�ĉ�W�/hz��P�r�����=qZ׶�����^a�~w>��?ť���<x��~φ���{k�����N�����ux|�|om���p�����?�j�>��3cM���X
�9q�6����j�'�ĉǎ?�aHY�]1��O������&��ﭙ�U���=�j�p]�)����[~�B�˗'� ����g�=�˺�0߉��`�PIVKہܭjG�qm�nߐ�F�����y�֨3�h�9N�֨����GP�$�:D{+��|�
�z�����2����q�x,q�MN:��O�^��b��`1���!�R��/��ͱ���Tb�b\�~���hP�?�.��a-[Uv��O��Zi�;�|AwC�C�v�`��J(J�ྠ��(�<����T�� �FrlR��H`7b6�+	b�����x�|X/��t�~�֦.c5*��{N��BW���ߚ;ѥ��U�;?�?z�����I.u��=��lh�xJ�?����^�F9=4�p���#L���k��B#�����¸Wp���Lgra�_/äpV��Ů�Z�si�rH�x� ^x	��pUE���Y��L_l��]�9௖��_:I֚	���������u��%�2Xk8�9���o�߿���1�	=�p��Lkʺ�5فǙcO����S ]/�������3"�خ��k�)a7���$Rd��o;���*x D�В�V���5UoI(
��	XK�(�����w�9r�Ӂ����c*�𗗯�:�Od�}ch	m�a>�1T�GliP�"T_e^��߈��`y���	=ƚk�e��:�ؓ'��`$:��J|���H�2.��yK�P��6��7n#@��k O�~�Mvn<h���F��puI���04}G��݆X�������_$ "��Yr���j#L�즸 �V�ZC�0�<ow:����{���g�C\����5�?K���v�s��������=wb'A�J�ڳ;��<����m��������N��3e����������W�����������-�v�r�%zv�3F��|Q��J5�J.,Lk0��D�����U �Q��I�3K_�yR�7�'M[i�x�I�� �0ՠ7�(���ҿy��R�~����b�Ph$��^+N���P?l��K&�Ue� 4s�A�qɒ���
�F�>X��Z�0��J>W:�����\����#�+�v�8���m�ޤm5V�s�c��
[�pr,L8����m7�)������7c��Հ��b{z�d�}�T��q6�.�j��3EJ�F/Z����f�~�M�8o2ԩF}Y������(v������Z(��*Zi@��l7v�rZď�2Np˝�p������'�8n6*MNc�w7�������x��*��G���Oq-����e�qgB�(���I��ڞ^��]�����d���.�D#�������i2�qt�OOx�ZsW�`���JA����׈a8���`N;<�U�)�,���G�f]��9�:�%��L�̡��'/�������]��㑨��~uxRY�>�'�&3�=�b����氈k%�Ġ���W%�	�����ڵ[)��_�%��J�f�Z�.tP�����<4w����.�N&:IaW͘�1I7��׼����Ovk7�%����V�Xw�)%O�9�� �a� �|�H�1E:�&6�Vʛ�R�%z�:ޔ��j6w)��N8��iS��P��&Ċ�[��Hu�i��7 �D֣;C�PUI�	y~�qV:w��<2���BF����0���2���΍1��<�l�x0�ݵ�h*�����h(�d�K=�$���4W�[�	��qtR��"�6� �D�	�0l�E�t�ey��A�2��0�5��V7eK�tE+ڜ;-Ӵ�D�y!dɿ�!��g�":�w���F,鋕+5�B�X�K���}*��2+��Ӹ��Pn�T8iZR*�R<O�H�;�	{���'�,D��.�lt�lva�����Ebl�8���]����G{P2/���EUZ���+]v53+#�s.`>�*a�c/��q�оrcp��7��7���dg0T����<���`�I���u^���+@*��N�TG�j�,E��ۼ$;}�	�$F�L����;F#}r��30�\2&��gu ��Tt��T��>pjL!�RP�s��m+A�l�\'KIr��>�%���\
'��3;wS�qE�N�̇�(��W���� ��/N&>������~���'�pO+�V�[ʅ�r��&�� +Y�Ǉ�2#ia���?�.�a̧4��8>:>=>:x�d��rZB�FK+�i�o9;�>��ۻ�xV������Q (X�a
�ɕ]�����'U���a��z�x���i��ZEb�bu(�|�:�~V/����T��
[a���m0�s�*���ja����X����ʫ �!U�{�E��
����ִd?�:"`��|Iֽ��aԨu����������6�|���@� 	$ZWg��������x�UK�-@E�����et�*wC�{A3<(Eru�`�y�n;Y���dɢ��⫙<CE�o
%B��҃B����\�RO@��'J�t��T_.֏��<����A>�o{+?�Ǐ
g�����]������+b�0&��5�K�ƷbP�Ҭ��HV�C��,.W;��P��X-P.�7xa"-� �h���D[�.��>错^eǎ�`�ޗ���h�������&����>zF�^�ɶ��mx�I�^�q�m���6�t���roݭ-�j���@��e���ǃ޶o���ۏ?���u	r��%����4dڊ��J��:,��o�7���Ο�*1Cg�u��b?I����~U��t.���W�Y���!�.���+j m~��3w$�M.M{<�5�$�������:���t��6q�I�lu�Q)��EU����8���8�������vt^tL��`#��ʝ�?�m�6n?j��l��n�V9^�g�Q&��3뷰�� fl�6�	0�L�(��LSv�l�_�z.����j�JUn����U�ڕ�dX�=NE���CY��16�8�����������Yg�~�@6���C�I}�]mJD;m._����`�ϙ�r��� �%PŭJ�d�c%k�P)CԄ�e�]�����^��?~���wx�S^+��J�?�:�������*��@M �6���U������������*��_��Q��q�����<��,��s�n�L0	���2D������ώ`�ŝ[��oE.��LM"���5[���p��q*��6Ƹ�$���I���'��~$�~ٗs�Aq��G����K2fF0sϳ�b����W*���s፻�A��M>v��x�o����w�������U���lr���k�nO��i_c,C�v⎙��-rz,
�r�$���p��|���(ɼ���i<����8���ܚ��Qh��t��+��{�hy����b�7yD�fE|uv��u���8��
 ߒ�N�i5����O�����m�f�Y�Yo�hĿ�%JZ��,@�z��|](�Ae�ȼ�:����o�b�H!��#�`e#!W���r��Xˤ�� �z��4���")�@�M7s�U��oJC�-�WtnU��c4�[~l`�J��gh�����
X�0�领܅���,(���۠�U)�A�B����do���b��7Z3*B���3� ��ŋ����u�2[�|������v1i�H�w#��F)a@�ߑ�>�,����q V�:yj�|u�txrr���:>:<*I�Q�&�SW�$�0,��s۟��X�Y��_�صw��lh����f8���ac��av�"�ҍ`A�Dcw�V�J���~�k{)ǤwʸN?4�dG�֋�_�����nUX%g�ۑ%�ਥ����:*8!A-�sN��J4l�@�Uc+s��9K�n�4��-����y6@�A�X}}&/@/�; a�\�j��2�	_��=]�<�*X��>v�8n���z]��?�\>�8��lè�6��s涼�����%�*%�*��v^	V��t<���`H{= ��N�n�)_�+�-�hP+(#���`rQmt�+�-���Cq�b�)Q��c�@j�:����YI��Vn[���
S��_{W��6n��ͧ@o#%&mg���%qd�qk[�e���tu`���"�����jO�6�O��7��J����E9�$	`0� ��aV1���s΋�����ru�Q_�^�4s�����x����^)/��7������*M<��R�8�Fz[�X�EW� �e�eն6+[�E�T�,i�t���Q=�3	�ã�:RMczUFW�
�b�>��ͅWwJ9�>�����7�)�]�M��sJ��0_Ⱦ��}	wI��nZ"r��ud�������eE_��n{����?.���P��6P���g,��
f�d�K�0�,�`��U��J�Q8���wJ7�_�����i��#\�E�����E����Wmd�U����ɋA_�S\g�r���&nM�3�zҰq�n��ć�CaY��g�j�'����CE�����������p�q�����`�j_�K�)i���O�y�h5V�E��*K]��(������%��>c�°62���tV��*�C5SI�DQvdi0�>�d,-B��e�������'�����Ьׇd��P��L[~�>ny�w���7��f���o��Ý�A�LO��;��ß{����?�D7�������p�;;�t����!J��)L~���9foS�,�T���Fo�\?wW^E��Ӧ�����#I�4�Vm�8!e/�J���M��0��*�Fջ0^�p{���;8��d8��N��Rw��Ly�5x2P���	�2|��3x	�-�9��$�Ɩ8T�E�LDw�����K���G8,T��R.!Q�?N� �hH��Dթ?��rZYD�b߉��U/����"B�����N����O��mg���*��Ó�_�-ip$D{jk��^��%Dx�j�zz��Tu�q�66�˓�q �T��������V�)��7S�M��#5U�$�pS�Og���@��h���oO�4Tk�SGO�-�
4#���S3�"��5�3�Vž��t�^k\�-C��4^wwv�'��X� #�UH�/Ų����Ĕ�PN#f0�M�&�IU&1���<=�j�Ky͞��N�J�J!h��J�������Nv��ѣ9�������%�q�\D��T�>��|П����K�HPѶ�
�2ZG�I��?���PQ�p`�+c���S'�;��yt��݃��I)�.z���Ύ;��c�K��ϴf�4�Z$��1�`�M�����;.���������Ɠ���b$����{�9q&b�QLm��h u���iww�+ђ�#�f$?��&�RiW�W���k]�MX�˴*+�l���g���w��0����e�Ig>U��]R�����aVԪ
��$�Z7�T��YW�q.c4HWZp����̀z�5�3��/e���u��K{�m�j�~��o�0e,k���b�eO%x�2\�@LSwo0��c���ɺ��<J J�l�E��E�;��=(A��L�:"���*W�z�d��Q���hV�u��/-�܋�ca�S��HI?!�s�����+���hcJ����K����*+ɬ�Q��\������N GR[�P�&�~R �nh@�H7�#�j%RJ18�x�����2W,���3mܸIfǀ�L�2cf�v�Z��/w�k?t�Y�McV��p�'2bź2/u�(���V����W��5���֣�Mm2&j�ѣ�R�=?*i�@��y%̑/F�fw�A��Dyee�����^ú�r����H�^BSJC��s��`��dǤ�v�z��Z�w6R��9����|�];��p���/Ԯ~=>��wim�����&�xc���Ę��!S~��Ԛgp�PW����� y?dc����j�)�sZ��9?��;m{kK�*W������f��	|f�x3q��)~;��T�'иk/iA�H�$�v)�_h�UvG������|~�X�5�_)H�L幄�I@�w��q!#��;6]>�7����C	���b�^:ݒ�bɣ�[�B'-�L,�k�FE�R���6s+#۾]n��̼f�tX��3�v���x��A�P��m<Ǹ#6(;���j+/Y	-�]�+���lm�M����Ζ� B��c�꒪G7�T �}�zҝH�Y��a�H�7�-:���t�o�ͪ���O1�D��M]�l�1Gӱ�V���^ Ņ;e02�Nc��#:L��
�h�]�	,5J�!P� ��Z.��A�7����:�6Ƣ]]4LXǙ	���;R�%j�"J ��;Le3_�NKl���Rkɞs$F�%Cm���ٱ���j'��t;��A�P���|{ Î��2��� ���*���|��Y�ɏ8Ծ�#���ۮ��r8ld�b)(+���gK����8m�(E@��7_j���j���j���j���j���j���e#�� �  