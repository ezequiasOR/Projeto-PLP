import MakeBoard

split :: Eq a => a -> [a] -> [[a]]
split d [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s

firstOption :: IO()
firstOption = do
    list <- getLine
    let l = split ',' list
    print l
    print "chamar metodo para:"
    print "mostrar o tabuleiro completo se for um jogo valido"
    print "ou se existe mais de uma solucao"

readCells cells = do cell <- readLn
                     if cell == "." then return (reverse cells)
                     else readCells (cell:cells)

secondOption :: IO()
secondOption = do
    list <- readCells []
    print list

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
getColumn 'A' = 0
getColumn 'B' = 1
getColumn 'C' = 2
getColumn 'D' = 3
getColumn 'E' = 4
getColumn 'F' = 5
getColumn 'G' = 6
getColumn 'H' = 7
getColumn 'I' = 8

getRow :: Char -> Int
getRow '1' = 0
getRow '2' = 1
getRow '3' = 2
getRow '4' = 3
getRow '5' = 4
getRow '6' = 5
getRow '7' = 6
getRow '8' = 7
getRow '9' = 8

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

solucaoOption :: IO()
solucaoOption = do
    print "Como voce deseja inserir o tabuleiro?"
    print "1 - Uma lista (Ex. 'A 2 4,B 3 7,B 4 2')"
    print "2 - Um cedula por vez (Ex. A 2 4 - coluna; linha; numero)"
    option <- getLine

    if option == "1" then firstOption
    else if option =="2" then secondOption
         else solucaoOption

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

    if option == "1" then solucaoOption
    else if option == "2" then jogarOption completeBoard
    else if option == "3" then print "Fim de Jogo"
    else main