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
    @State var permissionManager = PermissionsManagerViewModel()

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            if let _ = viewModel.error {
                Text(viewModel.error ?? "")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
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
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // go back to parent view (LoginView)
            }) {
                Text("Already have an account? Login")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }

            // navigates to new view depending if screen time authorized
            NavigationLink("", destination: permissionManager.screenTimeAuth() ?
                AnyView(TabBarView().navigationBarBackButtonHidden(true)) :
                AnyView(ScreenTimeAuthIntroView().navigationBarBackButtonHidden(true)),
                isActive: $viewModel.navigateToNextView)
            
        }
    }
}

#Preview {
    SignUpView()
}
