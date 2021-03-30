module ServiceTests where
import Common
import Service

import Database.HDBC
import Database.HDBC.ODBC

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)

serviceTests = testGroup "Service tests" [
                                          createServiceTest,
                                          updateServiceTest
                                         ]

createServiceTest =
  testCase "Create service" $ do
  conn <- ioconn
  serviceId <- createService Service {Service.id=1,
                                      Service.sName="my service",
                                      annotation="my service ann",
                                      version="v18.04",
                                      created=14,
                                      eol=53,
                                      serviceType=46,
                                      authorId=1,
                                      legalsId=68,
                                      statsId=40
                                     } conn
  service <- readService serviceId conn
  assertEqual "Service id equal" serviceId (Service.id service)
  assertEqual "Service name equal" "my service" (sName service)
  assertEqual "Service annotation equal" "my service ann" (annotation service)
  assertEqual "Service version equal" "v18.04" (version service)
  assertEqual "Service created equal" 14 (created service)
  assertEqual "Service eol equal" 53 (eol service)
  assertEqual "Service serviceType equal" 46 (serviceType service)
  assertEqual "Service authorId equal" 1 (authorId service)
  assertEqual "Service legalsId equal" 68 (legalsId service)
  assertEqual "Service statsId equal" 40 (statsId service)
  isDeleted <- deleteService serviceId conn
  assertEqual "Service deleted" True isDeleted

updateServiceTest =
  testCase "Update service" $ do
  conn <- ioconn
  serviceId <- createService Service {Service.id=1,
                                      Service.sName="room service",
                                      annotation="annotation about room",
                                      version="v18.04",
                                      created=1,
                                      eol=5,
                                      serviceType=46,
                                      authorId=1,
                                      legalsId=68,
                                      statsId=40
                                     } conn
  isUpdated <- updateService Service {Service.id=serviceId,
                                      Service.sName="ship service",
                                      annotation="annotation about ship",
                                      version="v18.04",
                                      created=10,
                                      eol=59,
                                      serviceType=46,
                                      authorId=1,
                                      legalsId=68,
                                      statsId=40
                                     } conn
  assertEqual "Service updated" True isUpdated
  service <- readService serviceId conn
  assertEqual "Service id equal" serviceId (Service.id service)
  assertEqual "Service name equal" "ship service" (sName service)
  assertEqual "Service annotation equal" "annotation about ship" (annotation service)
  assertEqual "Service version equal" "v18.04" (version service)
  assertEqual "Service created equal" 10 (created service)
  assertEqual "Service eol equal" 59 (eol service)
  assertEqual "Service serviceType equal" 46 (serviceType service)
  assertEqual "Service authorId equal" 1 (authorId service)
  assertEqual "Service legalsId equal" 68 (legalsId service)
  assertEqual "Service statsId equal" 40 (statsId service)
  isDeleted <- deleteService serviceId conn
  assertEqual "Service deleted" True isDeleted