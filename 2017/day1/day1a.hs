import System.IO
import Data.Char

addIfEqual :: Int -> Int -> Int
addIfEqual a b
    | a == b = a
    | otherwise = 0

moveHeadToTail :: [Int] -> [Int]
moveHeadToTail (x:xs) = xs ++ [x]

pairs :: [Int] -> [Int]
pairs x = zipWith addIfEqual x (moveHeadToTail x)

solve :: String -> Int
solve x = sum $ pairs $ map digitToInt x

main = do
    withFile "input" ReadMode (\handle -> do  
        line <- hGetLine handle
        putStr $ show $ solve line)
