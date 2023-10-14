//
//  SignUpView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/5/23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SignUpViewModel()

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            if let _ = viewModel.error {
                Text(viewModel.error ?? "")
                    .foregroundColor(.red)
            }
            
            CustomTextField(text: $viewModel.email, placeholder: "email", type: .text)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 275)
                .padding(.bottom, 10)
            CustomTextField(text: $viewModel.username, placeholder: "username", type: .text)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 275)
                .padding(.bottom, 10)
            CustomTextField(text: $viewModel.password, placeholder: "password", type: .secure)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 275)
                .padding(.bottom, 10)
            
            Button("Sign Up") {
                viewModel.signUp()
            }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width:200, height: 45)
                .background(Color.blue)
                .cornerRadius(10)

            NavigationLink("", destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $viewModel.navigateToNextView)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // go back to parent view (LoginView)
            }) {
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
