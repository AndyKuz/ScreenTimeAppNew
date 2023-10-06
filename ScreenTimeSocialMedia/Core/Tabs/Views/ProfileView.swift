//
//  ProfileView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var email: String {
        FirestoreFunctions.system.CURRENT_USER_EMAIL
    }
    
    var username: String {
        FirestoreFunctions.system.CURRENT_USER_USERNAME
    }
    
    var firstLetter: String {
        return String(username.prefix(1)).capitalized
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(firstLetter)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(username)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(email)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                    
            }
            
            Section("Account") {
                Button {
                    Task {
                        do {
                            try viewModel.signOut()
                        } catch {
                            print("Error signing out")
                        }
                    }
                } label: {
                    SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Log Out", tintColor: .red)
                }
            }
        }
        NavigationLink(
            destination: LoginView().navigationBarBackButtonHidden(true),
            isActive: $viewModel.showLoginView,
            label: {EmptyView()}
        )
        .isDetailLink(false)
    }
}

#Preview {
    ProfileView()
}
