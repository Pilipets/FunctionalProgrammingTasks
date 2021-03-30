{-# LANGUAGE OverloadedStrings #-}
module Legals where

import Common
import qualified Data.ByteString.Char8    as BS
import Database.HDBC
import Database.HDBC.ODBC
import Data.Int
import           Prelude                  hiding (read)


data Legals  = Legals {id :: Int32,
                       rules :: String,
                       registrationInfo :: String,
                       agreement :: String
                       } deriving (Show)

unpack [SqlInt32 uid,
        SqlByteString rules,
        SqlByteString registrationInfo,
        SqlByteString agreement] = Legals {Legals.id=uid,
                                       rules = BS.unpack rules,
                                       registrationInfo = BS.unpack registrationInfo,
                                       agreement = BS.unpack agreement}
unpack x = error $ "Unexpected result: " ++ show x

createLegals :: Legals -> Connection -> IO Int32
createLegals legals conn = withTransaction conn (createLegals' legals)

createLegals' :: Legals -> Connection -> IO Int32
createLegals' legals conn = do
    changed <- quickQuery conn query [SqlString $ rules legals, SqlString $ registrationInfo legals, SqlString $ agreement legals]
    result <- quickQuery' conn lastId []
    let rows = convRow result
    commit conn
    return rows
    where
        query = "INSERT INTO legals (`rules`, `registration_info`, `agreement`) VALUES (?, ?, ?)"
        lastId = "select max(idlegals) from legals"

readLegals :: Int32 -> Connection  -> IO Legals
readLegals id conn = do
    vals <- quickQuery conn query [SqlInt32 id]
    let rows = map unpack vals
    return $ last rows
    where
        query = "SELECT * FROM legals where idlegals = ?"

readAllLegals :: Connection -> IO [Legals]
readAllLegals conn = do
    vals <- quickQuery conn query []
    let rows = map unpack vals
    return rows
    where
        query = "SELECT * FROM legals"


updateLegals :: Legals -> Connection -> IO Bool
updateLegals legals conn = withTransaction conn (updateLegals' legals)

updateLegals' :: Legals -> Connection -> IO Bool
updateLegals' legals conn = do
    result <- run conn query [SqlString $ rules legals, SqlString $ registrationInfo legals, SqlString $ agreement legals, SqlInt32 $ Legals.id legals]
    return $ result == 1
    where
        query = "UPDATE legals SET rules = ?, registration_info = ?, agreement = ? WHERE (idlegals = ?)"


deleteLegals :: Int32 -> Connection -> IO Bool
deleteLegals id conn = withTransaction conn (deleteLegals' id)

deleteLegals' :: Int32 -> Connection -> IO Bool
deleteLegals' id conn = do
    result <- run conn query [SqlInt32 id]
    return $ result == 1
    where
        query = "DELETE FROM legals where (idlegals = ?)"

