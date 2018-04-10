//
//  ChartViewModel.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

// thực hiện tạo các biểu đồ
import Foundation
import UIKit
import SwiftCharts

class ChartViewModel {
 
    func barsChart(frame: CGRect) -> BarsChart {
        let chartPoints = [("Thu", 108.0), ("Chi", 39.0), ("Lai", 69.0)]
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 20, by: 6)
        )
        let chartFrame = CGRect.init(x: 0, y: frame.origin.y + 70, width: frame.width, height: frame.height - 70)
        let chart = BarsChart(
            frame: chartFrame,
            chartConfig: chartConfig,
            xTitle: "",
            yTitle: "",
            bars: chartPoints,
            color: UIColor.red,
            barWidth: 25
        )
        return chart
    }
    
    
}
