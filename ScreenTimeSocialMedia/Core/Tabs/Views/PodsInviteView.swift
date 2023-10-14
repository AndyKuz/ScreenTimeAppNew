//
//  PodsInviteView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/9/23.
//

import SwiftUI

struct PodsInviteView: View {
    @Binding var podsRequestList: [Pods]
    @Binding var pods: [Pods]
    var fetchUsersPodsRequests: () -> Void // function to manually update list of pods requests in HomeView
    
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Pod Invites")
            List {
                ForEach(podsRequestList, id: \.podID) { pod in
                    // chooses which emoji to display based on groupType
                    var groupEmoji: String{
                        switch(pod.podType!) {
                        case .screenTime:
                            return "⏳"
                        }
                    }
                    VStack {
                        HStack {
                            Text(pod.title!)
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text(groupEmoji)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Text("from: \(pod.inviter!)")
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // symbols representing rejecting or accepting request
                        HStack {
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .padding()
                            Spacer()
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                                .padding()
                        }
                        // swipe right to accept invite
                        .swipeActions(edge: .leading) {
                            Button {
                                // if more than 4 pods or more prevent user from accepting more
                                if pods.count >= 4 {
                                    errorMessage = "Maximum pod amount of 4 reached" // print error message
                                    
                                    // timer to remove error message after 3 seconds
                                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                        withAnimation {
                                            errorMessage = ""
                                        }
                                    }
                                } else {
                                    FirestoreFunctions.system.acceptPodRequest(podID: pod.podID, userID: FirestoreFunctions.system.CURRENT_USER_UID)
                                    fetchUsersPodsRequests()
                                }
                            } label: {
                                Label("Accept", systemImage: "checkmark.circle")
                            }
                            .tint(.green)
                        }
                        // swipe left to reject invite
                        .swipeActions(edge: .trailing) {
                            Button {
                                FirestoreFunctions.system.rejectPodRequest(podID: pod.podID, userID: FirestoreFunctions.system.CURRENT_USER_UID)
                                fetchUsersPodsRequests()
                            } label: {
                                Label("Reject", systemImage: "x.circle")
                            }
                        }
                        .tint(.red)
                    }
                    .frame(height: 100)
                }
            }
            // display error message if its not empty
            Text(errorMessage)
                .foregroundColor(.red)
                .opacity(errorMessage.isEmpty ? 0.0 : 1.0) // hide error message if error message empty
                .padding()
                Spacer()
        }
    }
}
