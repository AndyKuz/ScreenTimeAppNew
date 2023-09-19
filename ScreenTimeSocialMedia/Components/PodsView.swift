//
//  PodsView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/11/23.
//

import SwiftUI

enum groupType: String, CaseIterable {
    case screenTime = "Screen Time"
}

struct PodsView: View, Identifiable {
    var id = UUID()
    let name: String
    let group: groupType
    
    var groupEmoji: String{
        switch(group) {
        case .screenTime:
            return "⏳"
        }
        
    }

    var body: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Text(name)
                    .font(.title2)
                    .bold()
                Spacer()
                Text(groupEmoji)
                    .font(.subheadline)
            }
            .padding(.horizontal)
        }
        .frame(height: 80)
    }
}
