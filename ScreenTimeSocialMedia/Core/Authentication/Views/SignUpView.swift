//
//  SignUpView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/5/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var permissionManager = PermissionsManagerViewModel()

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("email", text: $email)
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
            
            NavigationLink(destination: SignUpUsernameSelectView()) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:200, height: 45)
                    .background(Color.blue)
                    .cornerRadius(10)
            } .simultaneousGesture(TapGesture().onEnded{
                permissionManager.screenTimeRequestAuth()
            })
            
            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                Text("Already have an account? Login")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
}

#Preview {
    SignUpView()
}
