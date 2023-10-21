//
//  SettingsPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/12/23.
//

import SwiftUI

struct SettingsPodView: View {
    @StateObject var db = FirestoreFunctions.system
    var fetchUsersPods: () -> Void
    
    @State var presentLeaveConfirmation: Bool = false
    @State var leavePod = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            List {
                Section("Utility") {
                    Button {
                        Task {
                            presentLeaveConfirmation = true
                        }
                    } label: {
                        SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Leave Pod", tintColor: .red)
                    }
                    // allows user to confirm Leave
                    .confirmationDialog("Are you sure?",
                                        isPresented: $presentLeaveConfirmation) {
                        Button("Leave?", role: .destructive) {
                            print("clicked")
                            // removes CURRENT_USER from current pod
                            FirestoreFunctions.system.removeUserFromPod(podID: FirestoreFunctions.system.currentPod.podID, user: User(username: FirestoreFunctions.system.CURRENT_USER_USERNAME, userID: FirestoreFunctions.system.CURRENT_USER_UID)) {
                                
                                fetchUsersPods()    // fetch new list of pods and update it in HomeView
                                
                                // TODO: Need a way to not use NavigationLink
                                if db.currentPod.started {
                                    print("started true")
                                    leavePod = true
                                } else {
                                    print("started false")
                                    dismiss() // MARK: can be buggy
                                }
                            }
                        }
                    }
                }
                
            }
        }
        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $leavePod) {
            EmptyView()
        }
        .isDetailLink(false)
    }
}
