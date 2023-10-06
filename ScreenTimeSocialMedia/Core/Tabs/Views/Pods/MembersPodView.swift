//
//  MembersPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/22/23.
//

import SwiftUI

struct MembersPodView: View {
    @State var currentMembers: [User] = []
    @State var searchResults: [User] = []
    @State var searchQuery: String = ""
    
    var body: some View {
        VStack {
            Text("Invite Members")
            SearchBar(text: $searchQuery)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.top, 20)
                // waits until searchQuery changes
                .onChange(of: searchQuery) { newQuery in
                    // calls searchUsers with the newQuery
                    FirestoreFunctions.system.searchUsers(query: newQuery) { users in
                        self.searchResults = users
                    }
                }
            
            // displays search results
            List(searchResults, id: \.uid, rowContent: { user in
                HStack {
                    Text(user.username)
                    Spacer()
                    
                    if currentMembers.contains( where: {$0.uid == user.uid}) {
                        Text("friends")
                    } else {
                        // if button clicked add associated user
                        Button (action: {
                            FirestoreFunctions.system.sendFriendRequestToUser(user.uid)
                        }){
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
                .padding(.vertical, 8)
            })
            .frame(width: 350)
            .listStyle(PlainListStyle())    // remove list style
            .listRowInsets(EdgeInsets())  // remove space between list elements
            .background(Color(UIColor.systemBackground))
            Spacer()
        }
    }
}

#Preview {
    MembersPodView()
}
