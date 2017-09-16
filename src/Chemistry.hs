{-# LANGUAGE DeriveGeneric #-}

module Chemistry (
  Element,
  getElement
) where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)

import Reader

data Element = Element {
  name :: String,
  atomic_number :: Int
} deriving (Show, Generic)

instance FromJSON Element
instance ToJSON Element

getElement :: IO [Element]
getElement = do
  d <- (eitherDecode <$> readJSON("chemistry.json")) :: IO (Either String [Element])

  case d of
    Left err -> error "did not work"
    Right ps -> return ps
