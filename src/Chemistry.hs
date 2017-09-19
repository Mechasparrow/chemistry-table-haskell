{-# LANGUAGE DeriveGeneric #-}

module Chemistry (
  Element (..),
  getElements,
  getElement,
  displayElement,
  getRegularAtomicNumber
) where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)

import Reader

import System.IO

data Element = Element {
  name :: String,
  symbol :: String,
  number :: Int
} deriving (Show, Generic)

instance FromJSON Element
instance ToJSON Element

getElements :: IO [Element]
getElements = do
  d <- (eitherDecode <$> readJSON("periodic-table.json")) :: IO (Either String [Element])

  case d of
    Left err -> error "did not work"
    Right ps -> return ps

displayElement :: IO Element -> IO()
displayElement element = do

  Element {name = name, symbol = symbol, number = number} <- element
  putStrLn (name ++ " " ++ "is the element with the Atomic Number of " ++ (show (number)))

getElement :: Int -> IO Element
getElement atomic_number = do
  list <- (getElements)
  let new_items = [x | x <- list, getRegularAtomicNumber(x) == atomic_number]
  let element_exists = (toInteger $ length new_items) > 0
  if element_exists then
    return (new_items !! 0)
  else
    error "Sorry that Element does not exist!"

getRegularAtomicNumber :: Element -> Int
getRegularAtomicNumber element = number where Element {name = _, symbol = _, number = number} = element
