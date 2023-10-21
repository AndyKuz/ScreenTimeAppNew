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
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, Animate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(Animate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
}

struct ChatPodView: View {
    @StateObject var viewModel = ChatPodViewModel()
    @State var message = ""
    var pod: Pods
    
    @State private var messageIdToScroll: UUID?
     
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollReader in
                    VStack(alignment: .leading, spacing: 7) {
                        ForEach(viewModel.data, id: \.id) { message in
                            MessageView(currentMessage: message)
                        }
                    }
                    .padding()
                }
            }
            // textbar
            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // sends the message to db when user clicks send button
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
        // saves messages in the database
        .onAppear() {
            FirestoreFunctions.system.getMessageDatabase(podID: pod.podID) { retrievedMessages, error in
                viewModel.data = retrievedMessages!
            }
        }
    }
}
