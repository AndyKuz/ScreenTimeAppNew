//
//  ChatPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI
import Firebase

class ChatPodViewModel: ObservableObject {
    @Published var data = [
        Messages(from: Auth.auth().currentUser!.uid, text: "ur mom", createdAt: Date())
    ]
}

struct ChatPodView: View {
    @StateObject var viewModel = ChatPodViewModel()
    @State var message = ""
     
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(viewModel.data) { message in
                        MessageView(currentMessage: message)
                    }
                }
            }
        }
    }
}
