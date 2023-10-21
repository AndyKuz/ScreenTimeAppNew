//
//  MessageView.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 10/1/23.
//

import SwiftUI
import Firebase

struct MessageView: View {
    var currentMessage: Messages
    var isCurrentUser: Bool {
        return FirestoreFunctions.system.CURRENT_USER_UID == currentMessage.userID
    }
    
    var body: some View {
        // if user sent message put it on right side, else put it on left side
        VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 3) {
            Text(currentMessage.username)
                .font(.caption)
                .foregroundColor(.gray)
        
            HStack(alignment: .bottom, spacing: 7) {
                if isCurrentUser {
                    Spacer()
                }
                TextView(contentMessage: currentMessage.text, isCurrentUser: isCurrentUser)
            }
        }
    }
}

