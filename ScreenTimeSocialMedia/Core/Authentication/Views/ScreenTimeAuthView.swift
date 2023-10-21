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
            Text("Welcome to Aco!")
                .padding()
                .font(.title)
            Text("Before we get started we need to set a few things up")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title2)
            Spacer()
            NavigationLink(destination: ScreenTimeAuthPermissionView().navigationBarBackButtonHidden(true)) {
                Text("Continue")
                    .frame(width: 200, height: 25)
                    .background(.blue)
                    .foregroundColor(.white)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ScreenTimeAuthPermissionView: View {
    @State var permissionManager = PermissionsManagerViewModel()
    @State var permissionGranted = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Since this app tracks your screen time please allow access to your screen time.")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                // requests screen time authorization
                permissionManager.screenTimeRequestAuth() { bool in
                    permissionGranted = bool
                }
            }) {
                Text("Allow Access")
                    .frame(width: 200, height: 25)
                    .background(.blue)
                    .foregroundColor(.white)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
            
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
            Spacer()
            Text("Awesome! Last step!")
                .font(.title2)
                .padding()
            Text("Choose which apps you want us to monitor. Feel free to change this later in settings if need be.")
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
            Button(action: {
                presentScreenTimeSheet = true
            }) {
                Text("Choose Apps")
                    .padding()
            }
            Spacer()
            NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true)) {
                Text("Finish!")
                    .frame(width: 200, height: 25)
                    .background(.blue)
                    .foregroundColor(.white)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .familyActivityPicker(  // allow user to select what apps they want to monitor
            isPresented: $presentScreenTimeSheet,
            selection: $screenTimeManager.activitySelection
        )
        .onChange(of: screenTimeManager.activitySelection) {
            screenTimeManager.saveSelection()
        }
        
        Spacer()
    }
}

