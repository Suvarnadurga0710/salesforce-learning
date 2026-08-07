public class SchedulerDemo implements Schedulable {

    public void execute(SchedulableContext sc){

        System.debug('Scheduled Job Executed');

    }

}