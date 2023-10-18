//
//  MembersViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/12/23.
//

import Foundation
import Firebase

extension FirestoreFunctions {
    // for a specified pod load all the users in said pod
    func loadPodUsers(podID: String, completion: @escaping ([User]) -> Void) {
        PODS_REF.document(podID).collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("loadPodUsers(): Error listening to user's pods: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var users:[User] = []
            
            for document in querySnapshot.documents {
                let data = document.data()
                let userID = document.documentID
                let username = data["username"] as! String
                let currentStreak = data["currentStreak"] as! Int
                let numStrikes = data["numStrikes"] as! Int
                
                users.append(User(username: username, userID: userID, currentStreak: currentStreak, numStrikes: numStrikes))
            }
            completion(users)
        }
    }
    
    // queries all CURRENT_USERs friends except those present in the pod
    func loadNonPodFriends(podID: String, completion: @escaping ([User]) -> Void) {
        var returnUsers: [User] = []
        
        // query for documents we plan to exclude
        PODS_REF.document(podID).collection("users").getDocuments { (excludeQuerySnapshot, excludeError) in
            if let excludeError = excludeError {
                print("loadNonPodFriends(): Error fetching Pod Users \(excludeError)")
                return
            }
            let excludeDocumentIDs = excludeQuerySnapshot!.documents.map { $0.documentID }
            
            // query for all documents in friends collection
            self.CURRENT_USER_FRIENDS_REF.getDocuments{ (friendsQuerySnapshot, friendsError) in
                if let friendsError = friendsError {
                    print("loadNonPodFriends(): Error fetching friends documents \(friendsError)")
                }
                
                // filter excluded docs from friends docs and return result
                returnUsers = friendsQuerySnapshot!.documents.filter { document in
                    let documentID = document.documentID
                    return !excludeDocumentIDs.contains(documentID)
                }.compactMap { document -> User? in
                    let docData = document.data()
                    let userID = document.documentID
                    let username = docData["username"] as? String
                    return User(username: username ?? "", userID: userID)
                }
                completion(returnUsers)
            }
        }
    }
    
    func loadSentPodRequests(podID: String, completion: @escaping ([User]) -> Void) {
        PODS_REF.document(podID).collection("sentInvites").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("loadSentPodRequests(): Error fetching document \(error)")
            }
            
            if let querySnapshot = querySnapshot {
                let users = querySnapshot.documents.compactMap { document -> User? in
                    let data = document.data()
                    let userID = document.documentID
                    let username = data["username"] as! String
                    return(User(username: username, userID: userID))
                }
                completion(users)
            } else {
                print("loadSentPodRequests(): Error querySnapshot is nil value")
            }
            
        }
    }
}
