//
//  TotalActivityView.swift
//  MyReportExtension
//
//  Created by Andrew Kuznetsov on 10/14/23.
//

import SwiftUI
import DeviceActivity

struct TotalActivityView: View {
    let totalActivity: String
    
    var body: some View {
        HStack {
            Text(totalActivity)
        }
    }
}
