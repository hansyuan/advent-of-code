import Debug.Trace

f1 = "input"
f2 = "small_input"

-- | Parse the file. Sort the entries. 
main :: IO ()
main = do
  contents <- readFile f1
  print $ map (split []) $ map (replaceUpTo []) $ lines contents


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

