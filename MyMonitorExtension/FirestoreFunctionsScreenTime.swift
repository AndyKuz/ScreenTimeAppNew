//
//  FirestoreFunctionsScreenTime.swift
//  MyMonitorExtension
//
//  Created by Andrew Kuznetsov on 10/14/23.
//

import Foundation
import Firebase

class FirestoreFunctionsScreenTime {
    static let system = FirestoreFunctionsScreenTime()
    
    // Base reference for database
    let BASE_REF = Firestore.firestore()
    
    // Base reference for users
    let USER_REF = Firestore.firestore().collection("users")
    
    var PODS_REF: CollectionReference {
        return BASE_REF.collection("pods")
    }
    
    func incrementStrikes(podID: String, userID: String) {
        PODS_REF.document(podID).collection("users").document(userID).updateData([
            "currentStrikes": FieldValue.increment(Int64(1))
        ])
    }
}
