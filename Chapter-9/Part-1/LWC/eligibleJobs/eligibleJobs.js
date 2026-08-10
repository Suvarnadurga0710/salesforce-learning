import { LightningElement } from 'lwc';

export default class EligibleJobs extends LightningElement {

    isLoading = false;

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
}