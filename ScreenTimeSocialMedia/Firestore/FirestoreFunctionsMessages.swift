//
//  FirestoreFunctionsMessages.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 10/7/23.
//

import Foundation
import FirebaseFirestore

extension FirestoreFunctions {
    func getMessage(message: Messages, pod: Pods) {
        PODS_REF.document(pod.podID).collection("messages").getDocuments { snapshot, err in
            if let err = err {
                print("error getting message")
            } else {
                print("message grabbed successfully")
            }
            
            let docs = snapshot!.documents
            
            var messages = [Messages]()
            for doc in docs {
                let data = doc.data()
                let text = data["text"] as? String ?? "Error"
                let from = data["from"] as? String ?? "Error"
                let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
                
                let msg = Messages(from: from, text: text, createdAt: createdAt.dateValue())
                messages.append(msg)
            }
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
