//
//  FriendsViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/27/23.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

extension FriendsSystem {
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
}

