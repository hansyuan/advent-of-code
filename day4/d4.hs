import Debug.Trace

f1 = "input"
f2 = "small_input"

main = do
  contents <- readFile f2
  print $ lines $ map replace_char contents

-- | TODO [1518-05-30 00:27] wakes up

replace_char :: Char -> Char
replace_char c
  | c == '-' = ' '
  | c == ':' = ' '
  | otherwise = c
