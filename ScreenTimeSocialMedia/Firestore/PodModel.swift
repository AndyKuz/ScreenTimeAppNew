//
//  podModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/30/23.
//

import Foundation

// enum containing different pod types
// TODO - add water and gym types
enum groupType: String, CaseIterable, Codable {
    case screenTime = "Screen Time"
}

struct Pods {
    let podID: String!
    let title: String!
    let podType: groupType!
    let totalStrikes: Int!
    let currentStrikes: Int!
    let timeframe: Double!
    let inviter: String?    // used for formatting pod requests
    
    init(podID: String, title: String, podType: groupType, totalStrikes: Int, currentStrikes: Int, timeframe: Double, inviter: String? = "") {
        self.podID = podID
        self.title = title
        self.podType = podType
        self.totalStrikes = totalStrikes
        self.currentStrikes = currentStrikes
        self.timeframe = timeframe
        self.inviter = inviter
    }
}
