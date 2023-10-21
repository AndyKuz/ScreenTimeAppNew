//
//  TextView.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 10/1/23.
//

import SwiftUI

struct TextView: View {
    var contentMessage: String
    var isCurrentUser: Bool
        
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? DefaultColors.teal1 : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}
