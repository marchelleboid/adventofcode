import System.IO
import Data.Char
import qualified Data.Text as T
import qualified Data.Text.Read as R

maxDifference :: String -> Int
maxDifference x = (maximum intList) - (minimum intList)
    where intList = map (\x -> read (T.unpack x) :: Int) (T.splitOn (T.pack "\t") (T.pack x))

main = do
    handle <- readFile "input"
    putStr $ show $ sum (map maxDifference (lines handle))
