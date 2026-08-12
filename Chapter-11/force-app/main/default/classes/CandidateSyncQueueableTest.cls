@IsTest
private class CandidateSyncQueueableTest {

    @IsTest
    static void testCandidateSyncSuccess() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Selected',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableMock(201)
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(applicationRecord.Id)
        );

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Integration_Status__c,
                   External_Candidate_Id__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.debug(
            'INTEGRATION STATUS: ' +
            updatedApplication.Integration_Status__c
        );

        System.debug(
            'INTEGRATION ERROR: ' +
            updatedApplication.Integration_Error__c
        );

        System.assertEquals(
            'Sent',
            updatedApplication.Integration_Status__c
        );

        System.assertEquals(
            'EXT-10001',
            updatedApplication.External_Candidate_Id__c
        );

        System.assertEquals(
            null,
            updatedApplication.Integration_Error__c
        );
    }


    @IsTest
    static void testBadRequest() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Selected',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableMock(400)
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(applicationRecord.Id)
        );

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Integration_Status__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Failed',
            updatedApplication.Integration_Status__c
        );

        System.assert(
            updatedApplication.Integration_Error__c.contains(
                'Bad Request'
            )
        );
    }


    @IsTest
    static void testUnauthorized() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Selected',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableMock(401)
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(applicationRecord.Id)
        );

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Integration_Status__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Failed',
            updatedApplication.Integration_Status__c
        );

        System.assert(
            updatedApplication.Integration_Error__c.contains(
                'Authentication failure'
            )
        );
    }


    @IsTest
    static void testForbidden() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Selected',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableMock(403)
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(applicationRecord.Id)
        );

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Integration_Status__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Failed',
            updatedApplication.Integration_Status__c
        );

        System.assert(
            updatedApplication.Integration_Error__c.contains(
                'Authorization failure'
            )
        );
    }


    @IsTest
    static void testServerError() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Selected',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableMock(500)
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(applicationRecord.Id)
        );

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Integration_Status__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Retry Required',
            updatedApplication.Integration_Status__c
        );

        System.assert(
            updatedApplication.Integration_Error__c.contains(
                'Server error'
            )
        );
    }


    private class CandidateSyncQueueableMock
        implements HttpCalloutMock {

        private Integer statusCode;

        CandidateSyncQueueableMock(Integer statusCode) {
            this.statusCode = statusCode;
        }

        public HttpResponse respond(HttpRequest request) {

            System.assertEquals(
                'POST',
                request.getMethod()
            );

            System.assertEquals(
                'callout:Recruitment_API/candidates',
                request.getEndpoint()
            );

            System.assertEquals(
                'application/json',
                request.getHeader('Content-Type')
            );

            HttpResponse response = new HttpResponse();

            response.setStatusCode(statusCode);

            response.setHeader(
                'Content-Type',
                'application/json'
            );

            if (statusCode == 201) {

                response.setBody(
                    '{"success":true,"externalCandidateId":"EXT-10001","message":"Candidate successfully registered"}'
                );

            } else if (statusCode == 400) {

                response.setBody(
                    '{"success":false,"message":"Invalid candidate data"}'
                );

            } else if (statusCode == 401) {

                response.setBody(
                    '{"success":false,"message":"Authentication failed"}'
                );

            } else if (statusCode == 403) {

                response.setBody(
                    '{"success":false,"message":"Access forbidden"}'
                );

            } else if (statusCode == 500) {

                response.setBody(
                    '{"success":false,"message":"Internal server error"}'
                );
            }

            return response;
        }
    }
}