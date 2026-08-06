# Day 6 - SOQL and Apex Triggers

## What is SOQL?

SOQL (Salesforce Object Query Language) is used to retrieve data from Salesforce objects.

Examples:

* Find all students.
* Find all courses.
* Find students with low attendance.

---

## What is an Apex Trigger?

An Apex Trigger is code that runs automatically when records are created, updated, deleted, or restored.

Triggers help Salesforce react automatically to data changes.

---

## Flow vs Trigger

### Flow

* No-code automation.
* Easy to create and maintain.
* Best for simple business processes.

### Trigger

* Requires Apex coding.
* Used for complex business logic.
* More flexible than Flow.

---

## Before Trigger vs After Trigger

### Before Trigger

Runs before a record is saved.

Example:

* Validate student information before saving.

### After Trigger

Runs after a record is saved.

Example:

* Send a welcome email after student registration.

---

## Trigger Use Cases

### 1. Student Registration

Event: After a student record is created.

Action: Send welcome email.

### 2. Course Full

Event: After course seats reach maximum limit.

Action: Notify faculty.

### 3. Low Attendance

Event: After attendance is updated.

Action: Send warning notification.

### 4. Fee Payment Completed

Event: After fee status changes to Paid.

Action: Send payment confirmation.

### 5. New Faculty Added

Event: After faculty record is created.

Action: Send onboarding information.

---

## Query Examples

1. Find all students enrolled in Course A.

2. Find all courses handled by Faculty X.

3. Find students whose attendance is below 75%.

4. Find students who have not paid fees.

5. Find courses with available seats.

---

## Reflection

Enterprise systems need event-driven behavior because actions should happen automatically when data changes. This reduces manual work, improves accuracy, and helps users respond quickly to important events.

---

## Reflective Questions

### 1. Why do systems need triggers?

To automatically respond to changes in data.

### 2. Difference between polling and event-driven systems?

Polling checks repeatedly, while event-driven systems react when an event occurs.

### 3. Why are database queries important?

They help retrieve the required data quickly.

### 4. When should Flows be preferred over Triggers?

For simple automation that does not require complex coding.

### 5. What problems happen if automation logic becomes too complex?

It becomes difficult to maintain and troubleshoot.

### 6. Why should developers think carefully before automating actions?

To avoid unnecessary automation and system complexity.
