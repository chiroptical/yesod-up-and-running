{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Data.Person where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics (Generic)

data Person = Person
    { id :: Int
    , name :: Text
    , age :: Int
    , address :: Text
    }
    deriving (Show, Generic, ToJSON, FromJSON)
