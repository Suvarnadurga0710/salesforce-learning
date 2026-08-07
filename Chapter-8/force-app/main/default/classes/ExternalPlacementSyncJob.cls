public class ExternalPlacementSyncJob implements Queueable {

    private Id offerId;

    public ExternalPlacementSyncJob(Id offerId){
        this.offerId = offerId;
    }

    public void execute(QueueableContext context){

        System.debug('===== External Sync Started =====');
        System.debug('Offer Id : '+offerId);

        // Simulate successful synchronization

        System.debug('Synchronization Successful');

        System.enqueueJob(
            new PlacementNotificationJob(offerId)
        );

    }
}