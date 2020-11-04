{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.About where

import Import

getAboutR :: Handler Html
getAboutR =
    defaultLayout $ do
        setTitle "About This Site"
        $(widgetFile "about")
