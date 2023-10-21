//
//  MembersPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/13/23.
//

import SwiftUI

struct MembersPodView: View {
    @State var membersList: [User] = []
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: MembersInvitePodView()) {
                        Image(systemName: "plus")
                            .padding()
                    }
                }
                Text("Members")
            }
            List {
                ForEach(membersList, id: \.uid) { user in
                    HStack {
                        Text(user.username)
                            .padding(.trailing, 10)
                        if let currentStreak = user.currentStreak, currentStreak >= 2 { // only displays streak if >= 2
                            Text("\(currentStreak)")
                                .padding(.leading, 1)
                            Image(systemName: "flame.fill")
                                .foregroundColor(DefaultColors.teal1)
                                .padding(.leading, 1)
                        }
                        Spacer()
                        // displays user's strikes
                        Text("strikes: \(user.numStrikes ?? 0)")
                            .padding(.horizontal)
                    }
                }
            }
            .frame(width: 350)
            .listStyle(PlainListStyle())    // remove list style
            .listRowInsets(EdgeInsets())  // remove space between list elements
            .background(Color(UIColor.systemBackground))
        }
        .onAppear() {
            // fetches all the pod users
            FirestoreFunctions.system.loadPodUsers(podID: FirestoreFunctions.system.currentPod.podID) { users in
                membersList = users
            }
        }
    }
}
