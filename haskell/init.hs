import MakeBoard
import Solve

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

firstOption :: [[Int]] -> IO()
firstOption b = do
    list <- getLine
    let l = split ',' list
    let fb = fillBoard b l
    print (Solve.solve fb 0)
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
