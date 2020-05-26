-- Run the code as: solveIt x y
-- where x is the values vector and y the colors vector
-- example: solveIt v3 c3

-- 3x3 example board
v3 :: [Int]
v3 = [0,2,0,
      0,0,0,
      0,0,3]
c3 :: [Int]
c3 = [0,1,0,
      0,1,0,
      0,0,0]

-- 4x4 example board
v4 :: [Int]
v4 = [0,4,1,0,
      0,0,0,0,
      0,1,0,0,
      0,0,0,0]
c4 :: [Int]
c4 = [0,1,0,0,
      1,0,0,0,
      0,0,1,0,
      0,0,1,0]

-- 5x5 example board
v5 :: [Int]
v5 =  [0,3,0,0,2,
       3,0,0,0,5,
       0,0,0,2,0,
       1,0,4,0,0,
       0,0,0,0,0]
c5 :: [Int]
c5 = [0,0,1,0,1,
      0,0,0,0,0,
      0,1,0,1,0,
      1,0,0,1,0,
      1,0,0,0,1]

-- 6x6 example board
v6 :: [Int]
v6 = [0,0,0,1,0,0,
      0,0,0,0,5,0,
      0,0,1,0,0,0,
      4,0,0,0,0,0,
      0,6,5,0,0,0,
      0,0,0,0,1,4]
c6 :: [Int]
c6 = [1,0,0,1,1,1,
      1,0,0,0,0,0,
      1,0,0,0,0,0,
      0,0,0,0,0,1,
      0,0,0,0,0,1,
      1,1,1,0,0,1]

-- 9x9 example board
v9 :: [Int]
v9 = [0,0,0,5,0,1,0,3,0,
      0,9,0,3,0,2,0,0,0,
      7,0,1,0,0,0,0,0,5,
      5,0,0,4,0,0,0,8,6,
      0,0,0,0,0,0,0,0,0,
      8,0,4,0,0,0,0,0,0,
      0,1,0,0,0,0,5,4,0,
      0,0,0,0,0,0,0,0,0,
      0,7,0,9,0,5,6,0,0]
c9 :: [Int]
c9 = [1,1,0,0,1,0,0,1,1,
      0,0,0,0,0,0,0,0,0,
      0,0,1,0,0,0,1,0,0,
      0,1,1,0,0,1,0,0,1,
      1,0,0,0,0,0,0,0,1,
      1,0,0,1,0,0,1,1,0,
      0,0,1,0,0,0,1,0,0,
      0,0,0,0,0,0,0,0,0,
      1,1,0,0,1,0,0,1,1]

-- Converts an index i into an x and y coordinate (column, row)
itop :: Int -> Int -> (Int, Int)
itop n i = (calcX i, calcY i)
  where calcX i = i - n * (i `div` n)
        calcY i = i `div` n

-- Takes an x and y coordinate and converts it into an index
ptoi :: Int -> (Int, Int) -> Int
ptoi n (x, y) = x + y * n

-- Retrieves the vertical column of values from the board (s) of size (n) at the index (p)
columnAt :: Int -> Int -> [Int] -> [Int]
columnAt n p values = helperColumnAt (itop n p) values
  where helperColumnAt (x, _) values = map (\y -> values !! ptoi n (x, y)) [0..(n - 1)]

-- Retrieves the horizontal row of values from the board (s) of size (n) at the index (p)
rowAt :: Int -> Int -> [Int] -> [Int]
rowAt n p values = helperRowAt (itop n p) values
  where helperRowAt (_, y) values = map (\x -> values !! ptoi n (x, y)) [0..(n - 1)]

-- Retrieves the previous values of element at position (p) until finding a black cell 
-- or the end of the board with value vector (v) and color vector (c)
getPrev :: Int -> [Int] -> [Int] -> [Int]
getPrev p v c | p == (-1)   = []
              | c !! p == 1 = []
              | otherwise   = v !! p : getPrev (p - 1) v c

-- Retrieves the following values of element at position (p) until finding a black cell 
-- or the end of the board with value vector (v) and color vector (c)
getNext :: Int -> Int -> [Int] -> [Int] -> [Int]
getNext p n v c | p == n      = []
                | c !! p == 1 = []
                | otherwise   = v !! p : getNext (p + 1) n v c

-- Removes all the zeros from a list
removeZeros :: [Int] -> [Int]
removeZeros []     = []
removeZeros (x:xs) | x == 0    = removeZeros xs
                   | otherwise = x : removeZeros xs

-- Retrieves the horizontal write strip from the value vector (v) using the color vector (c)
-- at position (p) where rOrC is 0 when finding a row strip and 1 when finding a column strip
getRowStripAt :: Int -> [Int] -> [Int] -> Int -> [Int]
getRowStripAt p values colors rOrC | (length removedZeros) == 0 = [0]
                                   | otherwise                  = length withZeros : removedZeros
  where withZeros    = (getPrev (i - 1) rowValues rowColors ++
                        [rowValues !! i] ++
                        getNext (i + 1) n rowValues rowColors)
        removedZeros = removeZeros withZeros
        n            = isqrt (length values)
        (x, y)       = itop n p
        i            | (rOrC == 0) = x
                     | (rOrC == 1) = y
        rowValues    | (rOrC == 0) = rowAt n p values
                     | (rOrC == 1) = columnAt n p values
        rowColors    | (rOrC == 0) = rowAt n p colors
                     | (rOrC == 1) = columnAt n p colors

