//
//  ChatPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/24/23.
//

import SwiftUI
import Firebase

class ChatPodViewModel: ObservableObject {
    @Published var data: [Messages] = []
}

struct ChatPodView: View {
    @ObservedObject var db = FirestoreFunctions.system
    @StateObject var viewModel = ChatPodViewModel()
    @State var message = ""
    
    @State var messageSent = false
     
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    VStack(alignment: .leading, spacing: 7) {
                        ForEach(viewModel.data, id: \.id) { message in
                            MessageView(currentMessage: message)
                                .id(message.id) // used for coordination w/ proxy
                        }
                    }
                    .padding()
                    // if the current user sends a message scroll ScrollView to the bottom
                    .onChange(of: messageSent) { message in
                        if message {
                            messageSent = false
                            
                            withAnimation {
                                proxy.scrollTo(viewModel.data.last?.id, anchor: .center)
                            }
                        }
                    }
                }
            }
            // textbar
            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // sends the message to db when user clicks send button
                    FirestoreFunctions.system.sendMessagesDatabase(message: Messages(userID: Auth.auth().currentUser!.uid, username: (Auth.auth().currentUser?.displayName)!, text: message, createdAt: Date()), podID: db.currentPod.podID)
                    message = ""
                    messageSent = true
                }) {
                    Text("Send")
                        .padding()
                        .background(DefaultColors.teal1)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        // saves messages in the database
        .onAppear() {
            FirestoreFunctions.system.getMessageDatabase(podID: db.currentPod.podID) { retrievedMessages in
                viewModel.data = retrievedMessages
            }
        }
    }
}
