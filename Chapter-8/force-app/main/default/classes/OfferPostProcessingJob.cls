public class OfferPostProcessingJob implements Queueable {

    private Id offerId;

    public OfferPostProcessingJob(Id offerId) {
        this.offerId = offerId;
    }

    public void execute(QueueableContext context) {
        System.debug('===== Queueable Job Started =====');
        System.debug('Offer Id: ' + offerId);
        System.debug('Offer processed successfully.');
        System.debug('===== Queueable Job Completed =====');
    }
}