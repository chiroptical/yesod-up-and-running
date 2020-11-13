{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Donor where

import Data.Donor
import Database.Donor
import Import

postDonorR :: HandlerFor App Value
postDonorR = do
    donor' <- requireCheckJsonBody :: Handler Donor
    (key, donor) <- runDB $ createDonor donor'
    pure $ object ["id" .= key, "contents" .= toJSON donor]

getDonorR :: HandlerFor App Value
getDonorR = toJSON <$> runDB readDonors
