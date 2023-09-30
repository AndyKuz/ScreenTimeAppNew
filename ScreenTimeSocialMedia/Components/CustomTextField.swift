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
                if text.isEmpty {   // if nothing typed in textfield add placeholder
                    Text(placeholder)
                        .foregroundColor(DefaultColors.lightGray2)
                        .padding()
                }
                TextField("", text: $text)
                    .focused($isFocused, equals: true)
                    .padding()
                    .background(Color.gray.opacity(0.0))
                    .foregroundColor(DefaultColors.lightGray2)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke((isFocused ?? false) ? DefaultColors.teal1 : DefaultColors.lightGray2, lineWidth: 2)
                    }
            }
        case .secure:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(DefaultColors.lightGray2)
                        .padding()
                }
                SecureField(placeholder, text: $text)
                    .focused($isFocused, equals: true)
                    .padding()
                    .background(Color.gray.opacity(0.0))
                    .foregroundColor(DefaultColors.lightGray2)
                    .cornerRadius(10)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke((isFocused ?? false) ? DefaultColors.teal1 : DefaultColors.lightGray2, lineWidth: 2)
                    }
            }
        }
    }
    
}
