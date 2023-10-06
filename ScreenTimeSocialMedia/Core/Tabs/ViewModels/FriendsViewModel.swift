//
//  FriendsViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/27/23.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

extension FirestoreFunctions {
    // MARK: - User Search Functions

    // functionality to load search bar results
    func searchUsers(query: String, completion: @escaping ([User]) -> Void) {
        USER_REF
            .whereField("username", isGreaterThanOrEqualTo: query) // usernames that match or come after (lexicographically) query
            .whereField("username", isLessThanOrEqualTo: query + "\u{f8ff}") // usernames that start with query
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error searching users: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No search results.")
                    completion([])
                    return
                }
                
                let users = documents.compactMap { document -> User? in
                    let data = document.data()
                    let uid = document.documentID
                    let username = data["username"] as? String
                    return User(username: username ?? "", userID: uid)
                }
                
                completion(users)
            }
    }
    
    
    func loadRecievedFriendRequests(completion: @escaping ([User]) -> Void) {
        // adds a listener to the friend request collection of the current user
        CURRENT_USER_RECEIVED_REQUESTS_REF
            .addSnapshotListener { querySnapshot, error in
                guard let _ = querySnapshot?.documents else {
                    print("loadUserData(): Error fetching documents: \(error!)")
                    return
                }
                if let querySnapshot = querySnapshot {
                    let users = querySnapshot.documents.compactMap { document -> User? in
                        let data = document.data()
                        let uid = document.documentID
                        let username = data["username"] as? String
                        return (User(username: username ?? "", userID: uid))
                    }
                    // creates a list of type User encompassing all friend requests
                    completion(users)
                }
            }
    }
    
    func loadSentFriendRequests(completion: @escaping ([User]) -> Void) {
        CURRENT_USER_SENT_REQUESTS_REF
            .addSnapshotListener { querySnapshot, error in
                guard let _ = querySnapshot?.documents else {
                    print("loadFriends(): Error fetching documents: \(error!)")
                    return
                }
                if let querySnapshot = querySnapshot {
                    let users = querySnapshot.documents.compactMap { document -> User? in
                        let data = document.data()
                        let uid = document.documentID
                        let username = data["username"] as? String
                        return (User(username: username ?? "", userID: uid))
                    }
                    // creates a list of type User encompassing all friends
                    completion(users)
                }
            }
    }
    
    func loadFriends(completion: @escaping ([User]) -> Void) {
        CURRENT_USER_FRIENDS_REF
            .addSnapshotListener { querySnapshot, error in
                guard let _ = querySnapshot?.documents else {
                    print("loadFriends(): Error fetching documents: \(error!)")
                    return
                }
                if let querySnapshot = querySnapshot {
                    let users = querySnapshot.documents.compactMap { document -> User? in
                        let data = document.data()
                        let uid = document.documentID
                        let username = data["username"] as? String
                        return (User(username: username ?? "", userID: uid))
                    }
                    // creates a list of type User encompassing all friends
                    completion(users)
                }
            }
    }
}

