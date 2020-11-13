{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Handler.Hash where

import Crypto.Hash
import Crypto.Hash.Algorithms
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import Import

data HasHashAlgorithm where
    HasHashAlgorithm :: HashAlgorithm a => a -> HasHashAlgorithm

elimHasHashAlgorithm ::
    forall a.
    HashAlgorithm a =>
    (a -> Digest a) ->
    HasHashAlgorithm ->
    Digest a
elimHasHashAlgorithm f (HasHashAlgorithm algo) = f algo

toAlgorithm :: Text -> HasHashAlgorithm
toAlgorithm alg = case Text.toLower alg of
    "md5" -> HasHashAlgorithm MD5
    "sha1" -> HasHashAlgorithm SHA1

getHashR :: Text -> Text -> HandlerFor App Value
getHashR algoText msg = do
    let hash = elimHasHashAlgorithm (\algo -> hashWith algo (Text.encodeUtf8 msg)) (toAlgorithm algoText)
    pure Null
