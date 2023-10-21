//
//  ChatPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI
import Firebase

class ChatPodViewModel2: ObservableObject {
    @Published var data: [Messages] = []
}

struct ChatPodView2: View {
    @StateObject var viewModel = ChatPodViewModel2()
    @State var message = ""
    var pod: Pods
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ForEach(0..<10) { message in
                HStack{
                    Text("im tired")
                }
            }
        }
    }
}


