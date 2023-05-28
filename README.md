# Bharath Mobile Assessment

This project is for the Flutter skillset evaluation.

## Getting Started

Application contains a screen with 2 tabs.

1. [Flash Card]: This screen will have an option to tap and view the answer for the question.
2. [Multiple Choice Question]: This screen will show a random multiple choice question. Once the user taps on the answer, Correct answet would be highlighted with green color.

## Implementaion & Frameworks

- Home Screen with the two tabs, one for each type (i.e., Flash Card & MCQ)
- Dio framework to invoke the API calls(which also provides additional features like SSL Pinning, Request interceptors) etc.,
- BLoC, state management library used to manage the states based on the user actions.
- GetIt is a service location framework used as a dependency to locate various components like BloCs, Repositories etc.,
- Ability to support Light & Dark Mode
