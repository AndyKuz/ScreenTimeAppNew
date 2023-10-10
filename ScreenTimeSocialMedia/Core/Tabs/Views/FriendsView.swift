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
    
    @State var sentFriendRequestsList: [User] = []
    
    @State var numFriendRequests = 0    // store count of number of friend requests
    @State var friendRequestList: [User] = [] // init list of friendRequests
    
    @State var numFriends = 0   // store count of number of friends
    @State var friendsList: [User] = [] // init list of friends
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: FriendsRequestView(friendRequestsList: $friendRequestList)) {
                         ZStack {
                             // clickable bell at top right of the screen
                             Image(systemName: "bell.fill")
                                 .renderingMode(.original)
                                 .resizable()
                                 .frame(width: 30, height: 32)
                                 .padding()
                             
                             // display number over bell signifying num friend requests
                             if numFriendRequests > 0 {
                                 Text("\(numFriendRequests)")
                                     .font(.system(size: 15))
                                     .foregroundColor(.white)
                                     .background(Circle().fill(Color.red).frame(width: 20, height: 20))
                                     .offset(x: 8, y: -8)
                             }
                         }
                     }
                    
                }
                // displays the number of current friends
                // if clicked on navigates to a view with a list of current friends
                NavigationLink(destination: FriendsListView(friendsList: $friendsList)) {
                    Text("\(numFriends)")
                        .font(.title)
                        .bold()
                        .padding(.top, 70)
                }
                Text("friends")
                
                // search for users
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
                        
                        if friendsList.contains( where: {$0.uid == user.uid}) {
                            Text("friends")
                        } else if sentFriendRequestsList.contains( where: {$0.uid == user.uid}) {
                            Text("requested")
                        }
                        else {
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
        .onAppear() {
            // load friends list
            FirestoreFunctions.system.loadFriends { users in
                numFriends = users.count
                friendsList = users
            }
            
            FirestoreFunctions.system.loadRecievedFriendRequests { users in
                numFriendRequests = users.count
                friendRequestList = users
            }
            
            FirestoreFunctions.system.loadSentFriendRequests { users in
                sentFriendRequestsList = users
            }
        }
    }
}

#Preview {
    FriendsView()
}
