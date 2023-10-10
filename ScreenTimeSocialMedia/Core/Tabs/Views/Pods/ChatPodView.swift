//
//  ChatPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI
import Firebase

class ChatPodViewModel: ObservableObject {
    @Published var data: [Messages] = []
}

struct ChatPodView: View {
    @StateObject var viewModel = ChatPodViewModel()
    @State var message = ""
    var pod: Pods
     
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 7) {
                    ForEach(viewModel.data.sorted(by: { $0.createdAt < $1.createdAt }), id: \.createdAt) { message in
                        MessageView(currentMessage: message)
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
                .background(Color.clear)
            }
            Spacer()
            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // Handle sending the message
                    FirestoreFunctions.system.sendMessagesDatabase(message: Messages(userID: Auth.auth().currentUser!.uid, username: (Auth.auth().currentUser?.displayName)!, text: message, createdAt: Date()), podID: pod.podID)
                    message = ""
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
        .onAppear() {
            FirestoreFunctions.system.getMessageDatabase(podID: pod.podID) { (retrievedMessages, error) in
                if let error = error {
                    // Handle the error
                    print("Error: \(error)")
                } else if let loadedMessages = retrievedMessages {
                    // Access the retrieved messages here
                    viewModel.data = loadedMessages
                }
            }
        }
    }
}
