//
//  TodayError.swift
//  Today
//
//  Created by nat on 08/12/2023.
//

import Foundation

enum TodayError: LocalizedError {
    
    case accessDenied
    case accessRestricted
    case failedReadingCalendarItem
    case failedReadingReminders
    case reminderHasNoDueDate
    case unknown
    
    //  the default implementation of the errorDescription property that returns a non-specific message which allows users to have a clear information about why the error occur
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString(
                "The app doesn't have permission to read reminders.",
                comment: "access denied error description")
        case .accessRestricted:
            return NSLocalizedString(
                "This device doesn't allow access to reminders.",
                comment: "access restricted error description")
        case .failedReadingCalendarItem:
            return NSLocalizedString(
                "Failed to read a calendar item.",
                comment: "failed reading calendar item error description")
        case .failedReadingReminders:
            return NSLocalizedString(
                "Failed to read reminders.", 
                comment: "failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString(
                "A reminder has no due date.", 
                comment: "reminder has no due date error description")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", 
                comment: "unknown error description")
        }
    }
}
