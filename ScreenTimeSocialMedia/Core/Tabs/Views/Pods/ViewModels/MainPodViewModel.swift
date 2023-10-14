//
//  MainPodViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/12/23.
//

import Foundation

extension FirestoreFunctions {
    func incrementStrikes(podID: String) {
        let docRef = PODS_REF.document(podID)
        
        BASE_REF.runTransaction({ (transaction, errorPointer) -> Any? in
            do {
                // Get the current value of "currentStrikes" from the document
                let documentSnapshot = try transaction.getDocument(docRef)
                if var currentStrikes = documentSnapshot.data()?["currentStrikes"] as? Int {
                    // Increment the value by 1
                    currentStrikes += 1
                    // Update the "currentStrikes" field in the document
                    transaction.updateData(["currentStrikes": currentStrikes], forDocument: docRef)
                } else {
                    // If "strikes" field doesn't exist, set it to 1
                    transaction.setData(["currentStrikes": 1], forDocument: docRef)
                }
            } catch let fetchError as NSError {
                // Handle any errors that occur during the transaction
                errorPointer?.pointee = fetchError
                return nil
            }
            return nil
        }) { (object, error) in
            if let error = error {
                print("Error updating strikes: \(error.localizedDescription)")
            } else {
                print("Strikes incremented successfully!")
            }
        }

    }
}
