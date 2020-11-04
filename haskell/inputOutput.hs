import MakeBoard

split :: Eq a => a -> [a] -> [[a]]
split d [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s

firstOption :: IO()
firstOption = do
    list <- getLine
    let l = split ',' (read list)
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

getTip :: IO()
getTip = do
    print "dica"

checkWin :: IO()
checkWin = do
    print "verificar se ganhou"

checkSolution :: IO()
checkSolution = do
    print "desistir e verificar solucao"

solucaoOption :: IO()
solucaoOption = do
    print "Como voce deseja inserir o tabuleiro?"
    print "1 - Uma lista (Ex. 'A 2 4,B 3 7,B 4 2')"
    print "2 - Um cedula por vez (Ex. A 2 4 - coluna; linha; numero)"
    option <- getLine

    if option == "1" then firstOption
    else if option =="2" then secondOption
         else solucaoOption

options :: Int -> IO()
options 1 = insertNumber
options 2 = removeNumber
options 3 = checkTable
options 4 = getTip
options 5 = checkWin
options 6 = checkSolution
options n = jogarOption

menuOptions :: IO()
menuOptions = do
    print "1 - Inserir um numero"
    print "2 - Remover um numero"
    print "3 - Fazer um check (verificar contradicao)"
    print "4 - Pedir uma dica de uma celula especifica"
    print "5 - Verificar se ganhou"
    print "6 - Desistir e verificar solucao"

jogarOption :: IO()
jogarOption = do
    board <- (MakeBoard.getBoard)
    menuOptions
    option <- getLine
    options (read option)

main :: IO()
main = do
    print "1 - Solucao"
    print "2 - Jogar"
    option <- getLine

    if option == "1" then solucaoOption
    else if option == "2" then jogarOption
    else main