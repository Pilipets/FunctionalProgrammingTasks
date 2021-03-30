module StatsTests where
import Common
import Stats

import Database.HDBC
import Database.HDBC.ODBC

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)

statsTests = testGroup "Stats tests" [
                                      createStatsTest,
                                      updateStatsTest,
                                      deleteStatsTest
                                     ]

createStatsTest =
  testCase "Create stats" $ do
  conn <- ioconn
  statsId <- createStats Stats {idStats=1,
                                registeredUsers=9,
                                popularity=500
                               } conn
  stats <- readStats statsId conn
  assertEqual "Stats id equal" statsId (idStats stats)
  assertEqual "Stats registered users equal" 9 (registeredUsers stats)
  assertEqual "Stats email equal" 500 (popularity stats)
  isDeleted <- deleteStats statsId conn
  assertEqual "Stats deleted" True isDeleted

updateStatsTest =
  testCase "Update stats" $ do
  conn <- ioconn
  statsId <- createStats Stats {idStats=1,
                                registeredUsers=90,
                                popularity=500
                               } conn
  isUpdated <- updateStats Stats {idStats=statsId,
                                   registeredUsers=9,
                                   popularity=10
                                  } conn
  assertEqual "Stats updated" True isUpdated
  stats <- readStats statsId conn
  assertEqual "Stats id equal" statsId (idStats stats)
  assertEqual "Stats registered users equal" 9 (registeredUsers stats)
  assertEqual "Stats email equal" 10 (popularity stats)
  isDeleted <- deleteStats statsId conn
  assertEqual "Stats deleted" True isDeleted

deleteStatsTest =
  testCase "Delete stats" $ do
  conn <- ioconn
  statsId <- createStats Stats {idStats=1,
                                registeredUsers=200,
                                popularity=576
                               } conn
  isDeleted <- deleteStats statsId conn
  assertEqual "Stats deleted" True isDeleted
  statsId <- checkIfStatsExists Stats {idStats=1,
                                       registeredUsers=200,
                                       popularity=576
                                      } conn
  assertEqual "Stats is not exists" 0 statsId
