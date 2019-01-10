import Debug.Trace

f1 = "input"
f2 = "small_input"

main :: IO ()
main = do
  contents <- readFile f2
  print $ lines contents

-- | TODO [1518-05-30 00:27] wakes up
-- Read characters until the closing square bracker ']', and then 
-- read the rest of the message: 

-- Read [1518-05-30 00:27] as a 5-tuple of ints. Can probably use fold here. 
datetime :: [Char] -> (Int, Int, Int, Int, Int)
datetime str = 

-- | Read characters until hit a delimiter, return an int and drop the delimiter
dtHelper :: [Char] -> (Int, [Char])
dtHelper [] = []
dtHelper  =

-- TODO may not want this
event :: String -> (Int, String)
