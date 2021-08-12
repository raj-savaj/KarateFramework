@parallel=false
Feature: API Test
    Background:
        * url apiUrl
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def token = tokenResponse.accessToken

    Scenario: get all country and select malta country
        Given path 'destinations/countries'
        Given header Authorization = 'Bearer ' + token
        When method get
        Then status 200
        * def countyId = get[0] response.countries[?(@.country_name=='Malta')].country_id
        
        Given path "destinations/countries/"+countyId+"/networks"
        Given header Authorization = 'Bearer ' + token
        When method get
        Then status 200
        * def networkId = get[0] response.networks[?(@.network_name=='Vodafone')].network_id