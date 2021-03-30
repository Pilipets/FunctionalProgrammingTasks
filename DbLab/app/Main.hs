module Main where

import Lib
import Author
import Legals
import Service
import Stats
import Common

import Database.HDBC
import Database.HDBC.ODBC

authorsDemo = do
    conn <- ioconn

    putStrLn "\n-----------AUTHORS------------"

    putStrLn "\nReading all authors..."
    allAuthors <- readAllAuthors conn
    mapM_ print allAuthors

    putStrLn "\nCreating author..."
    authorId <- createAuthor someAuthor1 conn
    putStrLn "New author's id:"
    print authorId
    putStrLn "New author:"
    author <- readAuthor authorId conn
    print author

    putStr "\nUpdating author... "
    isUpdated <- updateAuthor someAuthor2 {Author.id=authorId} conn
    print isUpdated
    putStrLn "Updated author:"
    author <- readAuthor authorId conn
    print author

    putStr "\nDeleting author..."
    isDeleted <- deleteAuthor authorId conn
    print isDeleted
    putStrLn "\nReading all authors..."
    allAuthors <- readAllAuthors conn
    mapM_ print allAuthors

    disconnect conn

statsDemo = do
    conn <- ioconn

    putStrLn "\n-----------STATS--------------"

    putStrLn "\nReading all stats..."
    allStats <- readAllStats conn
    mapM_ print allStats

    putStrLn "\nCreating author..."
    statsId <- createStats someStats1 conn
    putStrLn "New stats id:"
    print statsId
    putStrLn "New stats:"
    stats <- readStats statsId conn
    print stats

    putStr "\nUpdating stats... "
    isUpdated <- updateStats someStats2 {idStats=statsId} conn
    print isUpdated
    putStrLn "Updated stats:"
    stats <- readStats statsId conn
    print stats

    putStr "\nDeleting stats..."
    isDeleted <- deleteStats statsId conn
    print isDeleted
    putStrLn "\nReading all stats..."
    allStats <- readAllStats conn
    print allStats

    disconnect conn


legalsDemo = do
    conn <- ioconn

    putStrLn "\n-----------LEGALS-------------"

    putStrLn "\nReading all legals..."
    allLegals <- readAllLegals conn
    mapM_ print allLegals

    putStrLn "\nCreating legals..."
    legalsId <- createLegals someLegals1 conn
    putStrLn "New legals id:"
    print legalsId
    putStrLn "New legals:"
    legals <- readLegals legalsId conn
    print legals

    putStr "\nUpdating legals... "
    isUpdated <- updateLegals someLegals2 {Legals.id=legalsId} conn
    print isUpdated
    putStrLn "Updated legals:"
    legals <- readLegals legalsId conn
    print legals

    putStr "\nDeleting legals..."
    isDeleted <- deleteLegals legalsId conn
    print isDeleted
    putStrLn "\nReading all stats..."
    allLegals <- readAllLegals conn
    print allLegals

    disconnect conn

servicesDemo = do
    conn <- ioconn

    putStrLn "\n-----------SERVICES-----------"

    putStrLn "Reading all services..."
    allServices <- readAllServices conn
    mapM_ print allServices

    putStrLn "Creating service..."
    serviceId <- createService someService1 conn
    putStrLn "New service id:"
    print serviceId
    putStrLn "New service:"
    service <- readService serviceId conn
    print service

    putStr "\nUpdating service... "
    isUpdated <- updateService someService2 {Service.id=serviceId} conn
    print isUpdated
    putStrLn "Updated service:"
    service <- readService serviceId conn
    print service

    putStr "\nDeleting service..."
    isDeleted <- deleteService serviceId conn
    print isDeleted

    putStrLn "\nReading all services..."
    allServices <- readAllServices conn
    mapM_ print allServices

    disconnect conn

main = do
  authorsDemo
  statsDemo
  legalsDemo
  servicesDemo

