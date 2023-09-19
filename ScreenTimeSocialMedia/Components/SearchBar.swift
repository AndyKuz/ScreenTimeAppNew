//
//  SearchBar.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/17/23.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $text, onEditingChanged: { editing in
                    isEditing = editing // Update isEditing when editing state changes
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .padding(.horizontal, 40)
                
            }
            if isEditing {
                Text("currently editing")
                    .foregroundColor(.red)
            }
        }
    }
}
