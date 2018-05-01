import System.IO
import Data.Char

keepIfEqual :: Int -> Int -> Int
keepIfEqual a b
    | a == b = a
    | otherwise = 0

firstHalf :: [Int] -> [Int]
firstHalf x = take (length x `div` 2) x

secondHalf :: [Int] -> [Int]
secondHalf x = drop (length x `div` 2) x

pairs :: [Int] -> [Int]
pairs x = zipWith keepIfEqual (firstHalf x) (secondHalf x)

solve :: String -> Int
solve x = (sum $ pairs $ map digitToInt x) * 2

main = do
    withFile "input" ReadMode (\handle -> do  
        line <- hGetLine handle
        putStr $ show $ solve line)
