# Hotel Management System

A web-based Hotel Management System (HMS) designed to simplify and automate hotel operations for guests, staff, and administrators.

The system provides an integrated platform for managing room reservations, payments, invoices, room statuses, hotel services, staff operations, and customer feedback. It is designed as a practical example of a multi-entity relational database system with structured workflows and role-based access.

## Project Objective

The objective of this project is to design and implement a smart and organized hotel management platform that improves operational efficiency, reduces manual errors, and supports better decision-making through centralized data management and reporting.

## Core Features

- Guest account and reservation management
- Room browsing and filtering by:
  - room type
  - capacity
  - date range
  - price
- Reservation registration and confirmation
- Online and offline payment tracking
- Automatic invoice generation
- Additional service request handling
- Real-time room status management
- Staff information and access control management
- Customer feedback and rating registration
- Administrative reporting and analytics

## User Roles

### Admin / Manager
Full system access, including:
- hotel information management
- room and room type management
- reservation monitoring and control
- payment and invoice review
- staff management
- service management
- customer feedback analysis
- managerial reports

### Staff
Access depends on role:
- Reception: reservation and guest handling
- Cashier: payment and invoice processing
- Cleaning Supervisor: room status updates
- Service Staff: service request execution

### Customer / Guest
Limited access to personal operations:
- browse available rooms
- make reservations
- complete payments
- view invoices
- request services
- submit feedback

## Main Entities

The system is built around the following core entities:

- Hotel
- Customer
- Room
- Room Type
- Reservation
- Payment
- Invoice
- Service
- Staff
- Feedback

## Entity Relationships

- One hotel has many rooms
- One hotel has many staff members
- One customer can have many reservations
- One reservation belongs to one customer
- One reservation belongs to one room
- One reservation can have multiple payments
- One reservation generates one invoice
- One staff member can provide multiple services
- One reservation can have associated feedback

## Workflow Overview

1. The guest logs into the system.
2. The guest searches for available rooms using filters.
3. A reservation is created with a pending confirmation status.
4. The guest proceeds to payment.
5. After successful payment, the reservation status becomes confirmed.
6. The system generates an invoice.
7. During the stay, the guest can request additional services.
8. Staff process operational tasks through the management panel.
9. At checkout, the final settlement is completed.
10. The guest can submit feedback and ratings.

## Sample Reports

The system can generate reports such as:

- Active and upcoming reservations
- Currently resident guests
- Occupied, vacant, and out-of-service rooms
- Guests with luxury or suite reservations
- Daily, weekly, and monthly revenue reports
- Employee and staff role lists
- Guest service request reports
- Customer feedback analysis
- Unsettled invoices
- Complete stay history of a specific guest

## Database Design Scope

This project is also intended as a relational database design example and demonstrates:

- One-to-Many relationships
- Many-to-Many relationships through intermediary structures
- logical and physical database design
- reduction of data redundancy
- improved data consistency
- support for reporting and analytics

## Suggested Technology Stack

Replace this section with your actual implementation stack.

- Frontend: HTML, CSS, JavaScript
- Backend: PHP / Node.js / Python / ASP.NET
- Database: MySQL / PostgreSQL / SQL Server

## Project Structure
```bash
hotel-management-system/
├── docs/
├── database/
├── backend/
├── frontend/
├── reports/
└── README.md
