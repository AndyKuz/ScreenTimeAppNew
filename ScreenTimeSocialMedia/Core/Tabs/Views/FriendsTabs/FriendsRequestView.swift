//
//  FriendsRequestView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/13/23.
//

import SwiftUI

struct FriendsRequestView: View {
    @State private var friendRequestsList: [User] = [] // init empty list of User type
    
    var body: some View {
        List {
            ForEach(friendRequestsList, id: \.uid) { user in
                HStack {
                    Text(user.username)
                }
                Divider().background(Color.gray)
            }
        }
        .onAppear {
            FriendsSystem.system.loadFriendRequests { users in
                friendRequestsList = users
            }
        }
        .frame(width: 350)
        .listStyle(PlainListStyle())    // remove list style
        .listRowInsets(EdgeInsets())  // remove space between list elements
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    FriendsRequestView()
}
