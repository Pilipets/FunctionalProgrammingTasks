module AuthorTests where
import Common
import Author

import Database.HDBC
import Database.HDBC.ODBC

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)

authorTests = testGroup "Author tests" [
                                        createAuthorTest,
                                        updateAuthorTest,
                                        deleteAuthorTest
                                       ]

testAuthorName = "Test Author"
testAuthorPhone = "+380501234567"
testAuthorEmail = "testAuthor@gmail.com"
testAuthor = Author {Author.id=1,
              Author.name=testAuthorName,
              Author.email=testAuthorEmail,
              Author.phone=testAuthorPhone
             }

testAuthorName2 = "Test Authoress"
testAuthorPhone2 = "+380501234566"
testAuthorEmail2 = "testAuthoress@gmail.com"


createAuthorTest =
  testCase "Create author" $ do
  conn <- ioconn
  authorId <- createAuthor testAuthor conn
  author <- readAuthor authorId conn
  assertEqual "Author id equal" authorId (Author.id author)
  assertEqual "Author name equal" testAuthorName (name author)
  assertEqual "Author email equal" testAuthorEmail (email author)
  assertEqual "Author phone equal" testAuthorPhone (phone author)
  isDeleted <- deleteAuthor authorId conn
  assertEqual "Author deleted" True isDeleted

updateAuthorTest =
  testCase "Update author" $ do
  conn <- ioconn
  authorId <- createAuthor testAuthor conn
  isUpdated <- updateAuthor Author {Author.id=authorId,
                                    Author.name=testAuthorName2,
                                    Author.email=testAuthorEmail2,
                                    Author.phone=testAuthorPhone2 } conn
  assertEqual "Author updated" True isUpdated
  author <- readAuthor authorId conn
  assertEqual "Author id equal" authorId (Author.id author)
  assertEqual "Author name equal" testAuthorName2 (name author)
  assertEqual "Author email equal" testAuthorEmail2 (email author)
  assertEqual "Author phone equal" testAuthorPhone2 (phone author)
  isDeleted <- deleteAuthor authorId conn
  assertEqual "Author deleted" True isDeleted

deleteAuthorTest =
  testCase "Delete author" $ do
  conn <- ioconn
  authorId <- createAuthor testAuthor conn
  isDeleted <- deleteAuthor authorId conn
  assertEqual "Author deleted" True isDeleted
  authorId <- checkIfAuthorExists testAuthor conn
  assertEqual "Author is not exists" 0 authorId