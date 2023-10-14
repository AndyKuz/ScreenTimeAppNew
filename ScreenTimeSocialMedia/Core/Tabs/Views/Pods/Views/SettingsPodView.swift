//
//  SettingsPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/12/23.
//

import SwiftUI

struct SettingsPodView: View {
    var pod: Pods
    var fetchUsersPods: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section("Utility") {
                Button {
                    Task {
                        FirestoreFunctions.system.removeUserFromPod(podID: pod.podID, user: User(username: FirestoreFunctions.system.CURRENT_USER_USERNAME, userID: FirestoreFunctions.system.CURRENT_USER_UID))
                        fetchUsersPods()    // fetch new list of pods and update it in HomeView
                        presentationMode.wrappedValue.dismiss() // forcefully leave pod view
                    }
                } label: {
                    SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Leave Pod", tintColor: .red)
                }
            }
        }
    }
}
