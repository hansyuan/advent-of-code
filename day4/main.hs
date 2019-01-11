import Debug.Trace
import Data.List

f = "input"
fs = "small_input"

-- | Parse the file. Sort the entries. 
main :: IO ()
main = do
  contents <- readFile f
  let answer = show $ sort $ map (split []) $ map (replaceUpTo []) $ lines contents in
    writeFile "./output" answer 


-- | Part 2
-- | Is every `fall asleep` followed by a `wake up` before a new guard goes on shift?

-- | Data structure: a list of guards and his asleep times.
-- | [(Int, [Int])] 

-----------------------------------------------------------------------------------------

-- | Part 1

-- | Replace the delimiters for the timestamp only.
replaceUpTo :: String -> String -> String
replaceUpTo sofar original =
    if head original == ']'
        then sofar ++ original
        else replaceUpTo (sofar ++ [(replace (head original))] )  (tail original) 


-- | Turn the first part of the message into an int list.
replace :: Char -> Char
replace c = 
    if c `elem` ['-', ' ', ':']
        then ','
        else c


-- | Read characters until hit a delimiter, return an int and drop the delimiter
split :: String -> String -> ([Int], String)
split  soFar []  = (read soFar :: [Int], [])
split  soFar str = 
    if head str == ']'
        then (read (soFar ++ [']']) :: [Int], (tail $ tail str))
        else split (soFar ++ [head str]) (tail str)

