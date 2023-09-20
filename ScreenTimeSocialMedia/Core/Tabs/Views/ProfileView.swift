//
//  ProfileView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct ProfileView: View {

    @StateObjecct private var viewModel = ProfileView()

    var body: some View {
        List {
            Section {
                HStack {
                    Text("A")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("AndyKuz")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("andrew.kuz137@gmail.com")
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

                        }
                    }
                } label: {
                    SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Log Out", tintColor: .red)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
