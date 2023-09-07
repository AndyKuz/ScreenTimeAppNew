//
//  LoginView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("username", text: $username)
                .frame(width: 275)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            TextField("password", text : $password)
                .frame(width: 275)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true)) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:200, height: 45)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)){
                Text("Don't have an account? Sign up")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()

            }
        }
    }
}

#Preview {
    LoginView()
}
