public class BatchDemo implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator('SELECT Id FROM Account');

    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {

        System.debug('Processing Records');

    }

    public void finish(Database.BatchableContext bc) {

        System.debug('Batch Completed');

    }

}