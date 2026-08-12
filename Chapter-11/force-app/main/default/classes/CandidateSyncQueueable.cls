public class CandidateSyncQueueable implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c applicationRecord = [
            SELECT Id,
                   Name,
                   Status__c,
                   External_Candidate_Id__c,
                   Integration_Status__c,
                   Integration_Error__c,
                   Last_Integration_Attempt__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        HttpRequest request = new HttpRequest();

        request.setEndpoint('callout:Recruitment_API/candidates');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');

        Map<String, Object> candidateData =
            new Map<String, Object>();

        candidateData.put(
            'applicationId',
            applicationRecord.Id
        );

        candidateData.put(
            'applicationNumber',
            applicationRecord.Name
        );

        request.setBody(
            JSON.serialize(candidateData)
        );

        Http http = new Http();
        HttpResponse response;

        String integrationStatus = 'Failed';
        String integrationError = null;
        String externalCandidateId = null;

        try {

            response = http.send(request);

            Integer statusCode = response.getStatusCode();

            if (statusCode == 201) {

                Map<String, Object> responseData =
                    (Map<String, Object>) JSON.deserializeUntyped(
                        response.getBody()
                    );

                integrationStatus = 'Sent';

                if (responseData.containsKey(
                    'externalCandidateId'
                )) {

                    externalCandidateId =
                        String.valueOf(
                            responseData.get(
                                'externalCandidateId'
                            )
                        );
                }

            } else if (statusCode == 400) {

                integrationStatus = 'Failed';

                integrationError =
                    'Bad Request: ' +
                    response.getBody();

            } else if (statusCode == 401) {

                integrationStatus = 'Failed';

                integrationError =
                    'Authentication failure: ' +
                    response.getBody();

            } else if (statusCode == 403) {

                integrationStatus = 'Failed';

                integrationError =
                    'Authorization failure: ' +
                    response.getBody();

            } else if (
                statusCode >= 500 &&
                statusCode <= 599
            ) {

                integrationStatus = 'Retry Required';

                integrationError =
                    'Server error: ' +
                    response.getBody();

            } else {

                integrationStatus = 'Failed';

                integrationError =
                    'Unexpected HTTP response ' +
                    statusCode +
                    ': ' +
                    response.getBody();
            }

        } catch (Exception e) {

            integrationStatus = 'Failed';

            integrationError = e.getMessage();
        }

        /*
         * Perform DML only AFTER the callout has completed.
         */
        applicationRecord.Integration_Status__c =
            integrationStatus;

        applicationRecord.Integration_Error__c =
            integrationError;

        applicationRecord.Last_Integration_Attempt__c =
            System.now();

        if (externalCandidateId != null) {

            applicationRecord.External_Candidate_Id__c =
                externalCandidateId;
        }

        update applicationRecord;
    }
}