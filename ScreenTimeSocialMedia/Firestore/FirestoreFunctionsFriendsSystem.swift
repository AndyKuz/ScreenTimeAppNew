//
//  FirestoreFunctionsFriendsSystem.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation

extension FirestoreFunctions {
    // FRIEND REQUEST SYSTEM FUNCTIONS
    
    // puts current users uid and username into userID's received requests
    // puts userID's uid and username in sent requests
    func sendFriendRequestToUser(_ userID: String) {
        // configures userID's received requests
        USER_REF.document(userID).collection("receivedRequests").document(CURRENT_USER_UID).setData(["username": CURRENT_USER_USERNAME])
    
        // gets userID's username
        getUsername(userID) { username in
            // configures userID's sent requests
            self.CURRENT_USER_SENT_REQUESTS_REF.document(userID).setData(["username": username])
        }
    }
    
    // removes friends from both users in firestore
    func removeFriend(_ userID: String) {
        CURRENT_USER_FRIENDS_REF.document(userID).delete()
        USER_REF.document(userID).collection("friends").document(CURRENT_USER_UID).delete()
    }
    
    // removes request for current users collection and add's userID as friend
    // adds current user as friend in userID's collection
    func acceptFriendRequest(_ userID: String) {
        // Remove current user from "recievedRequests" and add to "friends" for userID's collection
        CURRENT_USER_RECEIVED_REQUESTS_REF.document(userID).delete()
        
        // get userID's username
        getUsername(userID) { username in
            // add CURRENT_USER to userID's friend's collection
            self.CURRENT_USER_FRIENDS_REF.document(userID).setData(["username": username])
        }
                    
        // Remove current user from "recievedRequests" and add to "friends" for userID's collection
        USER_REF.document(userID).collection("sentRequests").document(CURRENT_USER_UID).delete()
        USER_REF.document(userID).collection("friends").document(CURRENT_USER_UID).setData(["username": CURRENT_USER_USERNAME])
    }
    
    // removes userID focument from Current users requests collection
    func rejectFriendRequest(_ userID: String) {
        CURRENT_USER_RECEIVED_REQUESTS_REF.document(userID).delete()
    }
}
