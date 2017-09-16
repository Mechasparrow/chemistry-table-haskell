{-# LANGUAGE DeriveGeneric #-}

module Chemistry (
  Element (..),
  getElements,
  getElement,
  getAtomicNumber,
  getRegularAtomicNumber
) where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)

import Reader

import System.IO

data Element = Element {
  name :: String,
  atomic_number :: Int
} deriving (Show, Generic)

instance FromJSON Element
instance ToJSON Element

getElements :: IO [Element]
getElements = do
  d <- (eitherDecode <$> readJSON("chemistry.json")) :: IO (Either String [Element])

  case d of
    Left err -> error "did not work"
    Right ps -> return ps

getElement :: Int -> IO Element
getElement atomic_number = do
  list <- (getElements)
  let new_items = [x | x <- list, getRegularAtomicNumber(x) == atomic_number]
  return (new_items !! 0)

getRegularAtomicNumber :: Element -> Int
getRegularAtomicNumber element = atomic_number where Element {name = _, atomic_number = atomic_number} = element
