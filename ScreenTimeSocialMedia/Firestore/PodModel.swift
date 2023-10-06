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
    let timeframe: Double!
    
    init(podID: String, title: String, podType: groupType, totalStrikes: Int, timeframe: Double) {
        self.podID = podID
        self.title = title
        self.podType = podType
        self.totalStrikes = totalStrikes
        self.timeframe = timeframe
    }
}
