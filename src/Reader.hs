{-# OPTIONS_GHC -fwarn-missing-signatures #-}
module Reader (
  viewFile,
  readJSON
) where

import System.Directory
import System.IO

import qualified Data.ByteString.Lazy as B

showCurrentDir :: IO FilePath
showCurrentDir = getCurrentDirectory

forceList :: [a] -> ()
forceList [] = ()
forceList (x:xs) = forceList xs

viewFile :: FilePath -> IO String
viewFile file_name = do
  current_dir <- showCurrentDir
  handle <- openFile (current_dir ++ "/data/" ++ file_name) ReadMode
  contents <- hGetContents handle
  forceList contents `seq` hClose handle
  return contents

readJSON :: FilePath -> IO B.ByteString
readJSON jsonFile = do
  current_dir <- showCurrentDir
  B.readFile (current_dir ++ "/data/" ++ jsonFile)
