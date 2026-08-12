@IsTest
private class ApplicationTriggerTest {

    @IsTest
    static void testApplicationSelectionStartsIntegration() {

        Application__c applicationRecord = new Application__c(
            Status__c = 'Applied',
            Integration_Status__c = 'Pending'
        );

        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new CandidateSyncQueueableTestMock()
        );

        Test.startTest();

        applicationRecord.Status__c = 'Selected';
        update applicationRecord;

        Test.stopTest();

        Application__c updatedApplication = [
            SELECT Status__c,
                   Integration_Status__c,
                   External_Candidate_Id__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Selected',
            updatedApplication.Status__c
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


    private class CandidateSyncQueueableTestMock
        implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest request) {

            System.assertEquals(
                'POST',
                request.getMethod()
            );

            System.assertEquals(
                'callout:Recruitment_API/candidates',
                request.getEndpoint()
            );

            HttpResponse response = new HttpResponse();

            response.setStatusCode(201);

            response.setHeader(
                'Content-Type',
                'application/json'
            );

            response.setBody(
                '{"success":true,"externalCandidateId":"EXT-10001","message":"Candidate successfully registered"}'
            );

            return response;
        }
    }
}