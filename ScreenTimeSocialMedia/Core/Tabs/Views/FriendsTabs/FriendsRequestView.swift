//
//  FriendsRequestView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/13/23.
//

import SwiftUI

struct FriendsRequestView: View {
    @State var friendRequestsList: [User] // pass in a list of friend requests
    
    var body: some View {
        VStack {
            Text("Friend Requests")
            List {
                ForEach(friendRequestsList, id: \.uid) { user in
                    HStack {
                        Text(user.username)
                        Spacer()
                        // when button clicked accept corresponding user's friend request
                        Button(action: {
                            FriendsSystem.system.acceptFriendRequest(user.uid)
                        }) {
                            Text("accept")
                        }
                        
                        Button(action: {
                            FriendsSystem.system.rejectFriendRequest(user.uid)
                        }) {
                            Image(systemName: "multiply.circle.fill")
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
}
