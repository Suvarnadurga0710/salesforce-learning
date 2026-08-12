# Candidate API Contract

## 1. Purpose

The Candidate API is used by the Salesforce Placement Management System to send selected candidates to an external recruitment platform.

For this project, a mock external API is used for demonstration.

## 2. Endpoint

POST /candidates

## 3. Request

### Headers

Content-Type: application/json

### Request Body

```json
{
  "studentId": "STU001",
  "name": "Harshitha",
  "email": "harshitha@example.com",
  "branch": "IT",
  "cgpa": 8.72,
  "jobId": "JOB001",
  "company": "ABC Technologies",
  "role": "Salesforce Developer",
  "selectionDate": "2026-08-11"
}
```

## 4. Candidate Data

| Field | Description |
|---|---|
| studentId | Student identifier |
| name | Student name |
| email | Student email |
| branch | Student branch |
| cgpa | Student CGPA |
| jobId | Job identifier |
| company | Company name |
| role | Selected job role |
| selectionDate | Selection date |

## 5. Success Response

HTTP 201 Created

```json
{
  "success": true,
  "externalCandidateId": "EXT-10001",
  "message": "Candidate successfully registered"
}
```

Salesforce updates:

- Integration Status = Sent
- External Candidate Id = returned external candidate ID

## 6. Error Responses

### 400 Bad Request

Invalid or incomplete candidate data.

Example response:

```json
{
  "success": false,
  "message": "Invalid candidate data"
}
```

Salesforce updates:

- Integration Status = Failed
- Integration Error = error details

### 401 Unauthorized

Authentication failure.

Example response:

```json
{
  "success": false,
  "message": "Authentication failed"
}
```

Salesforce updates:

- Integration Status = Failed
- Integration Error = authentication error

### 403 Forbidden

The authenticated client does not have permission.

Example response:

```json
{
  "success": false,
  "message": "Access forbidden"
}
```

Salesforce updates:

- Integration Status = Failed
- Integration Error = authorization error

### 500 Internal Server Error

The external system has a server-side failure.

Example response:

```json
{
  "success": false,
  "message": "Internal server error"
}
```

Salesforce updates:

- Integration Status = Retry Required
- Integration Error = server error details

### Unexpected Error

Unexpected HTTP responses or exceptions are captured in:

- Integration Status = Failed
- Integration Error = error details

## 7. Authentication

Salesforce uses a Named Credential for the external API configuration.

Credentials, access tokens, passwords, and secrets are not hard-coded in Apex.

## 8. Retry Strategy

If the external system is temporarily unavailable, the Application can be marked as:

Retry Required

A later retry can attempt the synchronization again.

## 9. Idempotency Strategy

The Salesforce Application Id is used as the unique business reference for the candidate submission.

The integration should prevent the same Application from creating duplicate candidate records in the external system.
## 10. Integration Flow

Application Status = Selected

        |
        v

Queueable Apex

        |
        v

Build Request

        |
        v

Named Credential

        |
        v

POST /candidates

        |
        v

External Recruitment API

        |
        v

Process Response

        |
        v

Update Application Integration Status