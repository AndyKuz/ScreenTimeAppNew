//
//  FirestoreFunctionsMessages.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 10/7/23.
//

import Foundation
import FirebaseFirestore

extension FirestoreFunctions {
    func getMessageDatabase(podID: String, completion: @escaping ([Messages]) -> Void) {
        
        // grabs messages from db
        let query = PODS_REF.document(podID).collection("messages").order(by: "createdAt", descending: false)
        
        // listens in to see if any messages are sent
        let _ = query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("getMessageDatabase(): Error listening for messages: \(error)")
                return
            }
            
            var messages = [Messages]()
            
            for doc in snapshot?.documents ?? []{
                let data = doc.data()
                let text = data["text"] as? String ?? "Error"
                let userID = data["userID"] as? String ?? "Error"
                let username = data["username"] as? String ?? "Error"
                let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
                let msg = Messages(userID: userID, username: username, text: text, createdAt: createdAt.dateValue())
                messages.append(msg)
            }
            completion(messages)
            
        }
    }
    
    // stores message in db
    func sendMessagesDatabase(message: Messages, podID: String) {
        let message = [
            "userID": message.userID,
            "username": message.username,
            "text": message.text,
            "createdAt": message.createdAt
        ] as [String: Any]
        
        PODS_REF.document(podID).collection("messages").addDocument(data: message) { err in
            if let err = err {
                print("sendMessageDatabase(): Error saving message: \(err)")
            }
        }
    }
}
