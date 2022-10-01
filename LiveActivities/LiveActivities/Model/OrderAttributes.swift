//
//  OrderAttributes.swift
//  LiveActivities
//
//  Created by Mishana on 29.09.2022.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable{
        var status: Status = .received
    }
    
    var orderNumber: Int
    var orderItems: String
}

enum Status: String, CaseIterable, Codable, Equatable {
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
