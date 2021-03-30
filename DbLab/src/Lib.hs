{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc,
    someAuthor1,
    someAuthor2,
    someService1,
    someService2,
    someStats1,
    someStats2,
    someLegals1,
    someLegals2
    ) where

import Service
import Author
import Stats
import Legals


someFunc :: IO ()
someFunc = putStrLn "someFunc"


someAuthor1 = Author {  Author.id=0,
                        Author.name="Yevhenii Kozii",
                        Author.email="varmid@gmail.com",
                        Author.phone="+380664159604"
                     }

someAuthor2 = Author {  Author.id=0,
                        Author.name="Some Author",
                        Author.email="someauthor@gmail.com",
                        Author.phone="+380500000000"
                     }

someService1  = Service {    Service.id=0,
                             Service.sName="New service",
                             annotation="New service ann",
                             version="v1.0",
                             created=14,
                             eol=53,
                             serviceType=2,
                             authorId=0,
                             legalsId=0,
                             statsId=0
                        }

someService2  = Service {Service.id=0,
                         Service.sName="Updated service",
                         annotation="Updated service ann",
                         version="v2.0",
                         created=14,
                         eol=63,
                         serviceType=1,
                         authorId=0,
                         legalsId=0,
                         statsId=0
                        }


someStats1 = Stats {idStats=0,
                    registeredUsers=90,
                    popularity=0
                   }


someStats2 = Stats {idStats=0,
                    registeredUsers=2900,
                    popularity=800
                   }

someLegals1 = Legals {Legals.id=0,
                    rules="New rules",
                    registrationInfo="New reg info",
                    agreement="New agreement"
                   }

someLegals2 = Legals {Legals.id=0,
                    rules="Updated rules",
                    registrationInfo="Updated reg info",
                    agreement="Updated agreement"
                   }