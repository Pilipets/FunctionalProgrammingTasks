{-# LANGUAGE OverloadedStrings #-}
module Stats where

import Data.Function ((&))
import Data.Proxy
import Control.Monad.Identity
import Database.HDBC
import Database.HDBC.ODBC
import Data.Int


data Stats = Stats {idStats :: Int32,
                    registeredUsers :: Int32,
                    popularity :: Int32
                   } deriving (Show)

unpackStats [SqlInt32 uid,
             SqlInt32 registeredUsers,
             SqlInt32 popularity] = Stats {idStats=uid,
                                           registeredUsers = registeredUsers,
                                           popularity = popularity
                                          }
unpackStats x = error $ "Unexpected result: " ++ show x

convRow32 [] = 0
convRow32 (sqlId:_) = intId
  where
    intId = fromSql $ head sqlId :: Int32

checkIfStatsExists :: Stats -> Connection -> IO Int32
checkIfStatsExists stats conn = do
    result <- quickQuery conn query [SqlInt32 $ registeredUsers stats, SqlInt32 $ popularity stats]
    return (convRow32 result)
    where
        query = "SELECT idstats FROM stats where users_registered = ? and popularity = ?"

createStats :: Stats -> Connection -> IO Int32
createStats stats conn = withTransaction conn (createStats' stats)

createStats' :: Stats -> Connection -> IO Int32
createStats' stats conn = do
    changed <- quickQuery conn query [SqlInt32 $ registeredUsers stats, SqlInt32 $ popularity stats]
    result <- quickQuery' conn lastId []
    let rows = convRow32 result
    commit conn
    return rows
    where
        query = "INSERT INTO stats (`users_registered`, `popularity`) VALUES (?, ?)"
        lastId = "select max(idstats) from stats"


readStats :: Int32 -> Connection  -> IO Stats
readStats id conn = do
    vals <- quickQuery conn query [SqlInt32 id]
    let rows = map unpackStats vals
    return $ last rows
    where
        query = "SELECT * FROM stats where idstats = ?"


readAllStats :: Connection -> IO [Stats]
readAllStats conn = do
    vals <- quickQuery conn query []
    let rows = map unpackStats vals
    return rows
    where
        query = "SELECT * FROM stats"


updateStats :: Stats -> Connection -> IO Bool
updateStats stats conn = withTransaction conn (updateStats' stats)

updateStats' :: Stats -> Connection -> IO Bool
updateStats' stats conn = do
    result <- run conn query [SqlInt32 $ registeredUsers stats, SqlInt32 $ popularity stats, SqlInt32 $ Stats.idStats stats]
    return $ result == 1
    where
        query = "UPDATE stats SET users_registered = ?, popularity = ? WHERE (idstats = ?)"


deleteStats :: Int32 -> Connection -> IO Bool
deleteStats id conn = withTransaction conn (deleteStats' id)

deleteStats' :: Int32 -> Connection -> IO Bool
deleteStats' id conn = do
    result <- run conn query [SqlInt32 id]
    return $ result == 1
    where
        query = "DELETE FROM stats where (idstats = ?)"