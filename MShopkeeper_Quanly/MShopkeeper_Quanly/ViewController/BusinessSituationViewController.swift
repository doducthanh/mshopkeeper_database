//
//  BusinessSituationViewController.swift
//  MShopkeeper_Quanly
//
//  Created by ddthanh on 4/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SwiftCharts
import Charts

class BusinessSituationViewController: UIViewController {

    var chartView: Chart!
    var chartLine: LineChart!
    @IBOutlet var viewChart: UIView!
    @IBOutlet var viewTop1: UIView!
    @IBOutlet var viewTop2: UIView!
    @IBOutlet var viewTop3: UIView!
    
    var id = 3
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var chart: Chart?
    
    let sideSelectorHeight: CGFloat = 80
    
    fileprivate func drawChart(array: [Int]) {
        let barChart = BarChartView.init(frame: CGRect.init(x: 10, y: 10, width: viewChart.frame.width - 20, height: viewChart.frame.height - 60))
        var arrayEntry = [BarChartDataEntry]()
        for index in 0..<array.count {
            let entry1 = BarChartDataEntry(x: Double(index + 1), y: Double(array[index]))
            arrayEntry.append(entry1)
        }
        
        let dataSet = BarChartDataSet(values: arrayEntry, label: "")
        dataSet.colors = [UIColor.blue, UIColor.red, UIColor.orange]
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.4
        barChart.data = data
        
        barChart.legend.enabled = false
        barChart.chartDescription?.text = ""
        barChart.xAxis.axisMinimum = 0.0
        barChart.xAxis.drawLabelsEnabled = false
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.enabled = false
        barChart.tag = 100

        //All other additions to this function will go here
        
        //This must stay at end of function
        barChart.notifyDataSetChanged()
        self.viewChart.addSubview(barChart)
    }
    
    override func viewDidLoad() {
        //showChart(horizontal: false)
        viewTop1.layer.cornerRadius = 3
        viewTop2.layer.cornerRadius = 3
        viewTop3.layer.cornerRadius = 3
        viewTop1.layer.masksToBounds = true
        viewTop2.layer.masksToBounds = true
        viewTop3.layer.masksToBounds = true
        
        let requestAPI = RequestAPIModel()
        requestAPI.getRevenue(shopID: 3, type: 0) { (status, array) in
            self.drawChart(array: array)
        }
    }
    
    //MARK: onclick
    @IBAction func onClickMenu(_ sender: Any) {
        openLeft()
    }
    
    @IBAction func onClickOtherShop(_ sender: Any) {
        // kick vao đây hiển thị danh sách các cửa hàng chi nhánh.
        let requestAPI = RequestAPIModel()
        requestAPI.getShops { (status, arrayShop) in
            let otherVC = OtherShops.init(nibName: "OtherShops", bundle: nil)
            otherVC.arrayShop = arrayShop
            otherVC.delegate = self
            self.present(otherVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func onClickDate(_ sender: Any) {
        let sheetUI = UIAlertController.init(title: "Tình hình doanh thu", message: "Chọn thời gian thống kê", preferredStyle: .actionSheet)
        let day = UIAlertAction.init(title: "Hôm nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 0) { (status, array) in
                self.drawChart(array: array)
            }
        }
        let week = UIAlertAction.init(title: "Tuần nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 1) { (status, array) in
                self.drawChart(array: array)
            }
        }
        let month = UIAlertAction.init(title: "Tháng nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 2) { (status, array) in
                self.drawChart(array: array)
            }
        }
        sheetUI.addAction(day)
        sheetUI.addAction(week)
        sheetUI.addAction(month)
        self.present(sheetUI, animated: true, completion: nil)
    }
}

extension BusinessSituationViewController: OtherShopDelegate {
    func selectShop(id: Int) {
        if let subview = self.viewChart.viewWithTag(100) {
            subview.removeFromSuperview()
        }
        
        let requestAPI = RequestAPIModel()
        requestAPI.getRevenue(shopID: id, type: 0) { (status, array) in
            self.drawChart(array: array)
        }
    }
    
    
}

