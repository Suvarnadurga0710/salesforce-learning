public with sharing class ApplicationService {

    // Submit Application
    public static String submitApplication(Id studentId, Id jobId) {

        if (isDuplicate(studentId, jobId)) {
            return 'Application already exists.';
        }

        Student__c student = getStudent(studentId);

        if (student == null) {
            return 'Student not found.';
        }

        Job__c job = getJob(jobId);

        if (job == null) {
            return 'Job not found.';
        }

        if (job.Last_Date__c != null &&
            Date.today() > job.Last_Date__c) {

            return 'Application deadline has passed.';
        }

        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Student is not eligible.';
        }

        Application__c app = new Application__c(
            Student__c = studentId,
            Job__c = jobId,
            Application_Date__c = Date.today(),
            Status__c = 'Applied'
        );

        insert app;

        return 'Application submitted successfully.';
    }


    // Get Student
    public static Student__c getStudent(Id studentId) {

        List<Student__c> students = [
            SELECT Id, Name, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        return students.isEmpty() ? null : students[0];
    }


    // Get Job
    public static Job__c getJob(Id jobId) {

        List<Job__c> jobs = [
            SELECT Id, Name, Minimum_CGPA__c, Last_Date__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        return jobs.isEmpty() ? null : jobs[0];
    }


    // Duplicate Check
    public static Boolean isDuplicate(Id studentId, Id jobId) {

        Integer countApp = [
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        return countApp > 0;
    }
}