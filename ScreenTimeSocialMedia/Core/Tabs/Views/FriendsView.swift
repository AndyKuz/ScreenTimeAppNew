//
//  GoalsView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct FriendsView: View {
    var tempFriends = 42
    var tempFriendRequests = 3
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 30, height: 32)
                        .padding()
                        
                    if tempFriendRequests > 0 {
                        Text("\(tempFriendRequests)")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.red).frame(width: 20, height: 20))
                            .offset(x: 8, y: -8)
                    }
                }
            }
            Text("\(tempFriends)")
                .font(.title)
                .bold()
                .padding(.top, 70)
            Text("friends")
            SearchBar(text: .constant(""))
                .padding(.top, 20)
            Spacer()
        }
    }
}

#Preview {
    FriendsView()
}
