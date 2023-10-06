//
//  HomeViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation

extension FirestoreFunctions {
    func loadPods(completion: @escaping ([Pods]) -> Void) {
        // Fetch list of PodIds from current user
        CURRENT_USER_REF.getDocument { document, error in
            if let error = error {
                print("loadPods(): Error fetching user data: \(error)")
                completion([])
                return
            }
            
            guard let userData = document?.data(),
                  let podIDs = userData["podIDs"] as? [String] else {
                print("loadPods(): No user data or podIDs found.")
                completion([])
                return
            }
            
            var podsList: [Pods] = []
            
            // Setup listeners for every podID
            for PodID in podIDs {
                self.PODS_REF.document(PodID)
                    .addSnapshotListener { querySnapshot, error in
                        if let error = error {
                            print("loadPods(): Error fetching pod data: \(error)")
                            return
                        }
                        
                        guard querySnapshot?.exists == true else {
                            print("loadPods(): Pod document does not exist.")
                            return
                        }
                        
                        if let querySnapshot = querySnapshot, let data = querySnapshot.data() {
                            let title = data["title"] as? String
                            let podTypeRawVal = data["podType"] as? String
                            let podType = groupType(rawValue: podTypeRawVal ?? "Screen Time")
                            let totalStrikes = data["totalStrikes"] as? Int
                            let timeframe = data["timeframe"] as? Double
                            let pod = Pods(podID: PodID, title: title!, podType: podType!, totalStrikes: totalStrikes!, timeframe: timeframe!)
                            podsList.append(pod)
                            completion(podsList)
                        }
                    }
            }
        }
    }
}
