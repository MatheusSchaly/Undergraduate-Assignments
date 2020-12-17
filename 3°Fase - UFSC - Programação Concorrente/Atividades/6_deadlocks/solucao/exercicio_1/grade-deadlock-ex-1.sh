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
�      �=�v�8�y�W �㐲d��Kb������O;v6V&}����dq#�I�Iw�c���<�'�m.$����̬qrL�*
�B(01����k��Yj@����gsk��>ez�lo�7�����G�f�����l|;��4�b'$�3��ܨnQ��h����}}-���oo���^R���C'��f� v}�����3�������4�����y�?y�v�zkN4������g�<<�v�����oO{�fe�d�N(q=����B�9#K���G� �;$S�D�cR�%��C�}b�D�:���d�ϼ�cC�~rc�d/#�?�+PTϙr�́C#dX�[L�j���X��񊆾G��D��s4*�VV�Ww����up'u��]2�����vv�o4���>��LfCJ���믎w+jV�z�ټ�Ľ��BzI?aV��b~��4�1e�;��a�� f���NX k�"~Rgh�4U���� ��`�j!�q�*�,fhs�)�bA�:tcZ\���O�Ð�����	/I��re�ߤ�3��<�� S��4�E�%�&O#��d��5F�q�I��Ƴ�#M�sS�u 4I�4x>�A��?�s���F� r���F���V�f��%�9l��a�ĉ�_#�(/��iDcs9)&���_�?��eY9PF�V�`��H�gY�0n�4hi��M�F�e;��-��[;�Q.mP�!�/؀��Yg2�f���7����Ȋ|g��<��n-I+*�֟%�FM+�b��i l� �l&-��,���cj8�"����W��m�[�m+��TwRMf9���4E����~E�ti�\�J�3R���!��%���~LΫ�S�u������z^�Ey�~��Z��B5�}��￝W�~?O������2��ܟ�������Z��U��pfY���c�&��fAqg1���ȗ��}���H�Z�o% ڴ�m� �知�ԣ��A���؇u
�wqV��۽�D�uO���:W�@�ӫ�,pN�;%\`�M�
smȐ�\�e�	�ﳕ�$ݥT�y�t>��w�Q��L]LT��z�`��Rw��"���A=�T$��&�Y�fMP����Rm���|��ՂDJ��{��)Ђl��I��μ;l���I�џ��2�Y���%�+;�D2&C?����+��K�{|�=�_��������!9��8 �H��Y��aCqS9; a_�F�4�I�45w6GL q�O��r�������?3�Y`[�H�ʤ�pE!ڍ�U2B+2�f�p)`���Ĉ��(`~�i���Re�<8�`�.�1R��dB �����\3hň�E֗M䈽+���Q���x����в4�nej�aI'5�N>�h0�#�6B��'��e�¾6�Vbq�6��f���i����&C�?���f��b�y�BJ4�:
+}<b2��N~�{&��rifz4�̢����!q@��r쓡;�ډ�Tch��|�2�gĊQ�#E.P�ٗ�?"f�!��hv�����Xoe*�R��՝(�J��.���:�ؐ�lB
\5�!b��CVVT�U�Y[��qH������\|�a
�G��(�=�JŸN�:RG��I�����9`�J�ځev�8T��~TC�����g�b����Ь"	R'��vrp	�+!�3D;_�6�+��:���Y����� T�`B@�H�@V:�쟬17�`w���r��P�E4�!ڈ��ɺۮ{\�uU�]Y������Ҿm#(%���Ƥ��1�BS�y�	�Ś0�lCpZˎ�z@Q ����]�y��S�$��K�����ćH�r���M�_�U�MRv��2t��~����ձ����ʝ�nl4Z������7�x�w�=��u�Z���wǽ�R����N�_u��+/�݃���,mTP}H�#ƒ�5�ￓdmH�ּ�dR�L�(��4Po�����#�"&��`��	�bw2��Y2����$p�R���*��Sh����$Brʗ�� ����g�Wȗ��a~���pϑ����[Ԏ��� +�}C�,t�.��F�#Yb�)�E�	�Yb]��-��"�ݤ���<>�P��J ��t���E��NH�N)�h���>�Dd6%�?������K�W�x�An��L'���g�1a���tA��U�����h�m�9�A
���B���P:䰌'��װf@�E�i��?��L�;
al$�&��*$븱�!8\�9|�-���C�x��'��#�2r	���ƿ��/���������4��:���������~��������Wo���ɻ��6���*��f��Pz�Ip�}m�G��`���kv`�+4T��dF�/���y�n�J݂�8�_jp.m\Ɋl�m�&1���Um��l��������E�Ѽ3�U��K�a��zX�?v_�G�\�*�Իc��~��ɓ'K�m���	g ��G�I��mxSg��V�J t�56�˭/ ��*bǝ �ʒiJؕ�e�J�,��}������� ��Ђ�U*)a1C�K(��`ͥ�̾�Z��	��qF*���P��/o�v�Od,�`hm��|Zcr���A��Pm�y��	~c�����c�EM��1�\Òpjq2*����\s�`$z]UH|���"�\./󖬣:%m��o�F�V9�P=����$}��jk�7j��t�.����=M�j1��ې���q�7�g1B�@�`g�ܥe�j#L��x2 T��ջ�Y��_m4��.�Y��E���)��/f�f�g��^��x��������3q�N��$ou|'ȕ�l�Z[����C�罤'���������N�ڽ�i�����O�O�]y�b�=:�	����R�`��8+�<;��1���O�6Z;�+֣8,����l�yR�7��5[!�x͡?� ��`�An�v!̉>*�3�� *$�eA=
��1��:б���ٱ�g��y�{��䖒*E�3C����&��H4����h�`F��|&���a��L���c�*�v�q�!���g�s�]#`��Gw@�[�H#I WeN���-�x��fE1�[#:[�f�����пv�L�	�����r68�*��Z�:v�U�$k��3�f{v��f���Lvp^#�SUk^����Y�0��!�"a��(�ڢ��=࠸�s�����b<r�9�m���zCpת�&������M�?�������zn�g��x���#͝���e�uwBhz��$`P���7�\���N<�`~����h�F��j�;�}��x������)߾�ܕ؟�$�)ģ��&���F(�5�ӎN`��#���������gZ�ؐ���,�*+�ɀ�	�>}sx̨���G	v�ݱ@N����b?a�	A�cϤ�JD ��),�?��<1���+�	+��N��ڵS*��̛G%��
�f�J�9��{�u�a�;{acpg'��aG���{������yi���Tnt?r�w��VNXw�YH��!Cu�	�������KD�)�94������4�[���5>�FsRI���CkF>3��J�JbۄXq�V�"2�4����D�'/aႀ��<��8+�;��b>7Ұ�\D���l���2��:}�i�[qRI6V���ZQ��HEƢhX�R�z"I�+���2�|��Oȼ�+�'���Ci�`tߐ0 Ñ]�QI�\'�4-rhߓٖjuS��LV��͉��"M˫(b?+�4�W1�%��_D'c�i6^܈d�b�Y5DHKA[I����ϲ������Ҹ���o�P8iZ�ZXH�4> ��9��=AXD!�@v���ԢمyB�5�����s��)._i��^���d\ZQ�c�VVʴ�C��+]t55+��5�\�|�TB?zL�8!u1ӹr#p���3��j�x�3*X���{ƈL�����h.���ڡrw% �J*�S�9ÑƷ��I��6ωN_h�e��L���τ�������rɘ��6�Ձ�RB��V��d�Sc
�ڀ�m1=��ܶ2h#��d)I.y<G�dq�r.�q����)�d�NT��zc��1��&�pJ��j�̧�j��=��9��8�i��J���r�%\�T�HOӜE||���\fd]�g�O�K#���&��'�'�����&���5��d���YH�}��w��Y�:Ͽ̂F�`�/�M�X��l���GT��o���w�a ���Q)0,.�Nǩ����1�1ԡ����z)2&V�J���u�����s]�ץ��B�����h�Q�וU �C�������K�3��Zӂ� �>�����E��c�ZF�����w��*�����%n�w@�9 	$Zg���̾G���^��)�\[ D���/Ё���T�����xQ������@��x���9����W3Y�����r��)��=�T��c�h�\���`�O�l���5�����pꇱO?��s&_+?�ǯ
g�Œ��]�����+b.0&��5�KNǷbP��,��V���,.W'��Q��X,P.�7�0���]�χl��e�����uwE�W9�cf���ˎ����/o7���k��Zm��3Zm5kdk��o��_�G��F�W��o�c���G��>�����j� ���>�o���|�=�~{u��&{��G�Anl�`���M�2mG��J��:̕Zk����/9�Z%f蔰�a��ػ�W���
[���9��e�I�.�!�.˃�w�x��AX��SN��sQ+��qijԣᭉG�Jb�_�}p0�8���M�.Z~�&�X3�MiDԚ��ۼ�"�yp9��b9f�`O�С�vu^tL�=9�J F�;���O�~���8����r�8�Z穤7�fX���� ��d�^�	(�T�]L�(���LSt�h�_�z.�?��-��r�מЬ��ծ�N����DԪ��_�e�M)����'�m���C~�>8k���/�㣆��$�~֮6%��6�������@"�sf�\6�խ �%ԊG	l(!�����%P��&�ƿ���;LE�����Ա �������c{���ǽ����䘸,�O���+ك1eG�)���8%�VQa��tqX����-��
?Gǐq'�6�Ŀd_S��`i�4��5��~�����ؗ2�!�8���*bX�S��f씦��$]E۵�S���^�_��a�<�NfA"�e8��,B.�B&��g����vʱ�`��oغ-~�D*��"qs{�2�C�'d�~�5z���� �(����($��LTL�� 
V��᮴���X���_����S'bK��	3�N��\�-�<�E�IW�"�Ih��w��)��;�S���.Mbכ�Eb���$~�`rD%é@���ƈ�^�3�6��, 9��{��j�h���%,�0�E���t{ב�E����~��:���V.�����Ã����r@c:��ȍb:u��j�3p}�6���Ŏ�D�8 S~���1���kg`U���~�{`��nw�̓S���я�d/���7��#������~�a��ϛ�ӁzdU��T��g�W�;2Ro c�����z��,WS2X�f�u��(?�����r�G�G�� ����F�ɛ�1�t�� �
S0uc�֖��U����Ɲ%�* �j��OT*�>�֞}`_N����UM�!���ONN��y_+}k�������9:����E��}yڱ�w�]���7����ω�����{�>=y�v��i5�/��ڎ0��l�_=�;ͳ�w��_x�o������ͭ��h��������A��_-g���1���1i��l&x�b��>'���u�=�y�E����s��xgk��ar*�Ш4��[S�1�0t^��y6�Ab�"2h������5�q#�l�
��e��/)Vr'��(���N���|�n6a�ȑ41��r�r�D?&O[�U����{����� �eEI\�����h4��F���z��I:�d������v�ґ���
:JW:�@�K(�`߀��<��rm�kM���$����,I[!NP��v�^~ށF^���TvD�{s!����IasځP��a*�w���M�#��Us0plE/"Z�&�d��Q�H(�
�6�,�(�;y	��]�J�dk�kj�|ctv��C,��Щ&����17�hkCT��k�7,�j������s�9e�A�gq�t�Tƪ���hOB,�qT[�J��qTt��MDM$/f!���s��l�����L�������<�ojŪk+�pt6���x��(`~N���,8���
W��������W��O�KlK8Ot��U����+J�B�V����6u�g�`>�a%O��B4�'����S�c(��$΍E�L��@-,H"�<���=��Ex,�IE��$J�`k]��- �[����9$��Y�p͇�Sӊ�6����@��U*�M��t-})+���dm}��(P�H��hq�0���L���H&}��OrK"&�lǋ�ho�9��W'�_�٬=�Z�=ꑥb�5���5�������8o$>�*�0n�E���:O�aI���ux��&��"���=��4��q����x'��y����ԓ�H�
�Ce�ɶ=��R��N;�Ԣ�pD1���������_����|���-=\���9d��H�;�xց�w8�:y���e�b	<5:U��9W��M�l����8� fޕ�zQ�VJ��GB��mi7�ΈZbk`e��em���#d}��M���M��l�T%H|���i4�8�a �w`�Nm�1N�r2eH�"��#�=���Շ��M��2c0�~ɸ��O�~���i���4�=�}/%��<f�=ic9��X���*<K�� �-��f���-A @�kȮ�NQg�����.fi7�G:�>��aV�����C<�:�bS�+-��ˬ����|W�ZpaR��������9QF�Z�i�/�[k6/�+�DA�*������,���-tE�m�j��yԆt��K��4�+R�7��J�����!0���O�j��Si�h>:�>�A�ƻ��i*�y�X���A2!,$d$ru���wBX!��si v�qYwLV�����J:P	a4��al�6V��oU�{%\�cѾ*KY� ^�i�p'%ں���"�.�v�*h+�q)��Vn[���2R�)��Pf�L��&�.Q?.ս�W"Xg%�׵|&������ꕵ[՞(��*|�&��� 
�Ѫ0n�Vl��1,�n��@7Rr�r�ʅ�mA[Xx�ըXV��w��,e+�^�Q�+D:v��ܝ�Ezz5g�8����^iAĞ
�ݙ'_����@�\Y��ڬX�� F�l��&� i���/�1ʨc4�nA7"�o�N����g}Wo�}a�/��
=y��h1���g/$�l�<�H��6�~ѧ�t�?}����=���6Ю��/v�����{|rt���z70� ��@W$�R��F���&�`���?N"F��=�1���g��4���0�4Ef,}�A�X�K)-�=K
3�g�ǣ�ٹa�)o��u o�F���x���]�6�]�Rv��V۪�x�À�O�q ����p2�Y݆�~�]D���Ǎ���2΁�͑�>�2z��@rO��@�禓���~��t���7�-�\M�����M���</�l4&�}��j`Q,Z�� g�B�]��ӑr�뽉��������k���7�+MKQ_�9.�͙�o
���U���׷��z���e�!��'-�5}ʭ VZf$���ݞ6�dF��L3��`j�1���vܨ�%����WG�{��k����UN�c�Ѳ�F ��vG�d��p�����t'��n��dk��M�b�p�&YҖ��Q�UM��^	��v�+���Ng'bo6	��U2��FP�k#L��x�.K�X���Tc��i/��R������&t)�8�C@�zW˅B�ˑ�Y8K0ٜQ��'� "t&�N���$�W�T�K�Y`�͂1<�2�9d�6e��J�j��������6��`����!���E�R�r�^K�ǥ]�<�#�fK��Y���2/�HW��T��AikP��h����x�L*t���EaAjT�h� (�=]Zi�d��ǹ�q�E����T�ܯ��$c�0>�����s6Ąc����"�U-��p:��9l�<+Z��H.-NQ�f�A���I��:&&A%�����|L�c/�=Q�]"���FfAe3揔�-��6sf�A�N5�4I\�pG� ���ӵj��,����T�h��Y\�XJgZ�)`w��!�TJI&<��@�E=te���ܸ7�#GKF�ȍ��a��θ���f�L}�?9������ȓ=Ç�ASǎp�8�`���s�*��ҁħچ��+>��MN����'��ǘ*�oa����ؒev`(�PL�HH}	h{"���ų�1Q�B��٬ �����8Ӽɲ��T\=��%��`���N���b�R=���;w��+ڑ�A[���2��wgX�7W�Lֲ0�4N�^Q\���(X�q�;)�}�3����1α=�
���QvNQ�?5^A����u� �"n��M5ȅ�Uϕ�8��A��j�!女�y39������%�O[,��\�\� ��Y|��,RYau%��n���l�}R�U���E��E�+�y(y��o���0-H��ϓZ�E��y{3�a����rU��V��jŃoO7���<s;���쥧m���f�������O�IX
��,��,n��tHJ���k�wN9ꫝ^���8E�ږ��R�-�x��_�JNNk��u�T�����>��cS���<�����%��*!�q<��S��2}.#]��G,��|<f�0{�
3�: y��GM�ǯʷ����9�Bv�J����f�/�%Ts�������:�h��y�����4���c�W�=�AȴLϩ'��\�v!2\��\ݥ���9��� 	r�{O�~��1����A���V��K�n���3��x��=wo���6����r��+��F���v�.ˮ�~Y�"���[[����0��^�k׵�o������4>�BIm�n�ڻ<��㛹��v6�� ��rz���E�[�����ݢ��0g� /�*�[��7��0U��Kb>�z,�;��-�R�����s����qX�dUs�0���y8���+I�ea�*El\zzka&���'���=]�-/�S[/Qĥα�Y�ʍ; 1��Ƌ�۟2.�6�[����pG/	&I4�b�S��36�.���$`Q�x{i2�/��b����K���iS�O%1�#�*,�=?Zk�ʦR�ⶴ� ��iZJn�d��������|�;3�_�R4�����³0m�<��ǟ���%�XD���'S�d�t	�r"{q�@ߧ��:8^�wN
�7'hq~���`av0�'n3.�z��)s�fiA}�N�YY�T�0�c�j�Pב��J�g4W�@P� `����3�R�^����c�κ�=Fo�U��'�K�~8hb�"��N�S��8��-�>�\!Me��Y���V��)����+]�)�S��"y$f�[/ˆ3��{$��%?�T�Q[P��s���J��ܚ�2�h��UN�0���զ&�W��3����$�e�kǝ(l��Bi����h=������_��#~��l��G��"��9�W��o��3���@��V-�%�ԓ^/���e��h���>KrjT�����6�����UFӢ@�QQNf��C$k�?C�g��s�1�C�+���)�R�a���וLZ��Gt[��n��"g�s�H�$��->��ayt�5V�ب�wq�Hm�ݓ��;�N�p�?=����9���"��$\�es3�T���{ďfΡ;��=��>��{yL(��ge�Ȃ����=û8�V`GЁ�8�#-�%�]�.}3<��&��6Y���A��s�1�y[�弛� ��.��]՜�k"����s��L�2�3�J���O��y^!�\i+n����p���.��)֐���u>��=t;I��_y���
$d�9ɉ�s��rI�$��Uu�	|S'�FB<�.�ӻ��&I�P&�����6��P�N5�:��EL[�~4�NN?���&�;A��$$Y]�V�b�hV� ۙ?J(A	�v��6ü%�w4�T���Mg���U RtL"���iO:4��53f��E4�!\�2�#q�.D�:<��Μ�3vDP;ș���8	��e%�>��M%�/�i1Q�Z{P2,憃bB��+R�~ei����[���+�[�t��Ģ��\Q+�3��@����mUw�mQؾ#����;����U����Qf�[$�7b�_�;J���2g�i�T�z�E���Y�Z�����]���\߃�ak@��,�^(T�ux���TvuC�U�i�?�}�����;�n������k���>\����.�������_l�� l�0��������+�O:?���#Ը����?�f�j�P����OQi�4����rC��*p�'1�YQE��d4b��m��Kug�i���Q���sE<~ 0���1�����2�Cǆ��Wt��:���:Pf��`����O�x��t�_i�E�#���UP����:�ʕ%X_1�c�^����G��@��{�(_Be�&����b���?��S�����%����g����������J^\�g�7�j7��dF�w�J5++^�8CIm,>��,1E�,<�H,� K����9���K�䬼�h�%Y��V�$�O�v�[�5�øz>]Z	�U2&�[ڶ����*a���b���s�(��}۬�_�n�d]/����������K<������T�>��ad]�B��"d�R
x�klϳ����:����(s^���2���g��0u�,�-N]E���c����ah��Y4��C��N�н� -q�x*�p���O�wZ��^x���X�h��
5{i�)\�����9��b�7��?>?V��[��g���e�?%�8r�
}�[��^y�ׄ#�^n�֐��F#����֝��:���ӧ|$5~/bXk?v䈇�Wn��^����2���i�Cm64�[<��Ž��k�����(�����g�W����x���d�md�[o�|�m����j�~����Q�#ȩ���y\�?
�i0�o��/����?���ݵ��Oj�}0�0���o~�� 7o�;P|�W@�[��ĭtj��B�a���7=�Us��w���h�>�����Oٰ�$J�Q�K��?���aOadmk3��f��Q���_ˣr(j�R�����|����)t��+���\C�j��j��������w��e>��4�e��+�L]C��ѿ=Utb=�:���.�ߗ^� m�/�ꀪ9í�4%�T��c���?��d�y</�4�y�wq	�2,U��ci�=�V��}y��`�7��(Y��������#{���x�.?.�sf�5��Z����(�D��4إ�_�P:�s0���pc�a�(9��(���L�L�9���J
ս4��-�o00y����~��?[����t�s`����)� �E4��y���p�h���v�Bœt:�h>��eF��65��E{�q�J6ȷ���& ��V���E�wt��!�3^��	�ojR�<QkE��D�:@��l����ݭ}<g���d�$n'�HC<�Q�)[�d��KJ�g=�D+�1�Ch�ȌG����B
��g�|�d������`�:�m��M�s�r.i�1rsy/���I���f4_�lpi:�e���>���"�a�f,���|5vH��V���E�c��6�J�cӶ��y���͚��Ѧ��׈�1J��D�(�G�Y)�� gz+$D1ZT%9<��:��JZ��%�o�֋ �3_���/AU��C���d�+�Ŧ���^��!"��ֈU�2F���Đ�����l�<Ybi��0�f�����q�o�*=����0���	B�qĞ��m��%�jWD�YN�%�V�a�/��e@'��N���`6��� ��j�������#���мT���4�*}h��a���d>�.�*O����PF~�n�����ۉ�K4�?Z_ϳ�W���������w�<\꜆�Ω_��m[,\D-9��U��أO�O V�B�"G�@P �Qk�xe�u�����ɦS�9뀬�L�֭=d��8���O�)��5ۅ�4K���	�-�J��������د��4{����^a�6�?d���D��qm0�O��i8�?��<[bف�֓ќ\�~�D�J�KǓ���n��F��ca̺����c��R�KЇ�&�$��ǵvG�m�v����hI`����e�=�/��^�e�]�1{��#~�A&�A���°p����������'e��`<p[>_�)��Z����gݵ���;y
ܵ9a��ݥ�\O�bo��%J+|�k�S�Tv��i����p��(�>G�K[���Z��|2��) ���߲���{iH���	�Ξ�nzK�բ2K8�e����f�����O�%WpdR�l�!�
~�/�QJ�0�n=��l��2Gh�����sJ0X�fr��ް��^�s,�^�\~���z����v��Xv44��,CcV�bB�����,�n�~�=v��5T�A��8V�S��i꺢ꊘ,"Q�ğD�(��e�Ϥy��3�֙>v0[��!z�4z�����F���F��L��`�34�!��jw��ܿ���\u�
�yꂑp�T<�$i(��O��%�*����	��!(��/�7 �=�ҒR�{�R6�
�c�	��������x��6/�>���4^l,d�I]h�U�xY��&X�b�����zo�T������Q���v?Z��}���w��g�[�o��t����}����:���\�v������u�Z]��k��9	����^�KL��&�<�j88tٲ�Y�cBϷ�&, �c��|"�j��٤ھ�G�����>���1���~��r�x���M���'��8�]c���i #�I3��yx	V{���ڄR����E����YЊ��nc�k6�}�v 
~!]7D �(�F� �8+�yI�6�6��/��s(z���1����oo�;�_׿�$毇���U0;�l,4�FL������V��.�|�b>t}�r�{P�"I������V<M ОIg�cP�^��z���I���~h�X��Ӂ!9����:�/v����g�t���G+�!��?	�;t�����g3?|�����.H�����G�7 h�φl�=�j_�n��Y�/�ci�)-�iRWnjZ �('��D`�sj"�(����B�xyg���dg�[�d��$n�u%0Vq�����Fk�󃣭&�YpL�Ȏ0�à�Y�6�#S?��q�ּ����}�с��0���0�|P#`�����G�ǌ��.�M�5b��Gl��b�){Ԁ���;�xO�s堣��Ciɔ������5L��E�p��D��~����Xk�5��*ފ/�1��'v>��I{E��^_�4��U��m�
ؓ�����ֿY�w:O����
��T��K�?~"�m�|��@;�����'zG��_m�?{�r����;?a2P����76k�f SD��p~~N��9�r@�CtA��s�������8\��p��'� �1�̰���ݝ�����"X+fkϗW�y�B;��M8�=�r��&B��ŶV�k� ����i���O����r!�����F|�0'a���W�~��Θj"\@!��=�Gp��X%͑�p�M��/G����G�'����b��� ,}D��$ge#�Ưk�R�&��ώ� �ir�#0I�w�0��	/\���@x�G5F�?f��K���8�R*�>-$��H<��>սZ�������f�Vx�x��5@6DI��G��̾����Q���77��H��_�:�6@&(V�F��I�L�s��u� ^b*?tW�I8����@)��b!Q��MR�1�h���N�6��--�|�*r�h�h�_r�n�:��3!�7��<t�џ�R8�� �1&�F�FЪ����d<_�q%��^�ƿQ�QH�=�B�> &�Gq��79�C�^�?������}�ɽ�D�������>O�7��{3��ek�euL��������ӽ����N�%l}�,����Y�8jj�c4�L�=�=(�1��kp
J�_-�{+_�vlid��e�=x��(�VH�/m:�ـ��u�(7:��9b4%��/qR��� X:���`u�)�� �E~�� ���`|�=�t��7��K�9��G���>��	軤�1N\%q�cm]񂉔\����()	0�����]q�2�E���Hy�"E�bU�g��"�r�P��1
OS���Q�RF����P�f��*�}[��뤋�� <8���Y+��"W]�c��:-��R!0�����\"1�i���J�ҩf�f���t���������7l�2�aa�o%� ]YuG�Y�e`]�Of�&f�c4"�G�d��V����~�[�/���R
�E�58����7���:����x��pB�a\��8̈́�n�������@!�j��n��� )��_���޴X�j��k�X0����0(��A�f��2Ġ`��J� ,=5k���jq �QR�"	ؘ����i�m��0�q��hw{����F�.�Z%[�4緡a��q;t� 6
5д�����"dJ;�����,�Q�ø;���P*�f��*�RxQC>����D3��'�?���s��?���s��?���s��?���s��?�����]|V @ 