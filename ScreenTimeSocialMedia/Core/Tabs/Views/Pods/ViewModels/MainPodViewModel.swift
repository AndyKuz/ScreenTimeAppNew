//
//  MainPodViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/12/23.
//

import Foundation

extension FirestoreFunctions {
    func startPod(podID: String) {
        PODS_REF.document(podID).updateData([
            "started": true
        ])
    }
    
    func thresholdReached(podID: String, userID: String) {
        
    }
}
