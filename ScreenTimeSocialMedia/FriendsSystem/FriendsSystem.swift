//
//  FireBaseFunctions.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/25/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// struct that compactly formats necessary user data
struct User {
    var username: String!
    var uid: String!
    
    init(username: String, userID: String) {
        self.username = username
        self.uid = userID
    }
}

struct FireBaseFunctions {

    func signUpFireBase(username:String, email:String, uid:String) {
        Firestore.firestore().collection("users").document(uid).setData([
            "username": username,
            "email": email
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

class FriendsSystem {
    static let system = FriendsSystem()
    
    // Base reference for database
    let BASE_REF = Firestore.firestore()
    
    // Base reference for users
    let USER_REF = Firestore.firestore().collection("users")
    
    // Gets reference to document for currentUser
    var CURRENT_USER_REF: DocumentReference {
        let id = Auth.auth().currentUser!.uid
        return USER_REF.document("\(id)")
    }
    
    var CURRENT_USER_FRIENDS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("friends")
    }
    
    var CURRENT_USER_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("requests")
    }
    
    var CURRENT_USER_UID: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    // FRIEND REQUEST SYSTEM FUNCTIONS
    
    func sendFriendRequestToUser(_ userID: String) {
        USER_REF.document(userID).collection("requests").document(CURRENT_USER_UID).setData("username": )
    }
    
    // removes friends from both users in firestore
    func removeFriend(_ userID: String) {
        CURRENT_USER_REF.collection("friends").document(userID).delete()
        USER_REF.document(userID).collection("friends").document(userID).delete()
    }
    
    func acceptFriendRequest(_ userID: String) {
        // removes USERID from "requests" and adds it to "friends"
        CURRENT_USER_REF.collection("requests").document(userID).delete()
        CURRENT_USER_REF.collection("friends").document(userID)
        
        USER_REF.document(userID).collection("friends").document(CURRENT_USER_UID)
    }
}
