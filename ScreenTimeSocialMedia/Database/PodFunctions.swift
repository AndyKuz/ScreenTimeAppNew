//
//  DatabaseFunctions.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/25/23.
//

import Foundation
import Firebase

class PodFunctions {
    let system = PodFunctions()
    let db = Firestore.firestore()
    
    struct Pods {
        let podID: String
        let title: String
        let descrtiption: String
        let podType: String
        let strikes: Int
        let timeframe: Int
    }
    
    struct Messages {
        let from: String
        let text: String
    }
    
    func createPod(pod: Pods) {
        db.collection("Pods").document(pod.podID).setData([
            "podID": pod.podID,
            "title": pod.title,
            "description": pod.descrtiption,
            "podType": pod.podType,
            "strikes": pod.strikes,
            "timeframe": pod.timeframe
        ]) { err in
            if let _ = err {
                print("error adding pod")
            } else {
                print("pod added successfully")
            }
        }
        
        db.collection("Pods").document(pod.podID).collection("messages")
        db.collection("Pods").document(pod.podID).collection("users")
    }
    
    func addPodMessages(pod: Pods, message: Messages) {
        let messageRef = db.collection("Pods").document(pod.podID).collection("messages").addDocument(data:[
            "from": message.from,
            "text": message.text,
            "timeStamp": Timestamp(date: Date())
        ]) { err in
            if let err = err {
                print("error adding message")
            } else {
                print("message added sucessfully")
            }
        }
    }
    
    func addPodUsers(pod: Pods, user: User) {
        let userRef = db.collection("Pods").document(pod.podID).collection("users").addDocument(data:[
            "user": user.uid!
        ]) { err in
            if let err = err {
                print("error adding user to pod")
            } else {
                print("user added to pod successfully")
            }
        }
    }
}


