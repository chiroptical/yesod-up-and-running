{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Hash where

import Crypto.Hash
import qualified Data.ByteArray as ByteArray
import qualified Data.ByteArray.Encoding as ByteArray
import qualified Data.ByteString as ByteString
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import Import

data HasHash where
    HasHash :: (HashAlgorithm alg, ByteArray.ByteArrayAccess ba) => alg -> ba -> HasHash

elimHasHash ::
    ByteArray.Base ->
    (forall alg ba. (HashAlgorithm alg, ByteArray.ByteArrayAccess ba) => alg -> ba -> Digest alg) ->
    HasHash ->
    ByteString.ByteString
elimHasHash base f (HasHash alg ba) = ByteArray.convertToBase base $ f alg ba

toHash :: Text -> ByteString.ByteString -> Maybe HasHash
toHash alg ba = case Text.toLower alg of
    "md5" -> Just $ HasHash MD5 ba
    "sha1" -> Just $ HasHash SHA1 ba
    "sha256" -> Just $ HasHash SHA256 ba
    _ -> Nothing

toBase :: Maybe Text -> ByteArray.Base
toBase = maybe ByteArray.Base16 $ \case
    "base16" -> ByteArray.Base16
    "base32" -> ByteArray.Base32
    "base64" -> ByteArray.Base64
    _ -> ByteArray.Base16

getHashR :: Text -> Text -> HandlerFor App Value
getHashR algoText msg = do
    base <- toBase <$> lookupGetParam "base"
    h <- case toHash algoText (Text.encodeUtf8 msg) of
        Just hasHash -> pure $ elimHasHash base hashWith hasHash
        Nothing -> notFound
    pure $
        object
            [ "output" .= Text.decodeUtf8 h
            , "algorithm" .= algoText
            , "input" .= msg
            ]
