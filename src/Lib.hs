module Lib
    ( someFunc
    ) where

import Reader

someFunc :: IO ()
someFunc = do
  content <- viewFile "hello.txt"
  putStrLn content
