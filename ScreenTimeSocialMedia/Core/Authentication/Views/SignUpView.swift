//
//  SignUpView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/5/23.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password found")
            return
        }

        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
            } catch {
                print("error")
            }
        }
    }
}

struct SignUpView: View {
    //@State private var email = ""
    //@State private var password = ""
    
    //@StateObject private var permissionManager = PermissionsManagerViewModel()
    //@StateObject private var Auth = AuthViewModel()
    @StateObject private var viewModel = SignUpViewModel()



    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("email", text: viewModel.$email)
                .frame(width: 275)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            TextField("password", text : viewModel.$password)
                .frame(width: 275)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            Button("Sign Up", action: {
                // let result = Auth.performSignUp(email: email, passwordEntered: password) // Call your function here
                viewModel.signUp()
            })
            
            /*NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true)) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:200, height: 45)
                    .background(Color.blue)
                    .cornerRadius(10)#imageLiteral(resourceName: "simulator_screenshot_93A053C5-D041-452F-A603-C8F0EE12F21D.png")
            } .simultaneousGesture(TapGesture().onEnded{
                permissionManager.screenTimeRequestAuth()
            }) .simultaneousGesture(TapGesture().onEnded(
                Auth.performSignUp(username: username, passwordEntered: password)
            ))*/
            
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
