//
//  FriendsListView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/13/23.
//

import SwiftUI

struct FriendsListView: View {
    @Binding var friendsList: [User]
    
    var body: some View {
        VStack {
            Text("Friends")
            List {
                ForEach(friendsList, id: \.uid) { user in
                    HStack {
                        Text(user.username)
                        Spacer()
                        Button(action: {
                            FirestoreFunctions.system.removeFriend(user.uid)
                        }) {
                            Image(systemName: "multiply.circle.fill")
                        }
                    }
                    
                }
            }
        }
        .frame(width: 350)
        .listStyle(PlainListStyle())    // remove list style
        .listRowInsets(EdgeInsets())  // remove space between list elements
        .background(Color(UIColor.systemBackground))
    }
}
