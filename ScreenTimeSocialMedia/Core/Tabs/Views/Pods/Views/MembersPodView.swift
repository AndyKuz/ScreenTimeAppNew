//
//  MembersPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/13/23.
//

import SwiftUI

struct MembersPodView: View {
    @State var membersList: [User] = []
    var pod: Pods
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: MembersInvitePodView(podID: pod.podID)) {
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
                        Spacer()
                    }
                }
            }
            .frame(width: 350)
            .listStyle(PlainListStyle())    // remove list style
            .listRowInsets(EdgeInsets())  // remove space between list elements
            .background(Color(UIColor.systemBackground))
        }
        .onAppear() {
            FirestoreFunctions.system.loadPodUsers(podID: pod.podID) { users in
                membersList = users
            }
        }
    }
}
