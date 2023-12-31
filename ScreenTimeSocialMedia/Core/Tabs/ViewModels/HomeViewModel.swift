//
//  HomeViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation
import FirebaseFirestore

extension FirestoreFunctions {
    // function to manually update user's pods
    // called on deletion of documents
    func queryPods(completion: @escaping ([Pods]) -> Void) {
        // Get documents in the user's pods collection.
        CURRENT_USER_PODS_REF.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("queryPods(): Error fetching user pod's documents: \(error.localizedDescription)")
                completion([]) // Return an empty array in case of an error.
                return
            }

            var userPods: [Pods] = []

            if let querySnapshot = querySnapshot {
                if querySnapshot.isEmpty {
                    // The collection is empty, return an empty array.
                    completion([])
                } else {
                    for document in querySnapshot.documents {
                        let podID = document.documentID

                        // Get document for the associated pod ID.
                        self.PODS_REF.document(podID).getDocument { (podDocument, podError) in
                            if let podError = podError {
                                print("queryPods(): Error fetching pod document: \(podError)")
                                return
                            }

                            if let data = podDocument?.data(),
                               let title = data["title"] as? String,
                               let podType = groupType(rawValue: (data["podType"] as? String) ?? "Screen Time"),
                               let currentStrikes = data["currentStrikes"] as? Int,
                               let totalStrikes = data["totalStrikes"] as? Int,
                               let goal = data["goal"] as? Int,
                               let timeframe = data["timeframe"] as? Double,
                               let started = data["started"] as? Bool,
                               let failedDays = data["failedDays"] as? [Int],
                               let currentDay = data["currentDay"] as? Int {
                                let pod = Pods(podID: podID, title: title, podType: podType, totalStrikes: totalStrikes, currentStrikes: currentStrikes, goal: goal, timeframe: timeframe, started: started, failedDays: failedDays, currentDay: currentDay)
                                userPods.append(pod)
                            }

                            // Call the completion handler with the updated user pods
                            completion(userPods)
                        }
                    }
                }
            }
        }
    }
    
    // function to manually update user's pods requests
    // called on deletion of documents
    func queryPodsRequests(completion: @escaping ([Pods]) -> Void) {
        // Get documents in the user's pods collection.
        CURRENT_USER_RECEIVED_PODS_REQUEST_REF.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("queryPodsRequests(): Error fetching user pods request's documents: \(error.localizedDescription)")
                completion([]) // Return an empty array in case of an error.
                return
            }

            var userPods: [Pods] = []

            if let querySnapshot = querySnapshot {
                if querySnapshot.isEmpty {
                    // The collection is empty, return an empty array.
                    completion([])
                } else {
                    for document in querySnapshot.documents {
                        let podID = document.documentID
                        let inviter = document.data()["invitedBy"] as? String

                        // Get document for the associated pod ID.
                        self.PODS_REF.document(podID).getDocument { (podDocument, podError) in
                            if let podError = podError {
                                print("queryPodsRequetss(): Error fetching pod document: \(podError)")
                                return
                            }

                            if let data = podDocument?.data(),
                               let title = data["title"] as? String,
                               let podType = groupType(rawValue: (data["podType"] as? String) ?? "Screen Time"),
                               let currentStrikes = data["currentStrikes"] as? Int,
                               let totalStrikes = data["totalStrikes"] as? Int,
                               let goal = data["goal"] as? Int,
                               let timeframe = data["timeframe"] as? Double,
                               let started = data["started"] as? Bool,
                               let failedDays = data["failedDays"] as? [Int],
                               let currentDay = data["currentDay"] as? Int {
                                let pod = Pods(podID: podID, title: title, podType: podType, totalStrikes: totalStrikes, currentStrikes: currentStrikes, goal: goal, timeframe: timeframe, started: started, failedDays: failedDays, currentDay: currentDay, inviter: inviter)
                                userPods.append(pod)
                            }
                            // Call the completion handler with the updated user pods
                            completion(userPods)
                        }
                    }
                }
            }
        }
    }
    
    
    func loadPodRequests(completion: @escaping ([Pods]) -> Void) {
        // Create an array to store the pod listeners.
        var podListeners: [ListenerRegistration] = []
        var userPods: [Pods] = []
        
        // Listen to changes in the user's pods
        CURRENT_USER_RECEIVED_PODS_REQUEST_REF.addSnapshotListener { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("loadPodRequests(): Error listening to user's pods: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Clear the previous pod listeners.
            for listener in podListeners {
                listener.remove()
            }
            
            podListeners.removeAll()
            userPods.removeAll()
            
            for document in querySnapshot.documents {
                let podID = document.documentID
                let data = document.data()
                let inviter = data["invitedBy"] as! String
                
                // Create a reference to the pod document.
                let podRef = self.PODS_REF.document(podID)
                
                // Listen to changes in the pod data.
                let listener = podRef.addSnapshotListener { (podDocument, podError) in
                    if let podError = podError {
                        print("loadPodRequests(): Error listening to group data: \(podError)")
                        return
                    }
                    
                    if let data = podDocument?.data(),
                       let title = data["title"] as? String,
                       let podType = groupType(rawValue: (data["podType"] as? String) ?? "Screen Time"),
                       let currentStrikes = data["currentStrikes"] as? Int,
                       let totalStrikes = data["totalStrikes"] as? Int,
                       let goal = data["goal"] as? Int,
                       let timeframe = data["timeframe"] as? Double,
                       let started = data["started"] as? Bool,
                       let failedDays = data["failedDays"] as? [Int],
                       let currentDay = data["currentDay"] as? Int {
                        let pod = Pods(podID: podID, title: title, podType: podType, totalStrikes: totalStrikes, currentStrikes: currentStrikes, goal: goal, timeframe: timeframe, started: started, failedDays: failedDays, currentDay: currentDay, inviter: inviter)
                        userPods.append(pod)
                    }
                    
                    // Call the completion handler with the updated user pods.
                    completion(userPods)
                }
                
                podListeners.append(listener)
            }
        }
    }

}
