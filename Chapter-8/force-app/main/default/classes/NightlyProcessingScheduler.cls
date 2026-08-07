public class NightlyProcessingScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        System.debug('===== Scheduled Job Started =====');
        System.debug('Nightly processing is running...');
        System.debug('===== Scheduled Job Completed =====');

    }

}