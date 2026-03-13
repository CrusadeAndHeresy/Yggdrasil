---
name: yggdrasil-architecture
description: Core architectural constraints for the Yggdrasil tournament app.
active: always
---

# Yggdrasil Constitution

## 🏗️ Architecture: Single-Binary Event-Driven
- **No external backends:** All logic must reside within the local Swift binary.
- **Event-Sourcing:** The application state MUST be derived from an immutable stream of `EventCode` objects.
- **Persistence:** Every dispatched event must be appended to a local, immutable audit log (SQLite or JSON).

## 💻 Technical Standards
- **UI Framework:** SwiftUI exclusively. Use "Liquid Glass" (glassmorphism) aesthetics.
- **Concurrency:** Use modern Swift Concurrency (actors/async-await) for the Event Bus to ensure thread safety.
- **Formatting:** No force-unwrapping. Every exported function must include documentation comments explaining the "Why," not just the "What."

## 🛡️ GRC & Audit Compliance
- **Immutability:** Once an event is written, it is never deleted. 
- **Corrections:** Changes to data must be handled by firing a `manualCorrection` event that references the original event ID.