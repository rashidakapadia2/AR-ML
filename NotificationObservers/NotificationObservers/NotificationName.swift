//
//  NotificationObservers.swift
//  NotificationObservers
//
//  Created by Apple on 21/11/22.
//

import Foundation

extension Notification.Name {
    static let incrementCount = Notification.Name("incrementCount")
}

enum NotificationString: String {
    case incrementCount = "incrementCount"
}
