@parallel=false
Feature: Send SMS using SMPP

    Background:
        * url sttUrl
        * def PcapValidation = Java.type("helpers.PcapValidation")
        * def pcapValidation = new PcapValidation()
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
    
        Scenario: Create SMPP Server
            * pcapValidation.startPcapReading()
            * eval sleep(5000)
            Given path 'create/server'
            * def payloadServer = 
            """
                {
                    "name":"supplierconn1",
                    "service_id":"supplierconn1",
                    "statistics_only":"false",
                    "statistics_response_time_warning_level":"1000"
                }
            """
            And params payloadServer
            When method post
            Then status 200
        
            Given path 'configure/server/supplierconn1'
            * def payloadServerConfigure = 
            """
                {
                    "system_id":"supplierconn1",
                    "window_size":"600",
                    "mps":"0",
                    "enquire_link_period":"60000",
                    "send_dlr_on_submit":"true",
                    "respond_submit":"true",
                    "enquire_link_response":"true",
                    "dlr_delay_ms":"5000"
                }
            """
            And params payloadServerConfigure
            When method post
            Then status 200

            Given path 'create/client'
            * def payloadClinet = 
            """
                {
                    "name":"user1",
                    "service_id":"user1",
                    "statistics_only":"false",
                    "statistics_response_time_warning_level":"1000"
                }
            """
            And params payloadClinet
            When method post
            Then status 200
        
            Given path 'configure/client/user1'
            * def payloadClientConfigure = 
            """
                {
                    "host":"172.20.0.230",
                    "port":"2775",
                    "ssl":"false",
                    "window_size":"600",
                    "response_timeout":"10000",
                    "mps":"600",
                    "submit_delay_ms":"0",
                    "enquire_link_period":"60000",
                    "sequence_number_start":"1"
                }
            """
            And params payloadClientConfigure
            When method post
            Then status 200
        
            Given path 'connect/user1'
            When method post
            Then status 200
        
            Given path 'connectionlink/user1'
            And param link_service_id = 'user1'
            When method post
            Then status 200

            Given path 'bind/user1'
            * def payloadBind = 
            """
                {
                    "bind_type":"transceiver",
                    "system_id":"user1",
                    "password":"12345"
                }
            """
            And params payloadBind
            When method post
            Then status 200

            Given path 'submit_sm/batch/create/user1'
            And param batch_id = 'testmessage01'
            When method post
            Then status 200

            Given path 'submit_sm/batch/add/user1'
            * def payloadMessage = 
            """
                {
                    "batch_id":"testmessage01",
                    "submit_id":"testmessage01_1",
                    "repeat":"1",
                    "source_addr_ton":"2",
                    "source_addr_npi":"4",
                    "source_addr":"35699523380",
                    "dest_addr_ton":"1",
                    "dest_addr_npi":"1",
                    "destination_addr":"35699523365",
                    "esm_class":"3",
                    "data_coding":"3",
                    "message_payload":"VGVzdCBtZXNzYWdlIG5ldyA=",
                    "service_type":"SMPP"
                }
            """
            And params payloadMessage
            When method post
            Then status 200

            Given path 'submit_sm/batch/submit/user1'
            * def payloadMessage = 
            """
                {
                    "batch_id":"testmessage01",
                    "repeat":"1",
                    "shuffle":"true"
                }
            """
            And params payloadMessage
            When method post
            Then status 200
            * eval sleep(5000)
            * pcapValidation.stopPcapReading()