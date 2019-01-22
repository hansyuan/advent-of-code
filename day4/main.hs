import Debug.Trace
import Data.List

-----------------------------------------------------------------------------------------

f = "input"
fs = "small_input"

-- | Parse the file. Sort the entries. 

main :: IO ()
main = do
  contents <- readFile f
  let guardEvents = sort $ map (split []) $ map (replaceUpTo []) $ lines contents 
  if (checkRule guardEvents "") == True
    then writeFile "./orderedEvents" $ showGuardEvents guardEvents
    else writeFile "./orderedEvents" "Error."
  print $ "(Time Asleep, Guard ID): " ++ show (iterateGuards [] guardEvents)


-----------------------------------------------------------------------------------------

-- | Part 4: Determine which minute guard 727 slept the most.

-- | fold:  deal with only guard 727's events, 
-- | fold:    enumerate the minutes the guard was asleep as a list of minutes
-- | fold:    get the mode of the minutes of the list 

-----------------------------------------------------------------------------------------

-- | Part 3: Determine which guard slept the most. 
-- List of (Minutes Slept: Guard ID) -> [(Int, Int)]

iterateGuards :: [(Int, Int)] -> [([Int], String)] -> (Int, Int)
iterateGuards everyoneAsleep [] = head $ reverse $ sort everyoneAsleep
iterateGuards everyoneAsleep events = 
  let (guardID, minutesAsleep, futureEvents) = countAsleep events in 
    iterateGuards (update [] everyoneAsleep guardID minutesAsleep) futureEvents 

-- | Update the Minutes a Guard has been asleep for.
-- Really, I could have just written a map function incrementing only the matched IDs
update :: [(Int, Int)] -> [(Int, Int)] -> Int -> Int -> [(Int, Int)] 
update checkedTimes [] guardID minutesAsleep = checkedTimes ++ [(minutesAsleep, guardID)]
update checkedTimes times guardID minutesAsleep = 
  let (currMinutes, currID) = head times in
    if guardID == currID
      then checkedTimes ++ [(minutesAsleep + currMinutes, guardID)] ++ tail times
      else update (checkedTimes ++ [head times]) (tail times) guardID minutesAsleep

-- | Read the first event which is guaranteed to be guard shift change, and then check for asleep times.
countAsleep :: [([Int], String)] -> (Int, Int, [([Int], String)])
countAsleep events = 
  let guardID = readID $ snd $ head events in 
    let (minutesAsleep, futureEvents) = countHelper 0 $ tail events in 
      (guardID, minutesAsleep, futureEvents)

-- | Read through the list and accumulate the minutes the guard is asleep. 
-- | Stop when empty or another guard comes. 
countHelper :: Int -> [([Int], String)] -> (Int, [([Int], String)])
countHelper minutes [] = (minutes, [])
countHelper minutes events = 
  let (startTime, event) = head events in 
    if 'G' `elem` event 
      then (minutes, events)
      else let (endTime, _) = head $ tail events in 
        countHelper (minutes + ((sum endTime) - (sum startTime))) (tail $ tail events) 

-- | Remove all non-numbers in a string and read it as an int.
readID :: String -> Int 
readID str = 
  let s = map (\char -> if char `elem` "0123456789" then char else ' ') str in 
    read s :: Int


-----------------------------------------------------------------------------------------

-- | Write to file a more nicely formatted guardEvents and also practice lambdas

showGuardEvents :: [([Int], String)] -> String 
showGuardEvents events = foldl newlines "" events 

newlines :: String -> ([Int], String) -> String
newlines = (\ events event -> events ++ (show event) ++ "\n")

-----------------------------------------------------------------------------------------

-- | Part 2
-- | Check: Is every `fall asleep` followed by a `wake up` before a new guard goes on shift?

-- | Sequence of guards: this method should only know iterating through guards. 
-- This logic doesn't care whether the guard is awake.

checkRule :: [([Int], String)] -> String -> Bool
checkRule [] lastEvent = True
checkRule events lastEvent = 
  -- let (time, event) = trace (show $ snd $ head events) (head events) in 
  let (time, event) = head events in 
    if ('G' `elem` event) && (lastEvent == "" || lastEvent == "wakes up" || 'G' `elem` lastEvent)
      then checkRule (tail events) event 

    else if event == "falls asleep" && (lastEvent == "wakes up" || 'G' `elem` lastEvent)
      then checkRule (tail events) event 

    else if event == "wakes up" && (lastEvent == "falls asleep")
      then checkRule (tail events) event 
    
    else False 

-- | Data structure: a list of guards and his asleep times.
-- | [(Int, [Int])] 

-----------------------------------------------------------------------------------------

-- | Part 1

-- | Replace the delimiters for the timestamp only.

replaceUpTo :: String -> String -> String
replaceUpTo sofar original =
  if head original == ']'
    then sofar ++ original
    else replaceUpTo (sofar ++ [(replace (head original))] ) (tail original) 


-- | Turn the first part of the message into an int list.

replace :: Char -> Char
replace c = 
  if c `elem` ['-', ' ', ':']
    then ','
    else c


-- | Read characters until hit a delimiter, return an int and drop the delimiter

split :: String -> String -> ([Int], String)
split soFar [] = (read soFar :: [Int], [])
split soFar str = 
  if head str == ']'
    then (read (soFar ++ [']']) :: [Int], (tail $ tail str))
    else split (soFar ++ [head str]) (tail str)

