//
//  ReminderStore.swift
//  Today
//
//  Created by nat on 08/12/2023.
//

import EventKit
import Foundation

// a final class's methods cannot be overrided or subclassed
final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
}
