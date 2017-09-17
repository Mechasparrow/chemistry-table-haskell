module PeriodicTable (
  getElements
) where

import Data.Aeson
import Data.Aeson.Types

import Reader
import System.IO

getElements :: IO (Maybe Object)
getElements = do
  table <- decode <$> readJSON("periodic-table.json")
  return (table)
