//
//  FirestoreFunctionsMessages.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 10/7/23.
//

import Foundation
import FirebaseFirestore

extension FirestoreFunctions {
    func getMessageDatabase(message: Messages, pod: Pods, completion: @escaping ([Messages]?, Error?) -> Void) {
        let MESSAGE_COLLECTION_REF = PODS_REF.document(pod.podID).collection("messages")
            
        let _ = MESSAGE_COLLECTION_REF.addSnapshotListener { snapshot, error in
            if let error = error {
                // Handle the error
                print("Error listening for messages: \(error)")
                completion(nil, error)
                    return
                }
            var messages = [Messages]()
            for doc in snapshot?.documents ?? []{
                let data = doc.data()
                let text = data["text"] as? String ?? "Error"
                let from = data["from"] as? String ?? "Error"
                let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
                let msg = Messages(from: from, text: text, createdAt: createdAt.dateValue())
                messages.append(msg)
            }
            completion(messages, nil)
        }
    }
    
    func sendMessagesDatabase(message: Messages, pod: Pods) {
        let message = [
            "from": message.from,
            "text": message.text,
            "createdAt": message.createdAt
        ] as [String: Any]
        
        PODS_REF.document(pod.podID).collection("messages").addDocument(data: message) { err in
            if let err = err {
                print("Error saving message: \(err)")
            } else {
                print("message saved")
            }
        }
    }
}
