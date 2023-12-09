# Today App

This app is developed based on the [Apple Developer Tutorials - UIKit essentials](https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view).


## Troubleshooting
### Problem 1
Becasue the tutorial is based on iOS 16, in section "Loading reminders", the function `requestAccess(to:completion:)` is deprecated in iOS17. So that errors will occur when using the code from the tutorial

### Solution to Problem 1
Replacing below codes
```
var isAvailable: Bool {
    EKEventStore.authorizationStatus(for: .reminder) == .authorized
}

func requestAccess() async throws {
    ...
    case .notDetermined:
        let accessGranted = try await ekStore.requestAccess(to: .reminder)
        guard accessGranted else {
            throw TodayError.accessDenied
        }
    ...
}
```
To...
```
var isAvailable: Bool {
    EKEventStore.authorizationStatus(for: .reminder) == .fullAccess
}

func requestAccess() async throws {
    ...
    case .notDetermined:
        let accessGranted = try await ekStore.requestFullAccessToReminders()
        guard accessGranted else {
            throw TodayError.accessDenied
        }
    ...
}
```
