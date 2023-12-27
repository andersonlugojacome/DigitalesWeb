//
//  Item.swift
//  DigitalesWeb
//
//  Created by Anderson Lugo Jacome on 27/12/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
