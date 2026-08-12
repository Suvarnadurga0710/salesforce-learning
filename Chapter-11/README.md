# Chapter 11 — Salesforce Candidate API Integration

## Overview

Chapter 11 demonstrates a Salesforce-to-external-API integration using asynchronous Queueable Apex.

The implementation synchronizes selected candidate applications from Salesforce with an external recruitment API. The project includes a custom Salesforce object, custom fields, an Apex trigger, Queueable Apex, HTTP callouts, Named Credentials, error handling, retry handling, mock API testing, and Lightning Web Components.

---

## Salesforce Components

### Custom Object

**Application__c**

### Custom Fields

| Field | Type | Purpose |
|---|---|---|
| Status__c | Picklist | Stores application status |
| Integration_Status__c | Picklist | Tracks integration status |
| External_Candidate_Id__c | Text | Stores external candidate ID |
| Integration_Error__c | Long Text Area | Stores integration errors |
| Last_Integration_Attempt__c | Date/Time | Stores the last integration attempt |

---

## Apex Classes

### CandidateSyncQueueable.cls

Handles asynchronous synchronization of selected applications with the external recruitment API.

### CandidateSyncQueueableTest.cls

Tests the Queueable Apex integration and HTTP callout response handling.

### ApplicationTriggerTest.cls

Tests the application trigger and verifies that integration processing starts when an application is selected.

---

## Apex Trigger

### ApplicationTrigger.trigger

The trigger starts the candidate synchronization process when an application reaches the required status.

Integration flow:

```text
Application__c
      |
      | Status = Selected
      v
ApplicationTrigger
      |
      v
CandidateSyncQueueable
      |
      v
HTTP Callout
      |
      v
Recruitment API