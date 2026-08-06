# Day 5 - Introduction to Apex

## What is Apex?

Apex is Salesforce's programming language. It is used when business requirements are too complex to be handled using clicks, configuration, or flows alone.

Apex helps developers create custom business logic and automate advanced processes.

---

## Flow vs Apex

| Flow                       | Apex                      |
| -------------------------- | ------------------------- |
| No-code tool               | Programming language      |
| Easy to build              | Requires coding knowledge |
| Best for simple automation | Best for complex logic    |
| Built using drag-and-drop  | Written in code           |

---

## Configuration vs Coding

### Configuration

Configuration means building solutions using Salesforce tools such as:

* Objects
* Fields
* Validation Rules
* Flows

### Coding

Coding means using Apex when the requirement cannot be completed using standard Salesforce features.

---

## Real Examples Where Apex Is Needed

### 1. Complex Fee Calculation

Different fee structures may depend on multiple conditions and calculations.

Why Apex?
Flow becomes difficult to manage for complex calculations.

### 2. External Payment Integration

Connecting Salesforce with an external payment gateway.

Why Apex?
Custom code is needed to communicate with external systems.

### 3. Advanced Eligibility Check

Checking student eligibility using attendance, marks, and other conditions.

Why Apex?
Multiple conditions require custom business logic.

---

## Integrated College Management System Design

### CRM

Manage student admissions and course enrollment.

### Objects

* Student
* Course
* Faculty

### Relationships

* Student → Course
* Faculty → Course

### Validation

* Email is required.
* Phone number must be valid.

### Flow

* Send registration confirmation email.
* Notify students about fee deadlines.

### Apex

* Calculate scholarship eligibility.
* Process advanced fee calculations.
* Integrate with external payment systems.

---

## Pseudocode Examples

### Example 1

IF seats are full

THEN block registration

### Example 2

IF attendance is less than 75%

THEN notify student

### Example 3

IF fee is not paid

THEN send reminder email

---

## Reflection

Enterprise systems cannot rely only on clicks and configuration because some business requirements are complex. Apex provides flexibility and allows developers to build custom solutions that meet specific business needs.

---

## Reflective Questions

### 1. Why is Apex needed if Salesforce already has Flows?

Flows handle simple automation, while Apex handles complex business logic.

### 2. When should developers prefer no-code solutions?

When the requirement can be completed using standard Salesforce tools.

### 3. What problems require custom programming?

Complex calculations, integrations, and advanced business rules.

### 4. Why is business logic important in enterprise systems?

It ensures processes follow company rules and requirements.

### 5. Why should developers avoid unnecessary coding?

No-code solutions are easier to maintain and update.

### 6. How does programming increase flexibility?

It allows developers to create custom functionality beyond standard features.
