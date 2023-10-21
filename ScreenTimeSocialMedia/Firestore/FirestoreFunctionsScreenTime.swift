//
//  FirestoreFunctionsScreenTime.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/20/23.
//

import Foundation
import FirebaseFirestore
import CoreFoundation

extension FirestoreFunctions {
    // called at the start of every day
    func intervalStarted(pod: Pods) {
        if pod.started == true {    // if interval started called increment pod's currentDay
            PODS_REF.document(pod.podID).updateData([
                "currentDay": FieldValue.increment(Int64(1))
            ])
        }
    }
    
    // called when CURRENT_USER reaches screentime goal for specific pod
    func thresholdReached(pod: Pods) {
        if pod.started == false {   // wont do anything unless pod is in started state
            return
        }
        
        // queries for pod's associated firestore document
        PODS_REF.document(pod.podID).getDocument { querySnapshot, error in
            guard let document = querySnapshot, document.exists, let data = document.data() else {
                return
            }
            
            let currentDay = data["currentDay"] as! Int
            if currentDay > 0 { // we take day 0 as "setup day"
                // add the currentDay to list of failed Days
                self.PODS_REF.document(pod.podID).updateData([
                    "failedDays": FieldValue.arrayUnion([currentDay]),
                    "currentStrikes": FieldValue.increment(Int64(1))
                ])
                
                // update user's data who passed the threshold
                self.PODS_REF.document(pod.podID).collection("users").document(self.CURRENT_USER_UID).updateData([
                    "numStrikes": FieldValue.increment(Int64(1)),
                    "currentStreak": 0  // reset streak to 0
                ])
            }
        }
    }

}
