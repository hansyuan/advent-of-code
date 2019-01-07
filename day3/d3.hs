import Data.Typeable
import Data.List
import Text.Printf
import Debug.Trace
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
        -- print $ count (sort $ concat $ map coordinates listOfConfigs) [] 0
        (print (iter [] (head listOfConfigs) (tail listOfConfigs)))




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
  let [i, left, top, width, height] = configs in
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


-- | Iterate through the list of configs comparing the current configs
-- with every other config.

iter seenList currConf [] =
  if iterHelper currConf seenList
    then currConf
    else [-1]

iter seenList currConf futureList =
  if iterHelper currConf (seenList ++ futureList)
    then currConf
    else iter (seenList ++ [currConf]) (head futureList) (tail futureList)

-- If there's overlap just return False. If no overlap keeping looking.
iterHelper currConf [] = True
iterHelper currConf compareList =
  if overlap currConf (head compareList)
    then False
    else iterHelper currConf (tail compareList)

-- | Define a comparator between two sets of configs to determine
-- whether they will overlap.

overlap conf1 conf2 =
  -- let [configs1, configs2] = trace ("Overlap comparing " ++ show conf1 ++ show conf2)  map coordinates [conf1, conf2] in
  --   if (length $ nub (configs1 ++ configs2)) == (length $ nub configs1) + (length $ nub configs2)
  --     then False
  --     else True

  -- Check if one dimension overlaps, if so, check if the other overlaps.
  let ([_, l1, t1, w1, h1], [_, l2, t2, w2, h2]) =  (conf1, conf2) in
    if (l1 + w1) < l2 || (l2 + w2) < l1
      then False
      else if (t1 + h1) < t2 || (t2 + h2) < t1
        then False
        else True


-- -- The length of first and rest should equal the their sets combined
-- noOverlap c =
--   let configs = sort $ map coordinates c
--     in checkNoOverlap [] configs 1
--     -- in  configs
--
-- -- checkNoOverlap [ = [-1]
-- checkNoOverlap preconfigs _ 1400 = -1
-- checkNoOverlap preconfigs (x:xs) count =
--   let l2 = length $ nub $ concat (preconfigs++xs) in
--     let l1 = length $ nub $ x in
--       let lTotal = length $ nub $ concat (preconfigs++(x:xs)) in
--         if lTotal == l1 + l2 then count
--           else checkNoOverlap (preconfigs++[x]) xs (count+1)
