{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Decipher where

import qualified Data.ByteString.Base64.URL as Base64
import qualified Data.Cipher as Cipher
import qualified Data.Text.Encoding as Text
import Import

getDecipherR :: Text -> HandlerFor App Value
getDecipherR cipher' = do
    App{appCipherSecretKey = sk, appCipherInitializationVector = iv} <- getYesod
    let eCipher = Base64.decodeBase64 (Text.encodeUtf8 cipher')
        encryptionError = sendStatusJSON internalServerError500 $ object ["msg" .= ("Unable to decipher input" :: Text)]
    case eCipher of
        Left _ -> encryptionError
        Right cipher -> do
            case Cipher.decrypt sk iv cipher of
                Left _ -> encryptionError
                Right decipher ->
                    pure $
                        object
                            [ "message" .= cipher'
                            , "decipher" .= Text.decodeUtf8 decipher
                            ]
