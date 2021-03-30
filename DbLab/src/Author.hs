{-# LANGUAGE OverloadedStrings #-}
module Author where

import Common
import qualified Data.ByteString.Char8    as BS
import Database.HDBC
import Database.HDBC.ODBC
import Data.Int
import           Prelude                  hiding (read)


data Author  = Author {id :: Int32,
                       name :: String,
                       email :: String,
                       phone :: String
                       } deriving (Show)

unpack [SqlInt32 uid, SqlByteString name, SqlByteString email, SqlByteString phone] = Author {Author.id=uid, name = BS.unpack name, email = BS.unpack email, phone = BS.unpack phone}
unpack x = error $ "Unexpected result: " ++ show x

createAuthor :: Author -> Connection -> IO Int32
createAuthor author conn = withTransaction conn (createAuthor' author)

createAuthor' :: Author -> Connection -> IO Int32
createAuthor' author conn = do
    changed <- quickQuery conn query [SqlString $ name author, SqlString $ email author, SqlString $ phone author]
    result <- quickQuery' conn lastId []
    let rows = convRow result
    commit conn
    return rows
    where
        query = "INSERT INTO authors (`name`, `email`, `phone`) VALUES (?, ?, ?)"
        lastId = "select max(idauthor) from authors"


checkIfAuthorExists :: Author -> Connection -> IO Int32
checkIfAuthorExists author conn = do
    result <- quickQuery conn query [SqlString $ name author, SqlString $ email author, SqlString $ phone author]
    return $ convRow result
    where
        query = "SELECT idauthor FROM authors where name = ? and email = ? and phone = ?"


readAuthor :: Int32 -> Connection  -> IO Author
readAuthor id conn = do
    vals <- quickQuery conn query [SqlInt32 id]
    let rows = map unpack vals
    return $ last rows
    where
        query = "SELECT * FROM authors where idauthor = ?"

readAllAuthors :: Connection -> IO [Author]
readAllAuthors conn = do
    vals <- quickQuery conn query []
    let rows = map unpack vals
    return rows
    where
        query = "SELECT * FROM authors"


updateAuthor :: Author -> Connection -> IO Bool
updateAuthor author conn = withTransaction conn (updateAuthor' author)

updateAuthor' :: Author -> Connection -> IO Bool
updateAuthor' author conn = do
    result <- run conn query [SqlString $ name author, SqlString $ email author, SqlString $ phone author, SqlInt32 $ Author.id author]
    return $ result == 1
    where
        query = "UPDATE authors SET name = ?, email = ?, phone = ? WHERE (idauthor = ?)"


deleteAuthor :: Int32 -> Connection -> IO Bool
deleteAuthor id conn = withTransaction conn (deleteAuthor' id)

deleteAuthor' :: Int32 -> Connection -> IO Bool
deleteAuthor' id conn = do
    result <- run conn query [SqlInt32 id]
    return $ result == 1
    where
        query = "DELETE FROM authors where (idauthor = ?)"

