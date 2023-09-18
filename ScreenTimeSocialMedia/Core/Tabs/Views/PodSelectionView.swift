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
    
    var addPod: (String, groupType) -> Void
    
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
            CustomTextField(text: $name, placeholder: "name of group", type: .text)
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
            Picker("group", selection: $group) {
                ForEach(groupType.allCases, id: \.self) { group in
                    Text(group.rawValue).tag(group)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 200)
            .padding()
            
            Button(action: {
                // Add the new pod and dismiss the sheet
                addPod(name, group)
                isSheetPresented = false
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
