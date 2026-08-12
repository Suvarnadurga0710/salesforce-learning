trigger ApplicationTrigger on Application__c (after update) {

    for (Application__c applicationRecord : Trigger.new) {

        Application__c oldApplication =
            Trigger.oldMap.get(applicationRecord.Id);

        if (
            applicationRecord.Status__c == 'Selected' &&
            oldApplication.Status__c != 'Selected'
        ) {

            System.enqueueJob(
                new CandidateSyncQueueable(
                    applicationRecord.Id
                )
            );
        }
    }
}