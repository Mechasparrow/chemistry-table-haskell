{-# LANGUAGE DeriveGeneric #-}

module Chemistry (
  Element (..),
  getElements,
  getElement,
  getAtomicNumber
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

getElement atomic_number = do
  list <- (getElements)
  let item = (list !! atomic_number)
  return (item)

getAtomicNumber :: IO Element -> IO Int
getAtomicNumber element = do
  Element {name = _, atomic_number = atomic_number} <- element
  return atomic_number
