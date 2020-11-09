
module BoardElemModification(
    removeNumber,
    insertNewNumber
) where

modifyNumber :: [[Int]] -> Int -> (Int, Int) -> [[Int]]
modifyNumber matrix x (row,column) =
  take row matrix ++
  [take column (matrix !! row) ++ [x] ++ drop (column + 1) (matrix !! row)] ++
  drop (row + 1) matrix

removeNumber :: [[Int]] -> (Int, Int) -> [[Int]]
removeNumber matrix (row,column) = modifyNumber matrix 0 (row,column)

insertNewNumber :: [[Int]] -> Int -> (Int, Int) -> [[Int]]
insertNewNumber matrix x (row,column) = modifyNumber matrix x (row,column)