Feature: Work with database

    Background: Connected to database
        * def dbHandler = Java.type("helpers.DbHandler")
    
    Scenario: Retrive country count
        * def dbCount = dbHandler.getCountryCount()
        * print dbCount.count