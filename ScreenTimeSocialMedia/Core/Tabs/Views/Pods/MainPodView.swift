//
//  MainPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/22/23.
//
import SwiftUI

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
    
    var height: CGFloat = 20
    var width: CGFloat = 330
    var spacing: CGFloat = 2
    var selectedColor: Color = .accentColor
    var unselectedColor: Color = Color.secondary.opacity(0.3)
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0 ..< totalDays, id: \.self) { index in
                Rectangle()
                    .foregroundColor(index < self.completedDays ? (failedDays.contains(index) ? .red : .green) : self.unselectedColor)
            }
        }
        .frame(maxWidth: width, maxHeight: height)
        .clipShape(Capsule())
    }
}


// View for main screen of pod
struct MainPodView: View {
    @State var podName: String
    @State var podType: groupType
    @State var timeframe: Double
    @State var totalNumStrikes: Int
    @State var presentGoalSheet = false
    
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
                Text(podName)
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.top, 50)
                    .padding(.bottom, 7)
                SegmentedProgressBar(failedDays: [3, 7, 12], completedDays: 37, totalDays: 56)
                Text("0/\(totalNumStrikes) Strikes")
                    .padding(.horizontal, 30)
                Spacer()
            }
        }
        .sheet(isPresented: $presentGoalSheet, content: {
            GoalSheet(sheetPresented: $presentGoalSheet, podType: podType)
        })
        NavigationLink("", destination: MembersPodView(), isActive: $navigateToMemberView)
    }
}

#Preview {
    MainPodView(podName: "PodName", podType: .screenTime, timeframe: 2, totalNumStrikes: 7)
}
