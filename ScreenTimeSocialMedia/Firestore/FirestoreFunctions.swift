//
//  FirestoreFunctions.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirestoreFunctions: ObservableObject {
    static let system = FirestoreFunctions()
    
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
    
    var CURRENT_USER_RECEIVED_FRIENDS_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("receivedFriendsRequests")
    }
    
    var CURRENT_USER_SENT_FRIENDS_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("sentFriendsRequests")
    }
    
    var CURRENT_USER_RECEIVED_PODS_REQUEST_REF: CollectionReference {
        return CURRENT_USER_REF.collection("receivedPodsRequests")
    }
    
    var CURRENT_USER_SENT_PODS_REQUEST_REF: CollectionReference {
        return CURRENT_USER_REF.collection("sentPodsRequests")
    }
    
    var CURRENT_USER_PODS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("pods")
    }
    
    var PODS_REF: CollectionReference {
        return BASE_REF.collection("pods")
    }
    
    @Published var allPodsListeners = [ListenerRegistration]()  // listener for every pod found in USERS POD COL
    @Published var usersPodIDListeners: ListenerRegistration? = nil // listener for USERS POD COL
    
    @Published var allPodsList: [Pods] = [] // all up to date USERS PODS
    @Published var currentPod: Pods = Pods(podID: "", title: "title", podType: .screenTime, totalStrikes: 7, currentStrikes: 0, goal: 5, timeframe: 2, started: false, failedDays: [], currentDay: 0)
    
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
    
    // given a userID return the users associated username
    func getUsername(_ userID: String, completion: @escaping(String) -> Void){
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
    
    // used for logout so no info is stored when user logs out and doesn't close app
    func cleanUp(completion: @escaping () -> Void) {
        for listener in allPodsListeners {
            listener.remove()
        }
        allPodsListeners.removeAll()
        
        if let listener = usersPodIDListeners {
            listener.remove()
            usersPodIDListeners = nil
        }
        
        allPodsList.removeAll()
        currentPod = Pods(podID: "", title: "title", podType: .screenTime, totalStrikes: 7, currentStrikes: 0, goal: 5, timeframe: 2, started: false, failedDays: [], currentDay: 0) // default Pod val
    }
}
