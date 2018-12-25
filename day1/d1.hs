-- import Data.Typeable 
import System.IO

-- Haskell lesson 1: You can't bring impurity into purity. 
    
    -- But you can bring purity into impurity, so do functions within the IO.


main = do 
    contents <- readFile "input.txt" 

    -- Naive solution

    -- let 
    --     repl '\n' = ','; 
    --     repl '+' = ' '
    --     repl c = c in
    --     let strListInts =  map repl $ "[" ++ (init contents) ++ "]" in do
    --         print strListInts 
    --         print $ sum $ (read :: String -> [Int]) strListInts 


    -- Attempt at optimizing 
    
    let 
        repl '+' = ' ' 
        repl c = c in 
        print $ sum $ map (read :: String -> Int) (lines (map repl contents)) 

