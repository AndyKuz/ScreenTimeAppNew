//
//  GoalsView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct FriendsView: View {
    @State private var searchQuery = ""
    @State private var searchResults: [User] = []
    
    var tempFriends = 42
    var tempFriendRequests = 3
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    NavigationLink(destination: FriendsRequestView().navigationBarBackButtonHidden(false)) {
                        Label("FriendsRequests", systemImage: "bell.fill")
                            .frame(width: 30, height: 32)
                            .padding()
                    }
                        
                    if tempFriendRequests > 0 {
                        Text("\(tempFriendRequests)")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.red).frame(width: 20, height: 20))
                            .offset(x: 8, y: -8)
                    }
                }
            }
            Text("\(tempFriends)")
                .font(.title)
                .bold()
                .padding(.top, 70)
            Text("friends")
            SearchBar(text: $searchQuery)
                .padding(.top, 20)
                // waits until searchQuery changes
                .onChange(of: searchQuery) { newQuery in
                    // calls searchUsers with the newQuery
                    FriendsSystem.system.searchUsers(query: newQuery) { users in
                        // populates list of searchResults with type User
                        self.searchResults = users
                    }
                }
            List(searchResults, id: \.uid, rowContent: { user in
                HStack {
                    Text(user.username)
                    Spacer()
                    Button (action: {
                        print("clicked!")
                        FriendsSystem.system.sendFriendRequestToUser(user.uid)
                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                    Divider().background(Color.gray)
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
    FriendsView()
}
