# 💍 Wedding Planning System – Guest & Gehaz Modules

This project is part of a Software Engineering course and implements two core modules of a Wedding Planning System using **JavaFX** and **Microsoft SQL Server**.

The system follows a layered architecture design and applies object-oriented principles with database persistence.

---

## 🎓 Academic Context

Developed as part of a Software Engineering course using:

- Use-Case Driven Development
- CRC Cards
- Communication Diagrams
- Sequence Diagrams
- Design Class Diagram (DCD)
- Layered Architecture

Only two required use cases were fully implemented as part of the project scope.

---

## 🏗 Architecture

The implementation follows a clear multi-layer structure:

### 🔹 Boundary Layer (JavaFX UI)
- `GuestListUI`
- `RSVPFormUI`
- `AddGehazItemUI`
- `GehazListUI`
- Styled using JavaFX CSS

Handles all user interaction and UI rendering.

### 🔹 Controller Layer
- `GuestListController`
- `GehazItemController`

Responsible for business logic and coordinating between UI and database.

### 🔹 Infrastructure Layer (Database Access)
- `DBConnection`
- `GuestDB`
- `GehazItemAccessor`

Handles SQL queries and communication with Microsoft SQL Server.

### 🔹 Entity Layer
- `Guest`
- `GehazItem`
- `GehazCategory`
- `GehazStatus`
- Supporting data classes

Represents domain models used across the application.

---

## 🚀 Implemented Features

### 👥 Guest List Management
- Add Guest
- Update Guest
- Remove Guest
- RSVP tracking
- View guest list in table format
- Real-time database updates

### 🧳 Gehaz Item Management
- Add Gehaz Item
- Update Item Status
- Remove Item
- Categorize Items
- Summary view of Gehaz items
- Full CRUD functionality

---

## 🔌 Database Integration

The application is fully connected to **Microsoft SQL Server (via SQL Server Management System – SSMS).**

All operations are persisted in the database:

- Create (INSERT)
- Read (SELECT)
- Update (UPDATE)
- Delete (DELETE)

Any guest or Gehaz item added, modified, or removed through the UI is immediately reflected in the database, ensuring:

- Data persistence
- Data consistency
- Reliable state management

---

## 🖥 Technologies Used

- Java
- JavaFX (UI Framework)
- Microsoft SQL Server (SSMS)
- JDBC
- Object-Oriented Design
- Layered Architecture
- UML Modeling

---

## 📂 Scope Clarification

The UI structure reflects the complete system design as defined in the Design Class Diagram (DCD).  
However, only the required features (Guest List and Gehaz Item modules) were fully implemented according to the project requirements.

---

## 🎯 Key Learning Outcomes

- Applying layered architecture in real systems
- JavaFX UI development and styling
- Database connectivity using JDBC
- Implementing CRUD operations with SQL Server
- Translating UML diagrams into functional code
- Maintaining separation of concerns between layers

---

## 👨‍💻 Contribution

Designed and implemented the JavaFX UI layer and integrated the Guest List and Gehaz Item modules with Microsoft SQL Server, ensuring complete CRUD functionality and database synchronization.


## 🗄 Database Setup

The database scripts are available inside the `database/` folder:

- `Ayza_AtgawezDDL.sql` → Creates tables and schema
- `Ayza_AtgawezInsertions.sql` → Inserts sample data
- `Ayza_AtgawezQueries.sql` → Example system queries

To run the project:

1. Create a database in Microsoft SQL Server.
2. Execute the DDL script.
3. Execute the Insertions script.
4. Update the connection string in `DBConnection.java`.
5. Run the application.
