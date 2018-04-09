//
//  BusinessSituationViewController.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SwiftCharts

class BusinessSituationViewController: UIViewController {

    @IBOutlet weak var viewScroll: UIView!
    var chartView: BarsChart!
    @IBOutlet weak var viewChartRevenue: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //ConfigChart()
    }

    override func viewDidAppear(_ animated: Bool) {
        ConfigChart()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func ConfigChart() {
        let charConfig = BarsChartConfig.init(valsAxisConfig: ChartAxisConfig(from: 0, to: 10, by: 2))
        let frame = CGRect.init(x: 0, y: 0, width: self.viewChartRevenue.frame.width, height: self.viewChartRevenue.frame.height)
        let chart = BarsChart.init(frame: frame,
                                   chartConfig: charConfig,
                                   xTitle: "",
                                   yTitle: "",
                                   bars: [("thu", 2),
                                          ("chi", 4),
                                          ("loi nhuan", 7.5)],
                                   color: .blue,
                                   barWidth: 20)
        
        self.viewChartRevenue.addSubview(chart.view)
        self.chartView = chart
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

