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
    
    @FocusState var usernameFocused: Bool
    @FocusState var passwordFocused: Bool
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            CustomTextField(text: $username, placeholder: "username", type: .text)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 275)
                .padding(.bottom, 10)
            
            CustomTextField(text: $password, placeholder: "password", type: .secure)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 275)
                .padding(.bottom, 10)
            
            NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true)) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:200, height: 45)
                    .background(!username.isEmpty && !password.isEmpty ? DefaultColors.teal1 : DefaultColors.lightGray)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)){
                Text("Don't have an account? Sign up")
                    .font(.headline)
                    .padding()

            }
        }
    }
}

#Preview {
    LoginView()
}