-- Uses the formula max - N + 1 to get the lower bound of possibilities of 
-- strip (strip) with maximum value (max) and strip size (n)
getMinSeq :: [Int] -> Int -> Int -> Int
getMinSeq strip max n | (max - n) + 1 < 1 = 1
                      | otherwise         = (max - n) + 1

-- Uses the formula min + N - 1 to get the upper bound of possibilities of  strip (strip) 
-- with minimum value (n) and strip size (n) having all the possibilities length (allPossLen)
getMaxSeq :: [Int] -> Int -> Int -> Int -> Int
getMaxSeq strip min n allPossLen | (min + n) - 1 > allPossLen = allPossLen
                                 | otherwise                  = (min + n) - 1

-- Retrieves the possibilities of a white strip (strip) with a vector size (allPossLen)
-- and the strip length (sLen)
getStripPoss :: [Int] -> Int -> Int -> [Int]
getStripPoss strip allPossLen sLen | (length strip == 0) = [1..allPossLen] 
                                   | otherwise           = [minSeq..maxSeq]
  where max    = maximum strip
        min    = minimum strip
        minSeq = getMinSeq strip max sLen
        maxSeq = getMaxSeq strip min sLen allPossLen

-- Retrieves the sequence of invalid possibilities considering a white strip, using the size
-- of the board (allPossLen) position (p) values vector (values) colors vector (colors) and
-- analyzing a row when rOrC is 0 and column when rOrC is 1
getSeqInPoss :: Int -> Int -> [Int] -> [Int] -> Int -> [Int]
getSeqInPoss allPossLen p values colors rOrC = [1..allPossLen] `setDifference` sequence
  where rowSeqAt    = getRowStripAt p values colors rOrC
        preSequence = getStripPoss (tail rowSeqAt) allPossLen (head rowSeqAt)
        sequence    | (head preSequence == 0)   = []
                    | otherwise                 = preSequence

-- Takes the square root of a number and returns it as an int
isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

-- Removes the elements in the second list from the first list
setDifference :: [Int] -> [Int] -> [Int]
setDifference [] _      = []
setDifference xs []     = xs
setDifference xs (y:ys) = setDifference (setDifferenceAll y xs) ys

-- Remove all occurences of a value in a list
setDifferenceAll :: Int -> [Int] -> [Int]
setDifferenceAll _ []     = []
setDifferenceAll y (x:xs) | x == y    = setDifferenceAll y xs
                          | otherwise = x : setDifferenceAll y xs

-- The list of solutions at the index (p) of value vector (values) and color vector (colors)
solutionsAt :: Int -> [Int] -> [Int] -> [Int]
solutionsAt p values colors | p > length values  = []
                            | (values !! p) == 0 = [1..n] `setDifference` (columnAt n p values ++ 
                                                                           rowAt n p values ++
                                                                           getSeqInPoss n p values colors 0 ++
                                                                           getSeqInPoss n p values colors 1)
                            | otherwise          = [values !! p]
  where n = isqrt (length values)

-- Generates a new version of board (values) with value x inserted at index p
tryWith :: Int -> [Int] -> Int -> [Int]
tryWith p values x = take p values ++ [x] ++ drop (p + 1) values

-- Find the next blank value starting from index p on vector values (values), 
-- vector color (colors) and where n is the size of the board 
nextBlank :: Int -> Int -> [Int] -> [Int] -> Int
nextBlank n p values colors | p == n                     = n
                            | (cAux == 0) && (vAux == 0) = p + 1
                            | otherwise                  = nextBlank n (p + 1) values colors
  where vAux = values !! (p + 1)
        cAux = colors !! (p + 1)

-- Recursively tries the board given in values, starting at p, using colors vector (colors) 
-- and the size of the board (n) with the set of possible solution at that point
solve :: Int -> Int -> [Int] -> [Int] -> [Int] -> [Int]
solve n p values colors x  | (p == n) && null x        = values
                           | (p == n) && null (tail x) = tryWith n values (head x)
                           | (p == n)                  = []
                           | null x                    = []
                           | otherwise                 = case () of
                                                            () | null solvedNext -> solve n p values colors (tail x)
                                                               | otherwise       -> solvedNext
  where blankCell          = nextBlank n p values colors
        solvedNext         = solveNext p newTry
        newTry             = tryWith p values (head x)
        solveNext p values = solve n blankCell values colors (solutionsAt blankCell values colors)

-- Intersperse the element (c) through-out the string (xs)
joinWith :: a -> [a] -> [a]
joinWith _ (x:[]) = [x]
joinWith c (x:xs) = x : c : joinWith c xs

-- Prints the board (b) as a spaced out n x n square
pPrint :: [Int] -> Int -> [Char]
pPrint [] _ = []
pPrint b  n = spaceOut b ++ (pPrint (drop n b) n)
  where showS b    = concatMap show b
        space      = ' '
        newline    = "\n"
        spaceOut b = joinWith space (take n (showS b) ++ newline)

-- Retrieves the solution of the board
getSolution :: [Int] -> [Int] -> [Int]
getSolution values colors = solve n firstBlankCell values colors (solutionsAt firstBlankCell values colors)
  where firstBlankCell = nextBlank n (-1) values colors
        n              = (length values) - 1

-- Solves the board and prints it
solveIt :: [Int] -> [Int] -> IO ()
solveIt values colors = putStrLn (pPrint solution n)
  where solution = getSolution values colors
        n        = isqrt (length values)