import { LightningElement } from 'lwc';
import submitApplication from '@salesforce/apex/ApplicationController.submitApplication';

export default class EligibleJobs extends LightningElement {

    isLoading = false;
    isSubmitting = false;

    jobs = [
        {
            id: '1',
            company: 'Microsoft',
            role: 'Software Engineer',
            package: '12 LPA',
            location: 'Hyderabad',
            deadline: '18 August 2026'
        },
        {
            id: '2',
            company: 'Salesforce Partner',
            role: 'Associate Developer',
            package: '7 LPA',
            location: 'Bengaluru',
            deadline: '21 August 2026'
        },
        {
            id: '3',
            company: 'Infosys',
            role: 'Systems Engineer',
            package: '6.5 LPA',
            location: 'Pune',
            deadline: '25 August 2026'
        }
    ];

    get hasJobs() {
        return this.jobs.length > 0;
    }

    handleViewDetails(event) {

        const jobId = event.currentTarget.dataset.id;

        const selectedJob = this.jobs.find(
            job => job.id === jobId
        );

        alert(
            'Company: ' + selectedJob.company +
            '\nRole: ' + selectedJob.role +
            '\nPackage: ' + selectedJob.package +
            '\nLocation: ' + selectedJob.location +
            '\nDeadline: ' + selectedJob.deadline
        );
    }

    async handleApply(event) {

        if (this.isSubmitting) {
            return;
        }

        const jobId = event.currentTarget.dataset.id;

        this.isSubmitting = true;

        try {

            const result = await submitApplication({
                studentId: null,
                jobId: jobId
            });

            alert(result);

        } catch (error) {

            console.error('Application Error:', error);

            alert(
                'Application could not be submitted. Please try again.'
            );

        } finally {

            this.isSubmitting = false;
        }
    }
}