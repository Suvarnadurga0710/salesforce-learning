public class HistoricalApplicationBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        System.debug('Batch size: ' + scope.size());
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch completed');
    }
}