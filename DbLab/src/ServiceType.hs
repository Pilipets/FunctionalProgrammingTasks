{-# LANGUAGE OverloadedStrings #-}
module ServiceType where

import Common
import Database.HDBC
import Database.HDBC.ODBC
import Data.Int


checkIfTypeExists :: String -> Connection -> IO Int32
checkIfTypeExists serviceType conn = do
    result <- quickQuery conn query [SqlString serviceType]
    return $ convRow result
    where
        query = "SELECT idtypes FROM types where typename = ?"