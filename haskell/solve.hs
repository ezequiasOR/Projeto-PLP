module Solve (
    possible,
    solve
) where

updateMatrix :: [[Int]] -> Int -> (Int, Int) -> [[Int]]
updateMatrix b e (r,c) =
    take r b ++
    [take c (b !! r) ++ [e] ++ drop (c + 1) (b !! r)] ++
    drop (r + 1) b

checkRow :: [[Int]] -> Int -> Int -> Bool
checkRow board r n = n `notElem` (board!!r)

checkCol :: [[Int]] -> Int -> Int -> Int -> Bool
checkCol board 9 _ _ = True
checkCol board r x n | (row!!x) == n = False
                     | otherwise     = (checkCol board (r+1) x n)
                     where row = (board!!r)

checkSquare :: [[Int]] -> Int -> Int -> Int -> Bool
checkSquare fb n x y
    | ((fb !! y) !! x)     == n     = False
    | ((fb !! y) !! (x+1)) == n     = False
    | ((fb !! y) !! (x+2)) == n     = False
    | ((fb !! (y+1)) !! x) == n     = False
    | ((fb !! (y+1)) !! (x+1)) == n = False
    | ((fb !! (y+1)) !! (x+2)) == n = False
    | ((fb !! (y+2)) !! x) == n     = False
    | ((fb !! (y+2)) !! (x+1)) == n = False
    | ((fb !! (y+2)) !! (x+2)) == n = False
    | otherwise                     = True

possible :: [[Int]] -> Int -> Int -> Int -> Bool
possible fb y x n
    | (checkRow fb y n == False) || (checkCol fb 0 x n == False) || (checkSquare fb n x0 y0 == False) = False
    | otherwise                                                                                       = True
    where x0 = ((x `quot` 3)*3)
          y0 = ((y `quot` 3)*3)

setCell :: [[Int]] -> Int -> Int -> Int -> [[Int]]
setCell fb y x 10 = fb
setCell fb y x n
    | possible fb y x n == True = (setCell (updateMatrix (solve (updateMatrix fb n (y, x)) 0) 0 (y, x)) y x (n+1))
    | otherwise                 = setCell fb y x (n+1)
-- (setCell (updateMatrix (solve (updateMatrix fb n (y, x)) 0) 0 (y, x)) y x (n+1))
solveRow :: [[Int]] -> Int -> Int -> [[Int]]
solveRow fb y 9 = fb
solveRow fb y x
    | (row!!x) == 0 = (solveRow (setCell fb y x 1) y (x+1))
    | otherwise         = solveRow fb y (x+1)
    where row = (fb!!y)

solve :: [[Int]] -> Int -> [[Int]]
solve fb 9 = fb
solve fb y = (solve (solveRow fb y 0) (y+1))