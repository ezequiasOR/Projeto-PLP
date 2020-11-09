module MakeBoard
(
    getBoard
    randomList
) where

import System.Random (randomRIO)

randomList :: Int -> Int -> Int -> IO([Int])
randomList s e 0 = return []
randomList s e n = do
  r  <- randomRIO (s,e)
  rs <- randomList s e (n-1)
  if not (r `elem` rs) then return (r:rs)
  else randomList s e n

pattern :: Int -> Int -> Int
pattern r c = (3*(r`mod`3)+r `quot` 3+c)`mod`9

sumIn :: Int -> [Int] -> [Int]
sumIn 0 l = l
sumIn n [] = []
sumIn n l = (n*3)+(head l) : (sumIn n (tail l))

build :: [Int] -> [Int] -> [Int]
build [] ys = []
build xs [] = xs
build (x:xs) ys = (sumIn x ys) ++ (build xs ys)

makeBoard :: [Int] -> [Int] -> [Int] -> [[Int]]
makeBoard [] cs ns = []
makeBoard rs [] ns = [rs]
makeBoard (r:rs) (c:cs) ns = [getPattern r (c:cs) ns] ++ makeBoard rs (c:cs) ns

getPattern :: Int -> [Int] -> [Int] -> [Int]
getPattern r [] ns = []
getPattern r (c:cs) ns = (ns!!(pattern r c)) : getPattern r cs ns

getNum :: Int -> Int -> [Int] -> Int
getNum r c ns = ns!!(pattern r c)

getSample = do
    l <- randomList 0 2 3
    return l

getNums = do
    l <- randomList 1 9 9
    return l

getBoard = do
    list1 <- getSample
    list2 <- getSample
    let rows = (build list1 list2)

    list1 <- getSample
    list2 <- getSample
    let columns = (build list1 list2)

    nums <- getNums
    let board = makeBoard rows columns nums
    return board

























