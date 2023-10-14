//
//  RowButtonView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/13/23.
//

import Foundation
import SwiftUI

struct RowButton: View {
    @Binding var isSet: Bool
    var imageName: String
    var buttonColor: Color
    
    var body: some View {
        Image(systemName: isSet ? "\(imageName).fill" : imageName)
            .foregroundColor(isSet ? buttonColor : .gray)
            .font(.system(size: 22))
            .onTapGesture {
                isSet.toggle()
            }
    }
}
