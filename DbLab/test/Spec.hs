import Lib
import Legals
import Service
import Stats
import Common

import Test.Tasty (defaultMain, testGroup)

import AuthorTests (authorTests)
import LegalsTests (legalsTests)
import StatsTests (statsTests)
import ServiceTests (serviceTests)

main = defaultMain allTests

allTests = testGroup "All tests" [
                                  authorTests,
                                  statsTests,
                                  legalsTests,
                                  serviceTests
                                 ]
