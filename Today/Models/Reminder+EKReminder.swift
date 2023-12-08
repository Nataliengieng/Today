//
//  Reminder+EKReminder.swift
//  Today
//
//  Created by nat on 08/12/2023.
//

import EventKit
import Foundation

extension Reminder {
    init(with ekReminder: EKReminder) throws {
        // a guard statement that binds the absolute date of a reminder’s first alarm
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
            throw TodayError.reminderHasNoDueDate
        }
        id = ekReminder.calendarItemIdentifier
        title = ekReminder.title
        self.dueDate = dueDate
        notes = ekReminder.notes
        isComplete = ekReminder.isCompleted
    }
}
