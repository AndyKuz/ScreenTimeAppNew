//
//  SignUpUsernameSelectView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/5/23.
//

import SwiftUI

struct SignUpUsernameSelectView: View {
    @State private var username = ""
    
    var body: some View {
        VStack {
            Text("Almost done!")
                .padding(.bottom, 5)
            Text("Now just go ahead and select your username")
                .padding(.bottom, 35)
            
            TextField("username", text: $username)
                .padding()
                .frame(width: 275)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            NavigationLink(destination:
                TabBarView()
                .navigationBarBackButtonHidden(true)) {
                Text("Go!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:200, height: 45)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    SignUpUsernameSelectView()
}

