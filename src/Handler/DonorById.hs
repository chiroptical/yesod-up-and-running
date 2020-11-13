{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.DonorById where

import Data.Donor (Donor)
import Database.Donor
import Import

getDonorByIdR :: Int64 -> HandlerFor App Value
getDonorByIdR ident = do
    mDonor <- runDB $ readDonor ident
    case mDonor of
        Nothing -> notFound
        Just donor -> pure $ toJSON donor

deleteDonorByIdR :: Int64 -> HandlerFor App Value
deleteDonorByIdR ident = do
    mKey <- runDB $ deleteDonor ident
    maybe
        notFound
        ( const . pure $
            object ["msg" .= ("Deleted donor with id" :: Text), "id" .= ident]
        )
        mKey

putDonorByIdR :: Int64 -> HandlerFor App Value
putDonorByIdR ident = do
    donor <- requireCheckJsonBody :: Handler Donor
    runDB $ updateDonor ident donor
    pure $
        object
            [ "msg" .= ("Updated or inserted donor with id" :: Text)
            , "id" .= ident
            ]
