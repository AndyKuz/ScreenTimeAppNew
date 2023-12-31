//
//  LoginView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State var permissionManager = PermissionsManagerViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            CustomTextField(text: $viewModel.email, placeholder: "email", type: .text)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .padding(.bottom, 10)
            
            CustomTextField(text: $viewModel.password, placeholder: "password", type: .secure)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .padding(.bottom, 10)
            
            Button("Login") {
                viewModel.signIn()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width:200, height: 45)
            .background(Color.blue)
            .cornerRadius(10)
            
            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)){
                Text("Don't have an account? Sign up")
                    .font(.headline)
                    .padding()
                    .padding(.top, 10)
                
            }
            
            // checks for if user has all screen time authorization setup on device navigates based on result
            NavigationLink(
                destination: permissionManager.screenTimeAuth() ?
                AnyView(TabBarView().navigationBarBackButtonHidden(true)) :
                    AnyView(ScreenTimeAuthIntroView().navigationBarBackButtonHidden(true)),
                isActive: $viewModel.navigateToNextView
            ) {
                EmptyView()
            }
        }
    }
}

#Preview {
    LoginView()
}
