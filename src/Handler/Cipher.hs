{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Cipher where

import qualified Data.ByteString.Base64.URL as Base64
import qualified Data.Cipher as Cipher
import qualified Data.Text.Encoding as Text
import Import

getCipherR :: Text -> HandlerFor App Value
getCipherR msg = do
    App{appCipherSecretKey = sk, appCipherInitializationVector = iv} <- getYesod
    case Cipher.encrypt sk iv (Text.encodeUtf8 msg) of
        Left _ -> sendStatusJSON internalServerError500 $ object ["msg" .= ("Unable to cipher input" :: Text)]
        Right eMsg ->
            pure $
                object
                    [ "message" .= msg
                    , "cipher" .= Base64.encodeBase64 eMsg
                    ]
