//
//  PodViewSelectionView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/12/23.
//

import SwiftUI

struct PodSelectionView: View {
    @Binding var isSheetPresented: Bool
    
    @State var name = ""
    @State var podType: groupType = .screenTime // default picker value
    @State var goal: Int = 2 // default picker value
    @State var numWeeks: Int = 2 // default picker value
    @State var totalStrikes: Int = 3 // default picker values
    
    @State var printError = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Dismiss the sheet when the cancel button is tapped
                    isSheetPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Text("Configure Your Pod")
                .font(.largeTitle)
                .padding()
                .padding(.bottom, 40)
            
            // if done button clicked w/ no name specified show error
            if printError {
                Text("Please provide a name")
                    .foregroundColor(.red)
            }
            
            // textfield to select pod name
            CustomTextField(text: $name, placeholder: "name of group", type: .text)
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
            
            // picker for pod type [screentime]
            HStack {
                Text("Pod Type:")
                Picker("group", selection: $podType) {
                    ForEach(groupType.allCases, id: \.self) { selection in
                        Text(selection.rawValue).tag(selection)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            // picker for daily pod goal
            HStack {
                Text("Daily Goal")
                Picker("goal", selection: $goal) {
                    ForEach([2, 3, 4, 5], id: \.self) { selection in
                        Text("\(selection) hours")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            // picker for timeframe of pod
            HStack {
                Text("Timeframe:")
                Picker("timeframe", selection: $numWeeks) {
                    ForEach([2,4,8,12], id: \.self) { selection in
                        Text("\(selection) weeks").tag(selection)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            // picker for number of strikes
            HStack {
                Text("Strikes:")
                Picker("strikes", selection: $totalStrikes) {
                    ForEach([3,4,5,6,7,8,9,10], id: \.self) { selection in
                        Text("\(selection) strikes")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            // button to confirm selections
            Button(action: {
                if name.isEmpty {
                    // shows error message if name not specified
                    printError = true
                    
                } else {
                    // add new pod in firestore
                    FirestoreFunctions.system.createPod(pod: Pods(podID: "temp", title: name, podType: podType, totalStrikes: totalStrikes, currentStrikes: 0, goal: goal, timeframe: Double(numWeeks), started: false, failedDays: [], completedDays: 0))
                    
                    // dismiss the sheet
                    isSheetPresented = false
                }
            }) {
                Text("Done")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
            
        }
    }
}
