module Main where

import Chemistry
import Reader

main :: IO ()
main = do
  loop


loop :: IO ()
loop = do

  putStrLn "Input an atomic number to find the element associated with it."
  raw_atomic_number <- getLine

  let atomic_number = read raw_atomic_number :: Int
  our_elem <- getElement(atomic_number)
  displayElement(return our_elem)
  putStrLn ("")

  if raw_atomic_number == "EXIT"
    then return ()
    else loop
