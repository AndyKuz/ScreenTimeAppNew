//
//  MessageModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation

struct Messages: Identifiable {
    var id = UUID()
    let from: String
    let text: String
    let createdAt: Date
}
