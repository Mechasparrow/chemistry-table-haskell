module Reader (
  viewFile
) where

import System.Directory
import System.IO

showCurrentDir :: IO FilePath
showCurrentDir = getCurrentDirectory

viewFile :: String -> IO ()
viewFile file_name = do
  current_dir <- showCurrentDir
  handle <- openFile (current_dir ++ "/data/" ++ file_name) ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle
