//
//  PieChartView.swift
//  MyReportExtension
//
//  Created by Andrew Kuznetsov on 10/15/23.
//

import Foundation
import SwiftUI

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieSliceView: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                Text(pieSliceData.text)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PieChartView: View {
    let totalActivity: Double
    
    var mainSlice: PieSliceData {
        let total = 24.0
        var endDeg: Double = 0
        
        let degrees: Double = totalActivity * 360 / total
        return PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", totalActivity * 100 / total), color: Color(red: 0.0666, green: 0.8275, blue: 0.6667))
    }
    
    public var widthFraction: CGFloat = 0.75
    public var innerRadiusFraction: CGFloat = 0.60
    
    @State private var activeIndex: Int = -1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                PieSliceView(pieSliceData: mainSlice)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                
                Circle()
                    .fill(.black)
                    .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                
                VStack {
                    Text("Total")
                        .font(.title)
                        .foregroundColor(Color.gray)
                    Text(String(totalActivity))
                        .font(.title)
                }
            }
            .background(.black)
            .foregroundColor(Color.white)
        }
    }
}
