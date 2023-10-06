//
//  CustomTextField.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/9/23.
//

import SwiftUI

enum CustomTextFieldType {
    case text
    case secure
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var type: CustomTextFieldType
    @FocusState var isFocused: Bool?
    
    var body: some View {
        switch type {
        case .text:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding()
                        .foregroundColor(DefaultColors.lightGrayColor)
                }
                TextField(placeholder, text: $text)
                    .focused($isFocused, equals: true)
                    .padding()
                    .background(Color.gray.opacity(0.0))
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke((isFocused ?? false) ? DefaultColors.teal1 : DefaultColors.lightGrayColor, lineWidth: 1)
                    }
            }
        case .secure:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding()
                        .foregroundColor(DefaultColors.lightGrayColor)
                }
                SecureField(placeholder, text: $text)
                    .focused($isFocused, equals: true)
                    .padding()
                    .background(Color.gray.opacity(0.0))
                    .cornerRadius(15)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke((isFocused ?? false) ? DefaultColors.teal1 : DefaultColors.lightGrayColor, lineWidth: 1)
                    }
            }
        }
    }
    
}
