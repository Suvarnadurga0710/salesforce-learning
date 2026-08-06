# Chapter 7 - Bulk Processing and Governor Limits

## Topics Covered

- Governor Limits
- Bulkification
- Trigger.new
- Trigger.old
- Trigger.newMap
- Trigger.oldMap
- Lists
- Sets
- Maps
- Bulk SOQL
- Bulk DML
- Trigger Handler Pattern
- Service Layer Pattern

## Project Structure

ApplicationTrigger

↓

ApplicationTriggerHandler

↓

ApplicationService

## Key Learnings

- Never use SOQL inside loops.
- Never use DML inside loops.
- Use Sets to collect IDs.
- Use Maps for quick lookup.
- Query once and process many records.
- Keep Triggers thin by delegating business logic to Handler and Service classes.