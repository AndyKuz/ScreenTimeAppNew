//
//  ScreenTimeAuthView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/7/23.
//

import SwiftUI

/*
 Takes user through process of setting up Screen Time Authentication
 as well as what apps they want to monitor
 */

struct ScreenTimeAuthIntroView: View {
    var body: some View {
        VStack {
            Text("Welcome to App Name!")
            Text("Before we get started we need to set a few things up")
            NavigationLink(destination: ScreenTimeAuthPermissionView().navigationBarBackButtonHidden(true)) {
                Text("Continue")
            }
        }
    }
}

struct ScreenTimeAuthPermissionView: View {
    var screenTimeViewModel = PermissionsManagerViewModel()
    @State var permissionGranted = false
    
    var body: some View {
        VStack {
            Text("Since this app tracks your screen time please allow access to your screen time.")
            Button(action: {
                // requests screen time authorization
                screenTimeViewModel.screenTimeRequestAuth()
                if screenTimeViewModel.screenTimeAuth() {   // if auth is detected navigate to next View
                    permissionGranted = true
                }
            }) {
                Text("Allow Access")
            }
            NavigationLink(
                destination: ScreenTimeAuthAppsSelectView().navigationBarBackButtonHidden(true),
                isActive: $permissionGranted,
                label: { EmptyView() }
            )
        }
    }
}

struct ScreenTimeAuthAppsSelectView: View {
    @State var presentScreenTimeSheet = false
    @State var screenTimeManager = ScreenTimeViewModel()
    var body: some View {
        VStack {
            Text("Awesome! Last step!")
            Text("Choose which apps you want us to monitor. Feel free to change this later in settings if need be.")
            Button(action: {
                presentScreenTimeSheet = true
            }) {
                Text("Choose Apps")
            }
            
            NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true)) {
                Text("Finish!")
            }
        }
        .familyActivityPicker(  // allow user to select what apps they want to monitor
            isPresented: $presentScreenTimeSheet,
            selection: $screenTimeManager.activitySelection
        )
        .onChange(of: screenTimeManager.activitySelection) {
            screenTimeManager.saveSelection()
        }
    }
}

