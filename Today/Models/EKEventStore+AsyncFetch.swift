//
//  EKEventStore+AsyncFetch.swift
//  Today
//
//  Created by nat on 08/12/2023.
//

import EventKit
import Foundation

extension EKEventStore {
    //  async means that this function can execute asynchronously
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        //  "await" indicates that the task suspends until the continuation resumes
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: TodayError.failedReadingReminders)
                }
            }
        }
    }
}
