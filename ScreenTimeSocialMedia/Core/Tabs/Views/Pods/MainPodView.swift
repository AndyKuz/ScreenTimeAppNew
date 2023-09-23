//
//  MainPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/22/23.
//

import SwiftUI

// View for main screen of every pod
struct MainPodView: View {
    @State var podName: String
    @State var podType: groupType
    @State var timeFrame: Int
    @State var totalNumStrikes: Int
    var body: some View {
        ZStack {
            // friends button in the top right corner
            HStack {
                Spacer() // pushes friends button all the way right
                VStack {
                    Button(action: { EmptyView() }) {
                        Image(systemName: "people.2")
                    }
                    Spacer() // pushes friends button all the way up
                }
            }
            
            VStack {
                Text(podName)
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 7)
                Text("0/\(totalNumStrikes) Strikes")
                    .padding(.horizontal, 30)
                Spacer()
            }
        }
    }
}
