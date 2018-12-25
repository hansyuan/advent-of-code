import Data.Typeable 
import System.IO

-- Haskell lesson 1: You can't bring impurity into purity. 
    
    -- But you can bring purity into impurity, so do functions within the IO.


-- Haskell doesn't necessarily have a deep copy?
-- copyList :: [Int] -> [Int] -> [Int]
-- copyList listSoFar listToCopy =  
--     if listToCopy == []
--         then listSoFar
--         else copyList (listSoFar ++ [head listToCopy]) (tail listToCopy)

-- Go through the list infinitely until a sum is found
-- Currently Inefficient, but finds the right answer.
findRepeat :: Int -> [Int] -> [Int] -> [Int] -> Int
findRepeat sum seen deltas backup = do
    if (elem sum seen) then sum 
    else if deltas == [] then findRepeat (sum) (seen) (backup) (backup)
    else if backup == [] then -99998888
    else findRepeat (sum + head deltas) (seen ++ [sum]) (tail deltas) (backup)

main :: IO ()
main =  do
    contents <- readFile "input.txt" 

    let repl '+' = ' ' ; repl c = c in 
        let deltas = map (read :: String -> Int) $ lines (map repl contents) in 
            -- print deltas
            print $ findRepeat 0 [] ( deltas) (deltas)
