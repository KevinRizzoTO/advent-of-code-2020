R1D1=$(awk -v right=1 -v down=1 -f ./solve.awk input.txt)
R3D1=$(awk -v right=3 -v down=1 -f ./solve.awk input.txt)
R5D1=$(awk -v right=5 -v down=1 -f ./solve.awk input.txt)
R7D1=$(awk -v right=7 -v down=1 -f ./solve.awk input.txt)
R1D2=$(awk -v right=1 -v down=2 -f ./solve.awk input.txt)

echo "Part 1: $R3D1"

echo "Part 2: $(echo $(( $R1D1 * $R3D1 * $R5D1 * $R7D1 * $R1D2)))"
