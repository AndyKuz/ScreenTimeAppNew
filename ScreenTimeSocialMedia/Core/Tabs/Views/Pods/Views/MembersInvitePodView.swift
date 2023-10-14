import SwiftUI

struct MembersInvitePodView: View {
    @State var nonPodFriendsList: [User] = []
    @State var sentPodsRequestsList: [User] = []
    var podID: String

    var body: some View {
        VStack {
            Text("Invite Friends")
            List {
                ForEach($nonPodFriendsList, id: \.uid) { user in
                    HStack {
                        Text(user.username.wrappedValue)
                        Spacer()
                        if sentPodsRequestsList.contains( where: { $0.uid == user.uid.wrappedValue }) {
                            Text("Invited")
                        } else {
                            Button(action: {
                                FirestoreFunctions.system.sendPodRequest(podID: podID, user: User(username: user.username.wrappedValue, userID: user.uid.wrappedValue))
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
            FirestoreFunctions.system.loadNonPodFriends(podID: podID) { users in
                nonPodFriendsList = users
            }
            
            FirestoreFunctions.system.loadSentPodRequests(podID: podID) { users in
                sentPodsRequestsList = users
            }
        }
    }
}

