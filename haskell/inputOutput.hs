import MakeBoard

cols = ['A','B','C','D','E','F','G','H','I']

split :: Eq a => a -> [a] -> [[a]]
split d [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s

getIndex :: [Char] -> Char -> Int
getIndex [] c = -1
getIndex (c:cs) a | a == c = 0
                  | otherwise = 1+(getIndex cs a)

updateMatrix :: [[Int]] -> Int -> (Int, Int) -> [[Int]]
updateMatrix b e (r,c) =
    take r b ++
    [take c (b !! r) ++ [e] ++ drop (c + 1) (b !! r)] ++
    drop (r + 1) b

fillBoard :: [[Int]] -> [String] -> [[Int]]
fillBoard b [] = b
fillBoard b (h:t) = fillBoard board t
    where board = updateMatrix b (read([(h!!4)])) ((getRow (h !! 2)), (getColumn (h !! 0)))

checkRow :: [[Int]] -> Int -> Int -> Bool
checkRow board r n = n `notElem` (board!!r)

checkAllRows :: [[Int]] -> Int -> Int -> Bool
checkAllRows fb 9 n = True
checkAllRows fb x n = if (checkRow fb x n) == False then False
                      else checkRow fb (x+1) n

checkCol :: [[Int]] -> Int -> Int -> Int -> Bool
checkCol board 9 _ _ = True
checkCol board r y n | (row!!y) == n = False
                     | otherwise     = (checkCol board (r+1) y n)
                     where row = (board!!r)

checkAllCols :: [[Int]] -> Int -> Int -> Bool
checkAllCols fb 9 n = True
checkAllCols fb y n = if (checkCol fb 0 y n) == False then False
                      else checkCol fb 0 (y+1) n

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

check :: [[Int]] -> Int -> Int -> Int -> Bool
check fb n x y
    | (y < 3) && (x < 3) = checkSquare fb n 0 0
    | (y < 3) && (x < 6) = checkSquare fb n 0 3
    | (y < 3) && (x < 9) = checkSquare fb n 0 6
    | (y < 6) && (x < 3) = checkSquare fb n 3 0
    | (y < 6) && (x < 6) = checkSquare fb n 3 3
    | (y < 6) && (x < 6) = checkSquare fb n 3 6
    | (y < 9) && (x < 3) = checkSquare fb n 6 0
    | (y < 9) && (x < 6) = checkSquare fb n 6 3
    | otherwise          = checkSquare fb n 6 6

possible :: [[Int]] -> Int -> Int -> Int -> Bool
possible fb y x n
    | checkAllRows fb 0 n == False = False
    | checkAllCols fb 0 n == False = False
    | check fb n x0 y0 == False    = False
    | otherwise                    = True
    where x0 = (x `div` 3)*3
          y0 = (y `div` 3)*3

setCell :: [[Int]] -> Int -> Int -> Int -> [[Int]]
setCell fb y x 10 = fb
setCell fb y x n
    | possible fb y x n == True = (setCell (updateMatrix (solve (updateMatrix fb n (y, x)) 0) 0 (y, x)) y x (n+1))
    | otherwise                 = setCell fb y x (n+1)

solveRow :: [[Int]] -> Int -> Int -> [[Int]]
solveRow fb y 9 = fb
solveRow fb y x
    | (row!!x) == 0 = (solveRow (setCell fb y x 1) y (x+1))
    | otherwise         = solveRow fb y (x+1)
    where row = (fb!!y)

solve :: [[Int]] -> Int -> [[Int]]
solve fb 9 = fb
solve fb y = (solve (solveRow fb 0 y) (y+1))

firstOption :: [[Int]] -> IO()
firstOption b = do
    list <- getLine
    let l = split ',' list
    let fb = fillBoard b l
    print (solve fb 0)
    main

readCells cells = do cell <- readLn
                     if cell == "." then return (reverse cells)
                     else readCells (cell:cells)

secondOption :: [[Int]] -> IO()
secondOption b = do
    list <- readCells []
    let fb = fillBoard b list
    print fb
    main

insertNumber :: IO()
insertNumber = do
    line <- getLine
    print line
    print "chamar metodo para inserir numero"

removeNumber :: IO()
removeNumber = do
    line <- getLine
    print line
    print "chamar metodo para remover numero"

checkTable :: IO()
checkTable = do
    print "chamar metodo para checar o tabuleiro"

getColumn :: Char -> Int
getColumn c = getIndex cols c

getRow :: Char -> Int
getRow c = read([c]) -1

getTip :: [[Int]] -> IO()
getTip completeBoard = do
    print "Informe a coluna e a linha (Ex. 'A 2'):"
    line <- getLine
    let c = (getColumn (line !! 0))
    let r = (getRow (line !! 2))
    let row = (completeBoard !! r)
    let number = (row !! c)
    print $ "O numero da coluna " ++ show (line !! 0) ++ " e linha " ++ show (line !! 2) ++ " = " ++ show number
    jogarOption completeBoard

checkWin :: IO()
checkWin = do
    print "verificar se ganhou"

checkSolution :: [[Int]] -> IO()
checkSolution completeBoard = do
    print completeBoard
    main

solucaoOption :: [[Int]] -> IO()
solucaoOption b = do
    print "Como voce deseja inserir o tabuleiro?"
    print "1 - Uma lista (Ex. 'A 2 4,B 3 7,B 4 2')"
    print "2 - Um cedula por vez (Ex. A 2 4 - coluna; linha; numero)"
    option <- getLine

    if option == "1" then firstOption b
    else if option =="2" then secondOption b
         else solucaoOption b

options :: [[Int]] -> Int -> IO()
options completeBoard 1 = insertNumber
options completeBoard 2 = removeNumber
options completeBoard 3 = checkTable
options completeBoard 4 = getTip completeBoard
options completeBoard 5 = checkWin
options completeBoard 6 = checkSolution completeBoard
options completeBoard n = jogarOption completeBoard

menuOptions :: IO()
menuOptions = do
    print "1 - Inserir um numero"
    print "2 - Remover um numero"
    print "3 - Fazer um check (verificar contradicao)"
    print "4 - Pedir uma dica de uma celula especifica"
    print "5 - Verificar se ganhou"
    print "6 - Desistir e verificar solucao"

jogarOption :: [[Int]] -> IO()
jogarOption completeBoard = do
    menuOptions
    option <- getLine
    options completeBoard (read option)

main :: IO()
main = do
    print "1 - Solucao"
    print "2 - Jogar"
    print "3 - Parar de jogar"
    option <- getLine
    completeBoard <- (MakeBoard.getBoard)
    let board = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0]]

    if option == "1" then solucaoOption board
    else if option == "2" then jogarOption completeBoard
    else if option == "3" then print "Fim de Jogo"
    else main