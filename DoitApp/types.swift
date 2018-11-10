//
//  types.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/31/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import Foundation

struct UpcomingChore {
    let id: String
    let name: String
    let details: String
    let dueDate: String

    func dueDateToDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: dueDate) else {
            return Date()
        }
        return date
    }
}

enum FrequencyTypes: String {
    case DAYS = "days"
    case WEEKS = "weeks"
    case MONTHS = "months"
    case YEARS = "years"
}

struct ChoreDefinition {
    let id: String
    let name: String
    let details: String
    let frequencyAmount: Int
    let frequencyType: FrequencyTypes
}
