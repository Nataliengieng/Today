//
//  TodayError.swift
//  Today
//
//  Created by nat on 08/12/2023.
//

import Foundation

enum TodayError: LocalizedError {
    
    case failedReadingReminders
    case reminderHasNoDueDate
    
    //  the default implementation of the errorDescription property that returns a non-specific message which allows users to have a clear information about why the error occur
    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString(
                "Failed to read reminders.", comment: "failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString(
                "A reminder has no due date.", comment: "reminder has no due date error description")
                
        }
    }
}
