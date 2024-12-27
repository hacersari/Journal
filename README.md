# Journal App - CSE 340 Interaction Programming (Fall 2024)

## Overview

This project is a two-part assignment to develop a journaling app using Flutter. The app allows users to create, view, and edit journal entries, focusing on clean design, robust data handling, and accessibility.

- **Part 1:** Built a functional app without data persistence. Users could browse, create, and edit entries during a single session.
- **Part 2:** Introduced data persistence using the Isar database, enabling the app to save and retrieve journal entries between sessions.

---

## Features

- **Entry Management:** Create, view, and edit journal entries with unique IDs and timestamps for creation and updates.
- **Customizable Purpose:** The app can serve various journaling needs, such as daily logs, emotion tracking, workout logs, or more.
- **Interactive UI:** 
  - Home view for browsing and creating entries.
  - Detailed view for editing individual entries.
- **Data Persistence:** Utilizes the Isar NoSQL database to store and retrieve entries securely.
- **Accessibility:** Implements accessible design practices, including Semantics for screen readers.
- **Robust Design:** Safeguards against data loss and unauthorized access using dependency injection and robust coding practices.

---

## Technical Highlights

- **Data Models:** Custom `JournalEntry` class with unique IDs, timestamps, and a flexible structure for various journaling use cases.
- **Provider Integration:** Uses the Provider package to connect UI and data models efficiently.
- **Persistent Storage:** Employs Isar to manage a local database for storing journal entries.
- **Mock Data:** Developed mock data for testing and iterative UI design during early development stages.
- **Scalable UI:** Implemented `ListView.builder` for smooth scrolling and efficient rendering of entries.

---

## Reflection

- **Challenges:** Managing state across views, implementing data persistence, and ensuring accessibility.
- **Learning Outcomes:** Gained experience with Flutter, Provider, Isar database, and accessibility design principles.
- **Future Goals:** Explore advanced Flutter features and experiment with additional database solutions for more complex apps.


---

This project demonstrates proficiency in Flutter development, UI/UX design, and persistent storage integration. It serves as a foundation for building more complex, user-friendly applications.
