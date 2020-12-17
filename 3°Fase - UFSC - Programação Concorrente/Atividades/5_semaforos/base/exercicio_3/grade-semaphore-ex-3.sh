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
�      �<kw۶���_�0�Cʒ��+�+����>u�l������CK���dH�v�������������������u��5Nb���`0��1���ƍo��Ԅ�������FS}��Mkmcmsk}��j��!�l�y,�i�NH�7΄޸Q9ܢ��'���$�S����mc���$e��:t��h�b����}��������oH�~��������'��k\8Ѹ����ۣӞ����YjU^�;�uZ����;������;d�WqG�,1R��H���xL=(�OH}D�T�!t0���
I�`���?�O	z�Ƥ�^F. W���3圙'&�FȰ��4�&K	�����}��:�({�"hVX����{Ns����^��1#�d��d����͍�����&�!%�F���Wǻ5+t��l�p�^�y!��7�Uq���7���0�LV`�U2�������	� d�T�O�m��
8�@AL��B-�5U%��m?�^,(\�nL���Qcz�8i긞�?��r�T/W�UZ9ɓY���`*���ȹ���YD��L�=���5ϡ6��xz��sn+�`��!�&�G>H5�g�v���HDR��Ⱦ�7���L����$8�Mr8��8�kD��S:�hl.'ŤY#���G��,+�ԊAl�A�8�Z��q�a@�(H��o�6Z-��)n#p���᠌r	� %����(0�5p&`�j�zꙌ!���w֯�s+�֒��h�QkH�e�]�<�m��ͤ%5�e��sL^��7y��0�����K��6?՝T�YN�09MQ�Cd��_��]Z(״���T8�2GrH+"BI�����y��٫�g��Ү�WyfQ^�_�V��P�~�<����U��OƓb��@�e#�L�j5'bf�aF0��V��e�~&�YV:�/��'�	u�YP�YLi2���}b���/;z���[	�6-��}�����ԣ��A���؇u
�wqV�ɻ�7D�uO���>W�@�ӫ�,pN[;%\`�m�
smȐ�\�e�	�ﳕ�$ݥT�y�t>�ȷ�Y��L]LT��z�`��Rw��"���A=�T$��&�Y�fMP����Rm���|��ՂDJ��{��)Ђl��I��μ;l�w�E�џ��2�Y���%�+;�D2&Coj�]������=>���/��G��]PyE��zb���C$X�,p��������/f#@�rӁ$VZ�;�#&��秀J�����[��O����,�-uL�Re�\����́*���G�0BCvbD�Gs0?�����)�2d�b0K��)�t2! \�{��i��bD�"�ˉ&r����˨Y�P��H]��XhY�j�25䰊���S'�r4��M!��M����a_J+�8oGB3`�ɴ���g�!�BJR3�b1�<}!��t��>��|�J'?�=kj�43=Mf�X����8 X�9��Љr�DL�1�Lc�A��bņ(ّ"(���П3	�ݐ�^4�H��ԉc�7�2�\����N��D%�D�q����LlHU6!����1E�!++*���407�?�~��!���1La�we��BV	��	RG�����:��1�51L^	W;����ʟԏj�T�y��<[,���� �*� u��|'����R:C���pjS������e۝��9�B%�f� �4�T	d%������s�v'��/g9	E[D3����Y�����'�]W5�ە�.�(���7R���mL�,�-c*4� �gP��X�	��6���تg P|QI�څ�W*�>�I�)�DJzx�M|��+�-�j_����[�J���_�ΐ֯7��:���۹�ߍ������C$������t�z{��ve���q�����G'ǯ;K�W���{�?u�6*�>��cI���H�ҫ�7�L*�����F�R6xDW�����3[�N�!�:K&xu��C�� �PE�@
m7�㑟DHN��� ��ٞ8�����1�O"�<�9R���v w��}]dwoH��#���҈~"K�3�h4�4 K�����WP��t�����G~ ��_	����ry�����^�	��)e�:���㕈̦$�guu�r���/=�Ͱ���Dbwb\���?!lP��.Ȝ���*�����	�t�m`>�;H���]����J���T���(�<����7��xG!���Ԥ�Y�D`7�#2�+�##G���t�|H/����~�VF.!�����T��R���_����QǢ�m+;�on�=��<HR����w{]��}�E���ە
��a3Ng(=�$�Q��6�#\h��`�5;0�*�r2#J����<J
7`��@\��/59�6.�dE6�6�f��ms�6�C��~FΊK�a�"�hޅ��*ɉ�%��֌q=,|�����#�.a�A��1�y������ӥֶMh�3 f�#�"��6���3Do�e% �^����� t�X��Npe�4%�J˲d%y���}^�^� �d��dh�]�*������%�rK���Qf_�O-��S�8��?�a([���:��'2��7��6��m>�1���Ҡ�y�5�yx-��X���Ǡ	����c,��%���dT !����2�H6�����ʗ�1EJ�\^�-YGuJ�$�߸� �r��z�!�W��I�Ƴ���o���\]&c�;��by�!�t1��'n��b
�����,�K���F���M�d �Z�w���_m6���Av5CQy�;DJ��+g����I���^�����\��F�1��A�Sw��������z'��^���C�x�G�Gۮ<eg�t�����l`!.Y� ;�H4ώ/l<�6��$���N�ʇ��˧8�?����Nj�FSX�]���9�g0��<j��M�*Ԝ�ࣰ?ӈ�B�^����l��1,�:V��5;6A���}3/r/=0n)�R?03�A�Q��|hb	�D#@��v,*��2�ݟ{`�3�����I���q��,��5��-v��M�eo�-�$\�M68����6��9��ol��l���kj��B�ڑ3&T���B���4���j��؅W����<��ٰ��U��2��i��NU�y��f5p�_����Uk�`j��J6tة����Ι_�G�2��ȕ�p�Y�/��qhTKMN��8��O�?�?H����zn��������iډ`X�_w'�����N ՙ�y3�l=o����稁FF�5
=V��Ӥ���o�O������� a�H!�7��6�p@1���vt���l����Ǉ=X�0�bCj.������&�2$ ����1����%�9���9�~wtZ����Og�c�=�b*���������yb�A��W&T"��k�T,:��7�J:7(�J��s@Q���ď�5w�����N*:YÎ1%��p��_���3/ީ��~���Z1L����$��,�C���1>���R���S�kbmeq3i(�$�C�k2|X��-��@91�2F>3��J�Jb��Xq�N��1�4����D�'/a�b��|<��8+�;��b>7Ұ�\D�ݩl���2��:}�Y�[1RI6V���ZQ��HEƢ(X�R�z"I�+�&�2�~��Oȼ�+�'���Ci�`tߐ0 Ñ]�QI�\'�4-rdߑ&ٖju[��LV��͉��"˫(b?+�4�S1�%��_D'c�i&�G�~�rŬ"$����$k���gY,�_��$��5�E���<J���R:��H�u��<-`KQh"�Y����hfa�Cm��"+"��z��WZ�����=(�T��آ��2���J�AL��9y�g�0�l�Џ���NH]�t��\a����{��>�
�
V|2����!S%,��8������v��]	 ����q�p��-g�F�m��s���pY�y�4A�3a#}���30�X2&��gu ��Pd��,+}�ԘBt�6�`[L��.����E{g:YJ�K�.Y�܂K�D�uj�n�9.٠Uf��X���т�N	_�VM��_�[^��x>��G�=-�[���\.���j�Y����/�X�ˌ��l���}Ic�1��������wr|�_#��-/]��H;���t��'Ppy;�%���k1�,h 
��b؄���ʆ.!��yD�]�&�
X�p'x�!i�����p��Z[=_�ICJ:��Ψ�"cb��t�
\WaK_�
19��|]�]D.�ޯ؋x]Y� `9��}Ͽh��D=��5-8`��M�8�^��0֨e����ɏ{ǯ������p�{ ��H �:�T�/`�����z�O� l��V�|Y.�S��ߋ�E&W��gxn�v�YD��,j
_�dʳ��Z�w�������|�J=�ʟ(�^��@�/֯���c�~>��L�V~
�_!<��E���#t=FW�\`L��k����oŠf�Y"A ���3I\�N����6�߱X�\�9n0a %� ���/�D[�.�k�6�L�rb��`�ٗ����_0��z��V#����zF��V�l����mc��K�h7_����֋|l4[�h���Gk}]�Z_m�`m��Z/6���z��Hmu��&{��G�Anl�d���m�2mG��J��:˕ZQ������	�3tJX�0�]���V���ma����5ǹ�L7)�E'��ey���5 �6?�x�ə{.j����F=ޙxĮ�������:�۴��'l���YoI#����_�U1Ϋ��i��q0�n {ʞ�5׵�Ӣc���V 1j ��i��Ƕ�����n����ݎo��Ap�>O%�5����m�k���� t�(P0��2��(�|u�)��[��/Z=��m	����U��kOhVK�jSv'���q"jU�M�/�2��GB���6L��!�Q�5����a|��bW���v�(���,�^n�-�h��*�u�nH.�V<J`C	�Lu�`�(y耚�]4�5�m/��c*:�O<硫�k�����A����C����䘸,�O���+ك1eG�)���8%�vQa��tqX����-��
?Gǐa'�6��ߏ�������`T�~��?�~��v�y&7���"v�;���k�Ni��N�U4�]=�;�����v�ȃ��!a�$�Y�S�͢!�.db]av)Zk�k	�;������H���*�wG*#!;�� ���|�=R��˂t�$����� 2Q1-�(X�J���Vc9�6.X|If4�N��-�
�$��y����o��1=*2O�"	LBk&�3�(M�u�ɐ���\��pi�ތ.�'�] �#*N*\<6F���a���V� ����[4V�E��C/a)7��0,
}U����|-��d�����Ա��k��s����=@zJhL�C|�QL�~Y+t�����ԁ߳�q����s���+?��W�9�O�8�r��u�{���t��d����/�~"&{�}p����=�lw����6c��Ȫ�1P���m�Ư�wd�� ��4	����z��,WS2X�f�u��(?����i�r�G�G�� ����F�ɛ�1�t�� �
S0uc�֖��U���붝%�* �z�>LT*�>�֚}d_Κ��G�U=�!���ONN��y_+}k�������9:����E��}uڱ���]�瓷���O/������g{�>=y�n��i7�/�/��ڎ0��l�_=:ͳ����_x�o�������֣��T�����]w�t����h{�C�̘��q6<D1Tq��Y�:sמμ��Kҋ�9JC���J�09�jhT�z�⭩�^:�l��<�� �m4���j���6Ltx�>��c���퍪^Vr��Qō�������m��~�~�8���ag��k�i[I|�{mg��>t(���H�JRN��?���잳�z�/��3x �����
紱Hp03�̠�
$O�Os��58 ���K�/�&��l|�}gFI
�pq�:�i���_�u���)�DG�~o.��b��6�����������G���.�`���Z���LX�lУ�W$�v(�%ذ���J���5ę�i��W�$[^�P������w�bE$X�N5>���!�Q�Q���jaq�ЬV	��	NL}��>��8�,nP�l���_3u����t����Z�8**U�&�"�g�����D����O�<���{��d�+��&W���bGgnp��@[(`~N���,8���
W��PA�
q��U����c	kD?Z�9�Y zy���؊V���?=���~��(��<}�Q$"����զ�ǐ/?I��J3A+��"�z@Jv?81,�JE%d���JW�z �^�� y�x:L�a�Ԕ����g0�K^%�X���d^EC�R������j�f����i�-�HMN'~Z]�`ҷ�O�$�&b����kn���ދ0�L,�oN{_�ج=�Z�oRKE�kh��+h��EÑo�_{���4n�y�b��S2X���o������jx{���?�n�h�3�	��;\�*��2߉�P��
�]i�����bJ7��T
�.�u�#�ӑ������������_/��o���� �dG�ޝ�Q:�eT��ѯ"�����T�T�V�\�;79Q䝃�q/�̬+�"�����󄲹��i�0^X=j)[+k�.:h�4�7!�}o�4�6��2�R� ���ǃpD�h���O^�T�b��<�q�ɔ!��<܏�oŽH�>��&�oKK3=��_��_�p�$·���}1m�	�)���L�(D2�<�����V�تg�Rb$�4�\]���	�4���S�34zN�̲Q���dG�>�����ė3w�(�\�MY���6��,�N勸b�"�3�"E>� ��M9'ʨ�S+X���zk��YzŐ(�Wš�?s��,=�̡+�l��U�f�Q�M�/�.d�$�H��y4�3�b����ǠjW�J��B��Q���$5�)7Ħ��(K�4
I�0���Ս�ԾS�%�?�bvO�Սɪ}���PI*!���� ��ay
��V%�W�U�0f��ı��4��fn�2P��y��q���E�UA[ڏK���V0�8;,�*;u/.��7S�	�K���^�+������{&M»��ݎ5�Y�nU{��ǫ��(ҋ+�(�F�¸�X���ưP�Q"-�n�<�e[�+�����Q1���/�o�Y�V\��Ae��vɅ��L�(b�W�g6z��d��"bO+�ә�ӯ�^�8T-W�h�+V�X�j6@�B�(�G��m��ͨ�5�A7��o�N��n�E��k_�+��MZ�Ug�o釵|�~t@���zO�論�:� ���3���hW�Ϋ����w{'�Ǉ��rP�wcS2_	܊d`G���y^p� �]:|�1	�5����׿�������!�)�}�1"-&���,)t��M�=7��6M��io]8�뤃�9�~���mӡc�+.)e�i�����$,�ǁ�%����!u���t]D]���ƍv��d�)�#g-s=ҍ�E2����&���tճ�쥮O71��q3A͉�r���w���%K�x��Zc��7/�P�r`&���s�8�g��Z�FG�X��:r\�g*����Þ�Si����cS�М��M!���'L�f�[�k��p�e� ��%-V5}�[���94H��c*w7��'Zвf���d S������q�F^2[>���9>��kO�)P	˫�������<����G��G����4N��l��t{��N�b�0�:YҖ�y��/��G���aǻ��)��vwC��#��.,>A��<]a��	S��}Z"S���ͦ��B+(5z��=�6��"�C���h�j�P(�2�T�L4�U���� �u�6-�'y�*p��fX:����!��,�Ó/���E�c]��*�O���^Q��hZ[3s�0�+Q����w/<�b���V�z\j��Upͳ8�i�d�����\-�<�Tqe�He*���M2F��m�AeB��*�Y��FeEQ@x�T���K��|��C��ʋp����~�^'�ӄ�i���9�:��a�[���W�v��8v�ؖyV�*Ց\���Jͬĝ�g%l�RV����2��]���	�`��@�{#�x��X�^!3����G��-���sf�![V5�4I\���,7���ҵ*��d��t��U>R2���J�LW'D
��u(uK>JI�w �����Ж�_���~�h9�d��8����W��u�LA�����'�3�y��`��a6h2�����y}���$�:h|�o2�X$M[�c�%��Ƙ�*>o!���2l�0;����E�8����	��<����g^c"�
ynf���Î$xL�ɚz�U��w/E�
vr�ъ[�]�gn�Ξ�$Ǌ��fP�*�4����iV��x�[���1�/�W�m�!rV�܂C�;)�}��gsC����Mi���t���G�.>���L {Z��rs�3�iK��-��#����jHy�p��X���cI�GK�a��Y�˞�d�ŷ
�"�UVW�Hj��f�&%�]ejJ�^doԼ��C�X�oT��bZP�^�'5������f�f��UWnU��V��j�	�l��5��$�9n��Fۖo��I��ۇn��ʓ����/�	�Y���T!I���f�ܨ�����q�.�ږ��B���xTa���DN+��q�T�����}N�G7��Msy�����%��iUB:-<�椓��2}.#]۩!��x:{�$̆cVaF-�!�7��hX��~��|k!^o1�# D����(�k��BYB�m��3[ڮ5��Қ�[�ך�w-咽��|�`
����>���@�u6�z�y��5�"�5��^�Op�-��7�/W�o����>f���j��1�L�]rv��>��;�h����3{x�r�4��\l��o�ܑ�a�9�hl0�e�&�_Vi����G����0����+׵��杷2�%o��m����,��㛹���l�� �W���R��o����4{D��ÜE����n����XCOTy�]�ޤI�1�xxdQ��n�i�ܡi(����~P����<�e�r�$β0�*El\�53S���f���*���'�6��K7�Fg�*7z�@��
/R0<�~a� �-�	����%^��S��1e�� �s2H������$r.�O1p��/��-Ӗ�)�JbvGFU&X��d|0��M���m關��i-q������fگ��F�A�i�J��Y�ё�3�´E=��?3�%�XD�O�'S�d�t	��=;�q���B`�����qZ܀�*�3���8�O����������~r�4�>m�Ь�Qs*7ѽc�j�PՑ[�J��g�
�+h ��. ,�<қAU�_*ҫ���r��Zױ��0p��YI��R�r�M[D�T	�!����NQ�q4W��(e'b��#iJ�df�-�����E���^�ug��{T:}L~.��PSP��s���J���MXig���*�i����զ:�W���6[�H6��W���\i��(���ߛ��$�����,��l��!Pu�e˫ʛo4g:3�U'CX�0d�p�QO�zqv�[-�VjϨ�$'�F�I ���c��Â��������h("��LC�������?�!R�g8������Ҋ�B��0�xT��J&��rΣt���n��"gj�s�3��,�IP3/>��ayt��qwl���p��Hm����Ao��ͩn�g�t��✀�,�ȭ)	gc��L>U�2�	�s�V�1C�[����{�����n3�`~V��,� �tX�<3���;���^0�4��,h��E�FoDYhg�@��s�2�yG�弛� ��.��]լ�k<����g��ř:ehk2�R�}?I���
���H)p+���ï6������\���2���M��(�W� �wU9����¹0F�\R/����s����ɩ��v����q�� ��e�]��a���N��Q��&1e������~��CvL̂;A��ħ�(�ģb.�&aT-���%4A	;v���%�;b*roJ&Qx��D��� �����Ćf��f�P��t���_��y�C��\���9�v&vN;A� g�Θ���D�P%,#	_���F4�̾<�-�D�j�NɰP07cr⯨��K�*>v^0��t��i�'�7ΊE�ù�V��|kUN��ZЏU�M|��Ea�w+�˲.V�>,��{���|�و�~�n�U�^�.s����|�c�g?W,M��nce��vV�vr�,�4�X�o=f���B�*_��[}���B���]���[��K�P�Ke�������<]��w�z��>h����������}#Pp�_޽b,���I��/-)�����4�Sn&��*M�0�4�(*-�b�^_�6l.�$�*��
S���Al |��W(���M ��U2�c�w�g�������U4f���Ǹ�n�Ɔ�w��na��w�	A�+�<�-ÿ�����i8>�Ҙ�rK*���2�*�?��@+K0���Wǜ�$+�#��S,͊�8,�h�|	E�՚̻2V�ó]�(�L)^��sp��+�����tq�ﭔ�+yq��o|�n<���Q*Ռ�x9c��Z[|F�Y����?�H� k��!}gM���JP\r$g�D��Z�	��ȓ$����q���qhW/«K#a��LƤ�K���7�J�����=��4��|F=6k܇�B�h��f��MN�������������>���g]B|���'�1i
xs�X'^� f���k��<V��ٷ�&����}�SW��٩+	q�b����5E>��P	�Ouj��h�ƨ�¡j�z?o)�iP{�l깉��X𡐳�N=��1;,|�'�bT��9V������Y�iV惎˘�?����|s��k��+�8R��í���Qh�����"=���S��z������Ek��N��0�6���[Qv!#�s5�P�o����
%��p3�3����Q��a1��GkO����n����t;�so�|�M���C�g1��Pp��rjQ~�b��QL�(���_6��?}������VJ��?��/�(�?f����ze���ۉ��˷M].Q�T�S
*f�E%f��%V�	����%����x9�YE����c_�Qc���o[����~��iBQ}�J���ɬ��牢��P��tדaY���?䋽��*��,�xA�y�t�t@����H�hN#��G���G)zg������[��/���2U�����)��&�-�_l��;�LὋ�%оj��7+�+��g�i|�����}�yogԿ���C?�SA�	Fd�����a(_��?�"э���+	,�=k���e��J4�Fnr�{0Ss�a�ς�.nq�l���<x��f�V̾{��ݠ�;�����*�8q,�~5>�����'r�ċ�ŀ��0� +��`C�iও�9�ϐ��&F?���3�n�?Tb�+����2�m��~t�8I��I��E�fS�M�SbR\>#�9"�|Fd,���C�G��5d�?+v��j��Rq�>3���ԥ�MV��ʴ��`��+�1uD��=�t���7�%��_�2���������!�-X�=�	��V��*�^z4H��=����~H��!���� ��a�)L�|V?ՠY�h����dX5wF�L'��L�n��4ޥ9�0-�����/�������I*�O?�����f�?\���R�.u~�8�EMܶC<�"l)Bh�r|D�� ?�V둶CR�7AJJð=v�z�c���ӣ7�[ܛa=#ݡw���~[�Kv±w���xI^�6�5�Hb?���ҏ&>~��NL&�鏝�;!����jg�t:P���:T9{�aq��+���9��@x/���;��#��C�d&:��G"J��'�^I�ݘ��F}���!Y�����)�rqW~�(��c��kGǇ/�����/��O8);��������������\�.�2�!k����c���e��=�, �wh�	/v#�қ�! �Y�S�����E���< f���(��Y_{���k����6�΋��'[b{��w�G�'{_�w�'�o�wz[�����_��}Nڇk����x?��r����ï���ק��Ua�>�L����r��oUM~UW�����u<j�jQ��{/GcR����{�;�B�ԋQ���?.�c/�	W��3�`d�:~L�臩	R�も?�6��[ bV��}o<��6�q?L� !<�d�HC��o�6��@<Xe&������K��H;��G�B�(M���6����١�#����u�����_ y��Ό�����}�l#<��>{�.���;�94,�oB݋$�lt��Og�۱�� �xIw��p�^:����4	ۜr��S���rǥ�Cr�G�������.���{AS4�.�vN�l�\'� g�c��:4`�F��i#����5ƅ'[ˍw �u�!,�n������;6�_@������a%����r9AL	LFM������&cb�8�dc��9�&Æ�r���&x���h�Mh������.�8�cdGEPw0�}:2q�x:�r�fm�넀?�+��
����b�޽(p�A�vz�����oPH���r#��F#2~x���,7`,w����'�T�h�ߣ�$r{���b7
v.j���}�
�f��;;M��A��0n�����9�ě��Ϊi_Pi�u�;��O���������j��]��;��);D��������n7�Nb�|�Ŋ�����G�o^���>I��{�⠼�k!�ol���65L�7�3�G���V|�{����G����s��&�;p����h8z���<t�`���vN{��C�)^�C�1y���:0�Vi׉��A�.���*�m&�����	�[���3�N9t�]���\΅=��5C��}V\������wT�i�BN���K��n��QGp`�%ć���6q�����V����e�ɗ���b��!',}���	�ʞx�����:�ދ�>Hw:��ѨE�wc?���M`L <�G���x@c��:�B*�]H04�H<�~�ެu�^���6����0ƛ���!Jb0C0>�]�"�38�3���ؿH�7b�g $�qA#�*d&ι�ֺȃ�����8�����(�q!���/f��QD��U�t�_�T�҅�-���b4\��X�;��1�L�W�r:���V�QTD<"`�I�h$]��!a�8�d�9���_�0�F�G3�`�G��>`���9Ɔ8��0N���%w�yY �����}�Ƚ���~���:}�~��ɻ��2̺w�f�F�E��I]S'?����/���mo�q�-a�.1��2h(f�����G���{X�S cW���_m�{K_��vvv�[ç�ڝ;Y��m5��-��"P��rJJ=y��+ZS|�'e�K��KG2�r�׉�L���O;;����/�Ǌn��M�1�p
�v���'׿� }���d�WJڱ��x�DJ�M�I�.�9����e|/9���P]�<r�"_�S�g��"�r�P����T�w�4#R��X(��%1j���j5M��7�b۔n9�ce��pe�}���}��4�.���J`�A��D_"1j�E�K HLW��N5}5ۨ���J'����`H>~���-پ�cXX@#�'�[��&� �R� ˽�˜�I�Ob�M]I'l$�踰�"(M��:[V'!��.nL���"����N\���?�8d�T3�kt�>Fcࠈ���p��4'c ��(XM<�-U %�y��_�eM�e�f.��\�M��b{�%��.}<����/5	�eS����D����(U(E�1����ijی���t���qog����F�.�Z%[�j�wC͚�cv>�$^�Uj�i��u���AȔvM�~Lw��U��%HAuG@���]���R�Ey����#���{?iQeQeQeQeQeQeQeQeQeQeQeQeQeQeQeQeQn������ @ 