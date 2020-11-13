{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Data.Donor where

import Data.Aeson (FromJSON (..), ToJSON (..), object, withObject, (.:), (.=))
import Data.Text (Text)

data Donor = Donor
    { donorBloodType :: Text
    , donorContactNumber :: Text
    , donorDateOfBirth :: Text
    , donorEmergencyContactNumber :: Text
    , donorFirstName :: Text
    , donorFirstTime :: Bool
    , donorLastName :: Text
    }
    deriving (Show)

instance ToJSON Donor where
    toJSON Donor{..} =
        object
            [ "bloodGroup" .= donorBloodType
            , "contactNo" .= donorContactNumber
            , "dateOfBirth" .= donorDateOfBirth
            , "emergencyContactNo" .= donorEmergencyContactNumber
            , "firstName" .= donorFirstName
            , "firstTimeDonor" .= donorFirstTime
            , "lastName" .= donorLastName
            ]

instance FromJSON Donor where
    parseJSON = withObject "Donor" $ \obj -> do
        donorBloodType <- obj .: "bloodGroup"
        donorContactNumber <- obj .: "contactNo"
        donorDateOfBirth <- obj .: "dateOfBirth"
        donorEmergencyContactNumber <- obj .: "emergencyContactNo"
        donorFirstName <- obj .: "firstName"
        donorFirstTime <- obj .: "firstTimeDonor"
        donorLastName <- obj .: "lastName"
        return Donor{..}
