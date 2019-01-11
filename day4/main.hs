import Debug.Trace

f1 = "input"
f2 = "small_input"

main :: IO ()
main = do
  contents <- readFile f1
  print $ map (split []) $ map (replaceUpTo []) $ lines contents

-- | TODO [1518-05-30 00:27] wakes up
-- Read characters until the closing square bracker ']', and then 
-- read the rest of the message: 

-- Read [1518-05-30 00:27] as a 5-tuple of ints. Can probably use fold here. 
-- datetime :: [Char] -> (Int, Int, Int, Int, Int)
-- datetime str = 0

-- | If ']' then exit 

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

