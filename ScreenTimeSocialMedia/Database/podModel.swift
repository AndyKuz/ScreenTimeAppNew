//
//  podModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/30/23.
//

import Foundation

struct Pods {
    let podID: String!
    let title: String!
    let descrtiption: String!
    let podType: String!
    let strikes: Int!
    let timeframe: Double!
    
    init(podID: String, title: String, description: String, podType: String, strikes: Int, timeframe: Double) {
        self.podID = podID
        self.title = title
        self.descrtiption = description
        self.podType = podType
        self.strikes = strikes
        self.timeframe = timeframe
    }
}
