//
//  LoginView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            DefaultColors.darkBlack
                .ignoresSafeArea()
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
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
                
                NavigationLink("", destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $viewModel.navigateToNextView)
                
                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)){
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                    
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
