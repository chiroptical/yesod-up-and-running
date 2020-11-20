{-# LANGUAGE OverloadedStrings #-}

module Handler.Generate where

import qualified Crypto.PubKey.RSA as RSA
import Import

-- TODO:
-- How do we give back the public and private keys to the user?

postGenerateR :: HandlerFor App Value
postGenerateR = do
    -- Chosen from random website, doesn't really matter which p, q, and e are for this demonstration
    case RSA.generateWith (11, 3) 256 3 of
        Nothing -> sendStatusJSON internalServerError500 $ object ["msg" .= ("Unable to generate public and private RSA keys" :: Text)]
        Just (pub, priv) ->
            pure $ object ["publicKey" .= show pub, "privateKey" .= show priv]
