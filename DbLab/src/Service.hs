{-# LANGUAGE OverloadedStrings #-}
module Service where

import Common
import ServiceType
import Author
import Stats
import Data.Time
import Data.Time.LocalTime

import qualified Data.ByteString.Char8    as BS
import Database.HDBC
import Database.HDBC.ODBC
import Data.Int
import           Prelude                  hiding (read)


data Service = Service {
                 id :: Int32
               , sName :: String
               , annotation :: String
               , version :: String
               , created :: Int32
               , eol :: Int32
               , serviceType :: Int32
               , authorId :: Int32
               , legalsId :: Int32
               , statsId :: Int32
               } deriving (Show)


unpackService conn [SqlInt32 uid,
        SqlByteString name,
        SqlByteString annotation,
        SqlByteString version,
        SqlInt32 created,
        SqlInt32 eol,
        SqlInt32 serviceType,
        SqlInt32 authorId,
        SqlInt32 legalsId,
        SqlInt32 statsId] = Service {Service.id=uid,
                                sName = BS.unpack name,
                                annotation = BS.unpack annotation,
                                version = BS.unpack version,
                                Service.created = created,
                                Service.eol = eol,
                                serviceType = serviceType,
                                authorId = authorId,
                                legalsId = legalsId,
                                statsId = statsId}
unpackService conn x = error $ "Unexpected result: " ++ show x


createService :: Service -> Connection -> IO Int32
createService service conn = withTransaction conn (createService' service)

createService' :: Service -> Connection -> IO Int32
createService' service conn = do
    changed <- quickQuery conn query [SqlString $ sName service,
                                      SqlString $ annotation service,
                                      SqlString $ version service,
                                      SqlInt32 $ created service,
                                      SqlInt32 $ eol service,

                                      SqlInt32 $ serviceType service,
                                      SqlInt32 $ authorId service,
                                      SqlInt32 $ legalsId service,
                                      SqlInt32 $ statsId service
                                      ]
    result <- quickQuery' conn lastId []
    let rows = convRow result
    commit conn
    return rows
    where
        query = "INSERT INTO services (`name`, `annotation`, `version`, `created`, `eol`, `typeid`, `authorid`, `legalsid`, `statsid`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        lastId = "select max(idService) from services"

readService :: Int32 -> Connection -> IO Service
readService id conn = do
    vals <-quickQuery conn query [SqlInt32 id]
    let rows = map (unpackService conn) vals
    return $ last rows
    where
        query = "SELECT * from services where (idService = ?)"

readAllServices :: Connection -> IO [Service]
readAllServices conn = do
    vals <- quickQuery conn query []
    let rows = map (unpackService conn) vals
    return rows
    where
        query = "SELECT * from services"


updateService :: Service -> Connection -> IO Bool
updateService service conn = withTransaction conn (updateService' service)

updateService' service conn = do
    result <- run conn query [SqlString $ sName service,
                              SqlString $ annotation service,
                              SqlString $ version service,
                              SqlInt32 $ created service,
                              SqlInt32 $ eol service,

                              SqlInt32 $ serviceType service,
                              SqlInt32 $ authorId service,
                              SqlInt32 $ legalsId service,
                              SqlInt32 $ statsId service,
                              SqlInt32 $ Service.id service
                              ]
    return $ result == 1
    where
        query = "UPDATE services SET name = ?, annotation = ?, version = ?, created = ?, eol = ? , typeid = ?, authorid = ?, legalsid = ?, statsid = ? WHERE (idService = ?)"


deleteService :: Int32 -> Connection -> IO Bool
deleteService id conn = withTransaction conn (deleteService' id)

deleteService' :: Int32 -> Connection -> IO Bool
deleteService' id conn = do
    result <- run conn query [SqlInt32 id]
    return $ result == 1
    where
        query = "DELETE FROM services where (idService = ?)"
