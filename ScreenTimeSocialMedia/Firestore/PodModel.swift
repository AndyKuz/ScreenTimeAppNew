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
    let goal: Int!
    let timeframe: Double!
    let started: Bool!  // depending if the user has started the Pod
    let failedDays: [Int]!
    let currentDay: Int
    let inviter: String?    // used for displaying pod invites
    
    init(podID: String,
         title: String,
         podType: groupType,
         totalStrikes: Int,
         currentStrikes: Int,
         goal: Int,
         timeframe: Double,
         started: Bool,
         failedDays: [Int],
         currentDay: Int,
         inviter: String? = ""
    ) {
        self.podID = podID
        self.title = title
        self.podType = podType
        self.totalStrikes = totalStrikes
        self.currentStrikes = currentStrikes
        self.goal = goal
        self.timeframe = timeframe
        self.started = started
        self.failedDays = failedDays
        self.currentDay = currentDay
        self.inviter = inviter
    }
}
