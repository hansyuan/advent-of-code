import Data.Typeable 
import System.IO

main = do 
    contents <- readFile "input.txt" 

    -- let splitNewlines = lines contents 
    -- let intList = map read splitNewlines
    let 
        repl '\n' = ','; 
        repl c = c in
        print $ map repl $ "[" ++ contents ++ "]"

    -- print $ map (read :: String -> Int) (lines contents) 

    -- print intList

    -- let 
    --     repl '\n' = ' ';
    --     repl c = c in
    --     map repl rawData

    -- putStrLn (typeOf rawData)
    -- putStrLn (map read $ words rawData :: [Int])