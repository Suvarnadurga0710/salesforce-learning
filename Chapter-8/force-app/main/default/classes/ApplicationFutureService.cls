public class ApplicationFutureService {

    @future(callout=true)
    public static void sendApplicationToExternalSystem(Id applicationId) {

        System.debug('===== Future Method Started =====');
        System.debug('Application Id: ' + applicationId);

        // Simulated external system processing

        System.debug('Application sent successfully.');
        System.debug('===== Future Method Completed =====');
    }
}