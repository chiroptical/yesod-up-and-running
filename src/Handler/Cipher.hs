{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Cipher where

import qualified Data.Cipher as Cipher
import qualified Data.Text.Encoding as Text
import Import

data Message = Message {msg :: Text} deriving (Generic, FromJSON)

postCipherR :: HandlerFor App Value
postCipherR = do
    App{appCipherSecretKey = sk, appCipherInitializationVector = iv} <- getYesod
    Message{..} <- requireCheckJsonBody :: Handler Message
    case Cipher.encrypt sk iv (Text.encodeUtf8 msg) of
        Left _ -> sendStatusJSON internalServerError500 $ object ["msg" .= ("Unable to encrypt input" :: Text)]
        Right eMsg ->
            pure $
                object
                    [ "message" .= msg
                    , "encrypted" .= show eMsg
                    ]
