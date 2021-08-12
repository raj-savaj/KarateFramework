Feature: Work with redis

Background: Connected to redis
    * def redisHandler = Java.type("helpers.RedisHandler")
    * def PcapValidation = Java.type("helpers.PcapValidation")
    * def pcapValidation = new PcapValidation()


    Scenario: Retrive country count
        * pcapValidation.startPcapReading()
        * def route = redisHandler.getRedisData("edge.core.sms.routes-data")
        * pcapValidation.stopPcapReading()