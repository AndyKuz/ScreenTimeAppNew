//
//  MainPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/22/23.
//
import SwiftUI
import UserNotifications
import DeviceActivity

// view that builds the progress bar for the timeline of the pod
struct SegmentedProgressBar: View {
    var failedDays: [Int]
    var completedDays: Int
    var totalDays: Int
    
    var selectedColor: Color = .accentColor
    var unselectedColor: Color = Color.secondary.opacity(0.3)
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1 ..< totalDays + 1, id: \.self) { index in
                Rectangle()
                    .foregroundColor(index <= self.completedDays ? (failedDays.contains(index) ? .red : .green) : self.unselectedColor)
            }
        }
        .frame(maxWidth: 330, maxHeight: 20)
        .clipShape(Capsule())
    }
}


// View for main screen of pod
struct MainPodView: View {
    @StateObject var db = FirestoreFunctions.system
    @StateObject var screenTimeManager = ScreenTimeViewModel()
    
    @State var startConfirmation = false    // present alert when user clicks "start pod"
    @State var navigateToMemberView: Bool = false   // when user clicks on member icon
    
    var body: some View {
        ZStack {
            // friends button in the top right corner
            HStack {
                Spacer() // pushes friends button all the way right
                VStack {
                    Button(action: {
                        navigateToMemberView = true
                    }) {
                        Image(systemName: "person.3.sequence.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    Spacer() // pushes friends button all the way up
                }
            }
            
            // Displays all the necessary info about pod
            VStack {
                Text(db.currentPod.title!)
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.top, 50)
                    .padding(.bottom, 7)
                SegmentedProgressBar(failedDays: db.currentPod.failedDays, completedDays: db.currentPod.currentDay, totalDays: Int(db.currentPod.timeframe * 7.0))
                Text("\(Int(FirestoreFunctions.system.currentPod.timeframe!)) Weeks")
                    .padding(.horizontal, 30)
                    .padding(.bottom, 5)
                
                Text("\(FirestoreFunctions.system.currentPod.currentStrikes)/\(FirestoreFunctions.system.currentPod.totalStrikes)")
                
                Spacer()
                                
                if !db.currentPod.started {
                    Button (action: {
                        startConfirmation = true
                    }) {
                        Text("Start Pod?")
                    }
                    .padding()
                    .confirmationDialog("Are you sure?", isPresented: $startConfirmation, titleVisibility: .visible) {
                        Button(action: {
                            screenTimeManager.beginMonitoring(pod: FirestoreFunctions.system.currentPod) // begin monitoring screenTime for the currentUser
                            db.startPod(podID: FirestoreFunctions.system.currentPod.podID)
                        }) {
                            Text("Start Pod!")
                        }
                    } message: {
                        Text("Once you start the pod you will not be able to invite anymore friends nor stop the pod")
                    }
                    
                }
                Spacer()
            }
        }
        .onAppear() {
            // requests screenTime
            PermissionsManagerViewModel().screenTimeRequestAuth() { _ in }
        }
        NavigationLink("", destination: MembersPodView(), isActive: $navigateToMemberView)
        
    }
}
