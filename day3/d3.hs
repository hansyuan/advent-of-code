import Data.Typeable
import Data.List

-- | This solution requires roughly a trillion calculations: this sucks.

-- | Read and cleanup data
-- # ID @ Left, Top: widthxheight
-- Example:  #2 @ 518,811: 15x18

-- countDups :: [(Int,Int)] -> [[Int]] -> Int -> Int
-- countDups [] configs dups = dups
-- countDups positions configs dups =
--   if positionInConfigs (head positions) configs False
--     then countDups (tail positions) configs (dups + 1)
--     else countDups (tail positions) configs dups
--
--
-- positionInConfigs :: (Int, Int) -> [[Int]] -> Bool -> Bool
-- positionInConfigs position [] seen = False
-- positionInConfigs position configs seen =
--   let [_, left, top, width, height] = head configs in
--     let (x, y) = position in
--       if left <= x && x < (left + width) && top <= y && y < (top + height)
--         then (if seen
--           then True
--           else positionInConfigs position (tail configs) True)
--         else positionInConfigs position (tail configs) seen

-- | Read the file contents
main :: IO ()
main = do
  contents <- readFile "input"
  let positions = [ (x,y) | x <- [0..999] , y <- [0..999] ] in
      let listOfConfigs = reformat contents in
        print $ count (sort $ concat $ map coordinates listOfConfigs) [] 0
        -- print $ countDups positions listOfConfigs 0



-- | This segment of code reads from file and turns the data into typed values.
reformat :: String -> [[Int]]
reformat d = map (read:: String -> [Int]) $ map wrap $ lines $ map toComma d

-- | Change all the delimiters into one common one.
toComma :: Char -> Char
toComma char
    | char == '@' || char == ':' || char == 'x' = ','
    | char == '#' = '0'
    | otherwise = char

-- | Wrap each substring into a string type list of ints
wrap :: String -> String
wrap s = "[" ++ s ++ "]"

-- Enumerate all the coordinates into a list of points.
coordinates :: [Int] -> [(Int, Int)]
coordinates configs =
  let [_, left, top, width, height] = configs in
    [
      (x, y) |
      x <- [left..(left + width - 1)] ,
      y <- [top..(top + height - 1)]
    ]

count [] [] total = total
count li [] total = count (tail li) [head li] total
count [] check total =
  if length check > 1
    then total + 1
    else total

count li check total =
  if (head li) `elem` check
    then count (tail li) (head li : check) total
    else (if length check > 1
      then count (tail li) [head li] (total+1)
      else count (tail li) [head li] total)
