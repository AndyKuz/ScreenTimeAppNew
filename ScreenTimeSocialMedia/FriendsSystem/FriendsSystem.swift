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
    
    var CURRENT_USER_RECEIVED_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("receivedRequests")
    }
    
    var CURRENT_USER_SENT_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("sentRequests")
    }

    // gets current logged in user's uid
    var CURRENT_USER_UID: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    // gets current logged in user's username
    var CURRENT_USER_USERNAME: String {
        if let displayName = Auth.auth().currentUser?.displayName {
            return displayName
        } else {
            return "username" // Provide a default value or handle the case where displayName is nil
        }
    }

    
    // gets current logged in user's email
    var CURRENT_USER_EMAIL: String {
        if let email = Auth.auth().currentUser?.email {
            return email
        } else {
            return "email"
        }
    }
    
    func getUsername(_ userID: String, completion: @escaping (String) -> Void) {
        let userIDRef = USER_REF.document(userID)
        
        // gets document associated with userID
        userIDRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userIDUsername = document.data()?["username"] as? String {
                    completion(userIDUsername)
                } else {
                    print("username not found")
                }
            } else {
                print("document does not exist")
            }
        }
    }
    
    // FRIEND REQUEST SYSTEM FUNCTIONS
    
    // puts current users uid and username into userID's received requests
    // puts userID's uid and username in sent requests
    func sendFriendRequestToUser(_ userID: String) {
        // gets userID's username
        var userIDUsername = ""
        getUsername(userID) { username in
            userIDUsername = username
        }
        
        // configures userID's received requests
        USER_REF.document(userID).collection("receivedRequests").document(CURRENT_USER_UID).setData(["username": CURRENT_USER_USERNAME])
        // configures userID's sent requests
        CURRENT_USER_SENT_REQUESTS_REF.document(userID).setData(["username": userIDUsername])
    }
    
    // removes friends from both users in firestore
    func removeFriend(_ userID: String) {
        CURRENT_USER_FRIENDS_REF.document(userID).delete()
        USER_REF.document(userID).collection("friends").document(userID).delete()
    }
    
    // removes request for current users collection and add's userID as friend
    // adds current user as friend in userID's collection
    func acceptFriendRequest(_ userID: String) {
        // get userID's username
        var userIDUsername: String = ""
        getUsername(userID) { username in
            userIDUsername = username
        }
        
        // Remove current user from "recievedRequests" and add to "friends" for userID's collection
        CURRENT_USER_RECEIVED_REQUESTS_REF.document(userID).delete()
        CURRENT_USER_FRIENDS_REF.document(userID).setData(["username": userIDUsername])
                    
        // Remove current user from "recievedRequests" and add to "friends" for userID's collection
        USER_REF.document(userID).collection("sentRequests").document(CURRENT_USER_UID).delete()
        USER_REF.document(userID).collection("friends").document(CURRENT_USER_UID).setData(["username": CURRENT_USER_USERNAME])
    }
    
    // removes userID focument from Current users requests collection
    func rejectFriendRequest(_ userID: String) {
        CURRENT_USER_RECEIVED_REQUESTS_REF.document(userID).delete()
    }
}
