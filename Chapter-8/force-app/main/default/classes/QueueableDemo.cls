public class QueueableDemo implements Queueable {

    public void execute(QueueableContext context){

        System.debug('Queueable Job Executed');

    }

}