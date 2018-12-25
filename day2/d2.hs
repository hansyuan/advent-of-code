import System.IO
import Data.List

dups :: Int -> Int -> Char -> String -> Int

dups count threshold char ""  = 
    if count == threshold - 1 then 1
    else 0

dups count threshold char str  = 
    if count == threshold - 1 && head str /= char then 1
    else if head str == char then dups (count + 1) threshold (head str) (tail str)
    else dups 0 threshold (head str) (tail str) 

distance :: String -> String -> Int -> Int 
distance "" str count = count
distance str "" count = count 
distance str1 str2 count = 
    if head str1 /= head str2
        then distance (tail str1) (tail str2) (count + 1)
        else distance (tail str1) (tail str2) count


measure :: [String] -> [String] -> IO()
measure d1 [] = measure (tail d1) (tail d1)
measure [] d2 = print "None found"
measure d1 d2 = 
    if 1 == distance (head d1) (head d2) 0
        then do
            print (head d1) 
            print (head d2)
        else measure d1 (tail d2)


main :: IO()
main = do 
    -- Get list of strings 
    contents <- readFile "input.txt"

    -- Part 1 Check for doubles and triples 
    let x = map sort $ lines contents in 
        let doubles = sum $ map (dups 0 2 '\0') x in 
            let triples = sum $ map (dups 0 3 '\0') x in 
                print $ doubles * triples

    -- Part 2 
    let ids = sort $ lines contents in 
        measure ids ids
        
