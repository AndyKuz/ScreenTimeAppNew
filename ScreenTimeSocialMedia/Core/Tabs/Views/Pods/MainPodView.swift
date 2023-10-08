//
//  MainPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/22/23.
//
import SwiftUI
import UserNotifications

// Sheet configuration to allow user to select their personal goal
struct GoalSheet: View {
    @Binding var sheetPresented: Bool
    var podType: groupType
    @State var numHours = 1
    
    var body: some View {
        VStack {
            Text("Before beginning please select your \(podType.rawValue) goal")
                .font(.title2)
                .padding(.top, 30)
                .multilineTextAlignment(.center)
            
            // gives user options from 1-6 hours for goal
            HStack {
                Picker("Hours", selection: $numHours) {
                    ForEach(1..<6, id: \.self) { selection in
                        Text("\(selection)")
                    }
                }
                Text("hours per day")
            }
            .padding(.top, 10)
            
            Button("Go!", action: {
                sheetPresented = false
            })
            .padding(.top, 20)
            Spacer()
            
        }
        
    }
}

// view that builds the progress bar for the timeline of the pod
struct SegmentedProgressBar: View {
    var failedDays: [Int]
    var completedDays: Int
    var totalDays: Int
    
    var selectedColor: Color = .accentColor
    var unselectedColor: Color = Color.secondary.opacity(0.3)
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0 ..< totalDays, id: \.self) { index in
                Rectangle()
                    .foregroundColor(index < self.completedDays ? (failedDays.contains(index) ? .red : .green) : self.unselectedColor)
            }
        }
        .frame(maxWidth: 330, maxHeight: 20)
        .clipShape(Capsule())
    }
}


// View for main screen of pod
struct MainPodView: View {
    @StateObject var screenTimeManager = ScreenTimeViewModel()
    var pod: Pods
    @State var presentGoalSheet = false
    @State var presentScreenTimeSheet = false
    @State var navigateToMemberView:Bool = false
    
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
                Text(pod.title!)
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.top, 50)
                    .padding(.bottom, 7)
                SegmentedProgressBar(failedDays: [3, 7, 12], completedDays: 37, totalDays: 56)
                Text("0/\(pod.totalStrikes!) Strikes")
                    .padding(.horizontal, 30)
                Button(action: {
                    screenTimeManager.startMonitoring(goalHours: 1, pod: pod)
                }) {
                    Text("beging monitoring")
                }
                
                Button(action: {
                    let notificationContent = UNMutableNotificationContent()
                    notificationContent.title = "Hello world!"
                    notificationContent.subtitle = "Here's how you send a notification in SwiftUI"

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    let req = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

                    UNUserNotificationCenter.current().add(req)
                }) {
                    Text("Send push notification")
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            PermissionsManagerViewModel().screenTimeRequestAuth()
            // Check if something is saved for a specific key
            if let savedValue = UserDefaults.standard.object(forKey: "ScreenTimeSelection") {
                // There is something saved for the key
                print("Value exists: \(savedValue)")
            } else {
                // Nothing is saved for the key
                presentScreenTimeSheet = true
            }
        })
        .familyActivityPicker(
            isPresented: $presentScreenTimeSheet,
            selection: $screenTimeManager.activitySelection
        )
        .onChange(of: screenTimeManager.activitySelection) {
            screenTimeManager.saveSelection()
        }
        .sheet(isPresented: $presentGoalSheet, content: {
            GoalSheet(sheetPresented: $presentGoalSheet, podType: pod.podType!)
        })
        NavigationLink("", destination: MembersPodView(pod: pod), isActive: $navigateToMemberView)
    }
}
