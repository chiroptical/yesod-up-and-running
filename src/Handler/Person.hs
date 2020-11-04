{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Person where

import Import

getPersonR :: HandlerFor App Value
getPersonR = return $ object [key .= value]
  where
    key :: Text
    key = "person"
    value :: Text
    value = "chiroptical"
