//
//  ChatPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI

struct ChatPodView: View {
    @State var message = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("message", text: $message)
                .padding()
                .background(Color.gray.opacity(0.2))
                .frame(width: 300, height: 40)
                .cornerRadius(10)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    ChatPodView()
}
