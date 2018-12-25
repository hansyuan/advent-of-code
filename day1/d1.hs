import Data.Typeable 
import System.IO

-- Haskell lesson 1: You can't bring impurity into purity. 
    
    -- But you can bring purity into impurity, so do functions within the IO.


main = do 
    contents <- readFile "input.txt" 

    let 
        repl '\n' = ','; 
        repl '+' = ' '
        repl c = c in
        let strListInts =  map repl $ "[" ++ (init contents) ++ "]" in do
            print strListInts 
            print $ (read :: String -> [Int]) strListInts 

