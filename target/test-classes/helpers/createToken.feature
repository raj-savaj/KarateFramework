Feature: Create token
    Scenario: Create token
        Given url apiUrl
        And path 'oauth/token'
        And params {username:"admin.xchange","password":"Haudsysops123!",grant_type:"password"}
        And header Authorization = 'Basic Y2xpZW50SWQ6c2VjcmV0'
        When method post
        Then status 200
        * def accessToken = response.access_token 