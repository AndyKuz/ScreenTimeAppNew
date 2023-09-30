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
    
    
    // FRIEND REQUEST SYSTEM FUNCTIONS
    
    // puts current users id and username into userID's collection
    func sendFriendRequestToUser(_ userID: String) {
        USER_REF.document(userID).collection("requests").document(CURRENT_USER_UID).setData(["username": CURRENT_USER_USERNAME])
    }
    
    // removes friends from both users in firestore
    func removeFriend(_ userID: String) {
        CURRENT_USER_FRIENDS_REF.document(userID).delete()
        USER_REF.document(userID).collection("friends").document(userID).delete()
    }
    
    // removes request for current users collection and add's userID as friend
    // adds current user as friend in userID's collection
    func acceptFriendRequest(_ userID: String) {
        let userIDRef = USER_REF.document(userID)
        
        // gets document associated with userID
        userIDRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userIDUsername = document.data()?["username"] as? String {
                    // Remove current user from "requests" and add to "friends" for userID's collection
                    self.CURRENT_USER_REQUESTS_REF.document(userID).delete()
                    self.CURRENT_USER_FRIENDS_REF.document(userID).setData(["username": userIDUsername])
                    
                    // Add userID's uid and username to current user's "friends" collection
                    self.USER_REF.document(userID).collection("friends").document(self.CURRENT_USER_UID).setData(["username": self.CURRENT_USER_USERNAME])
                } else {
                    // Handle the case where username is not available
                    print("Username not available")
                }
            } else {
                // Handle the case where the document doesn't exist
                print("Document does not exist")
            }
        }
    }
    
    // removes userID focument from Current users requests collection
    func rejectFriendRequest(_ userID: String) {
        CURRENT_USER_REQUESTS_REF.document(userID).delete()
    }
}
