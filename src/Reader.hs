module Reader (
  viewFile
) where

import System.Directory
import System.IO

showCurrentDir :: IO FilePath
showCurrentDir = getCurrentDirectory

forceList [] = ()
forceList (x:xs) = forceList xs

viewFile :: FilePath -> IO String
viewFile file_name = do
  current_dir <- showCurrentDir
  handle <- openFile (current_dir ++ "/data/" ++ file_name) ReadMode
  contents <- hGetContents handle
  forceList contents `seq` hClose handle
  return contents
