module LegalsTests where
import Common
import Legals

import Database.HDBC
import Database.HDBC.ODBC

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)

legalsTests = testGroup "Legals tests" [
                                        createLegalsTest,
                                        updateLegalsTest
                                       ]

createLegalsTest =
  testCase "Create legals" $ do
  conn <- ioconn
  legalsId <- createLegals Legals {Legals.id=1,
                                   rules="my rules",
                                   registrationInfo="reg info",
                                   agreement="agree 223"
                                  } conn
  legals <- readLegals legalsId conn
  assertEqual "Legals id equal" legalsId (Legals.id legals)
  assertEqual "Legals rules equal" "my rules" (rules legals)
  assertEqual "Legals registration info equal" "reg info" (registrationInfo legals)
  assertEqual "Legals agreement equal" "agree 223" (agreement legals)
  isDeleted <- deleteLegals legalsId conn
  assertEqual "Legals deleted" True isDeleted

updateLegalsTest =
  testCase "Update legals" $ do
  conn <- ioconn
  legalsId <- createLegals Legals {Legals.id=1,
                                   rules="rules 7436 5",
                                   registrationInfo="registered info",
                                   agreement="agree 223"
                                  } conn
  isUpdated <- updateLegals Legals {Legals.id=legalsId,
                                    rules="no rules",
                                    registrationInfo="no info",
                                    agreement="agree 223"
                                   } conn
  assertEqual "Legals updated" True isUpdated
  legals <- readLegals legalsId conn
  assertEqual "Legals id equal" legalsId (Legals.id legals)
  assertEqual "Legals rules equal" "no rules" (rules legals)
  assertEqual "Legals registration info equal" "no info" (registrationInfo legals)
  assertEqual "Legals agreement equal" "agree 223" (agreement legals)
  isDeleted <- deleteLegals legalsId conn
  assertEqual "Legals deleted" True isDeleted