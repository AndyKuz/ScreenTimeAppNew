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
    
    // updates pod document with all necessary values after user passes threshold
    func userFailed(podID: String, userID: String) {
        // incrementing users currentStrikes
        PODS_REF.document(podID).getDocument { querySnapshot, error in
            guard let document = querySnapshot, document.exists, let data = document.data() else {
                return
            }
            
            let currentDay = data["currentDay"] as! Int
            if currentDay > 0 { // we take day 0 as "setup day"
                self.PODS_REF.document(podID).updateData([  // add the currentDay to list of failed Days
                    "failedDays": FieldValue.arrayUnion([currentDay]),
                    "currentStrikes": FieldValue.increment(Int64(1))
                ])
                
                // update user's data who passed the threshold
                self.PODS_REF.document(podID).collection("users").document(userID).updateData([
                    "numStrikes": FieldValue.increment(Int64(1)),
                    "currentStreak": 0
                ])
            }
        }
        PODS_REF.document(podID).collection("users").document(userID).updateData([
            "numStrikes": FieldValue.increment(Int64(1))
        ])
    }
}
