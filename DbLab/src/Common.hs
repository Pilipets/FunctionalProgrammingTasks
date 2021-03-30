{-# LANGUAGE OverloadedStrings #-}
module Common where

import Database.HDBC
import Database.HDBC.ODBC
import Data.Int


ioconn :: IO Connection
ioconn = connectODBC "DSN=MySQL_Univ"

convRow [] = 0
convRow (sqlId:_) = intId
  where
    intId = fromSql $ head sqlId :: Int32