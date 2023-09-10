//
//  ScreenTimeSelectAppsView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/9/23.
//

import SwiftUI
import FamilyControls

struct ScreenTimeSelectAppsView: View {
    @State private var pickerIsPresented = false
    @ObservedObject var model: ScreenTimeSelectAppsModel
    
    var body: some View {
        Button {
            pickerIsPresented = true
        } label: {
            Text("Select Apps")
        }
        .familyActivityPicker(
            isPresented: $pickerIsPresented,
            selection: $model.activitySelection
        )
    }
}
