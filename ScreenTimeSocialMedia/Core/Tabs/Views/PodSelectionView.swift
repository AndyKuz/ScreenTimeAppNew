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
    @State var group: groupType = .screenTime
    @State var numWeeks = 2
    @State var numStrikes = 3
    
    @State var printError = false
    
    var addPod: (String, groupType, Int, Int) -> Void
    
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
                Picker("group", selection: $group) {
                    ForEach(groupType.allCases, id: \.self) { selection in
                        Text(selection.rawValue).tag(selection)
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
                        Text("\(selection) weeks")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            // picker for number of strikes
            HStack {
                Text("Strikes:")
                Picker("strikes", selection: $numStrikes) {
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
                    // Add the new pod and dismiss the sheet
                    addPod(name, group, numWeeks, numStrikes)
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
