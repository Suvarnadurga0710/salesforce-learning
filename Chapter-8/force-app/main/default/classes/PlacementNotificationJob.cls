public class PlacementNotificationJob implements Queueable {

    private Id offerId;

    public PlacementNotificationJob(Id offerId){
        this.offerId = offerId;
    }

    public void execute(QueueableContext context){

        System.debug('===== Notification Job =====');
        System.debug('Preparing notification for Offer : '+offerId);

    }
}