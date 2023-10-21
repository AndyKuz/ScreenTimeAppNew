import SwiftUI

struct MembersInvitePodView: View {
    @State var nonPodFriendsList: [User] = []
    @State var sentPodsRequestsList: [User] = []

    var body: some View {
        VStack {
            Text("Invite Friends")
            List {
                ForEach($nonPodFriendsList, id: \.uid) { user in
                    HStack {
                        Text(user.username.wrappedValue)
                        Spacer()
                        // if user has been sent a pod invite display "invited" next to their name
                        if sentPodsRequestsList.contains( where: { $0.uid == user.uid.wrappedValue }) {
                            Text("Invited")
                        } else {
                            Button(action: {    // when clicked invite user
                                FirestoreFunctions.system.sendPodRequest(podID: FirestoreFunctions.system.currentPod.podID, user: User(username: user.username.wrappedValue, userID: user.uid.wrappedValue))
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 350)
        .listStyle(PlainListStyle())    // remove list style
        .listRowInsets(EdgeInsets())  // remove space between list elements
        .background(Color(UIColor.systemBackground))
        .onAppear() {
            let podID = FirestoreFunctions.system.currentPod.podID
            
            // fetches all friends of CURRENT_USER who are NOT in the current pod
            FirestoreFunctions.system.loadNonPodFriends(podID: podID!) { users in
                nonPodFriendsList = users
            }
            
            FirestoreFunctions.system.loadSentPodRequests(podID: podID!) { users in
                sentPodsRequestsList = users
            }
        }
    }
}

