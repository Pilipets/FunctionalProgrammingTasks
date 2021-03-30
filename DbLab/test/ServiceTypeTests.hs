module ServiceTypeTests where
import Common
import ServiceType

import Database.HDBC
import Database.HDBC.ODBC

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)