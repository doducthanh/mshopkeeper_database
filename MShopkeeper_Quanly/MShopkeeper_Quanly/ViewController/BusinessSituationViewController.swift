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
    
    @IBOutlet var lbNameShop: UILabel!
    @IBOutlet var lbAddress: UILabel!
    @IBOutlet var btDate: UIButton!
    
    @IBOutlet var viewChart: UIView!
    @IBOutlet var viewPieChart: UIView!
    @IBOutlet var mytable: UITableView!
    
    var id = 3
    var arrayShop: [Shop] =  [Shop]()
    var arrayRevenue: [Dictionary<String, Any>] = []
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var chart: Chart?
    
    let sideSelectorHeight: CGFloat = 80
    
    fileprivate func drawChart(array: [Int]) {
        if let subview = self.viewChart.viewWithTag(100) {
            subview.removeFromSuperview()
        }
        let barChart = BarChartView.init(frame: CGRect.init(x: 10, y: 10, width: viewChart.frame.width - 10, height: viewChart.frame.height - 60))
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
     
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: ["Thu", "Chi", "Lai"])
        barChart.xAxis.granularityEnabled = true
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelCount = 30
        barChart.xAxis.granularity = 2
        barChart.tag = 100
        //barChart.notifyDataSetChanged()
        self.viewChart.addSubview(barChart)
    }
    
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = MyColors.BLUE
        
        let requestAPI = RequestAPIModel()
        requestAPI.getRevenue(shopID: 3, type: 0) { (status, array) in
            self.drawChart(array: array)
        }
//         lấy về danh sách top doanh thu theo ngay
        getTopRevenue(index: 0)
    }
    
    func getTopRevenue(index: Int) {
        let requestAPI = RequestAPIModel()
        requestAPI.getTopRevenueShop(type: index) { (array) in
            self.arrayRevenue = array
            DispatchQueue.main.async {
                self.mytable.reloadData()
            }
        }
    }
    
    //MARK: onclick
    @IBAction func onClickMenu(_ sender: Any) {
        openLeft()
    }
    
    @IBAction func onClickMoreRevenue(_ sender: Any) {
        let viewTopRevenue = ViewTopRevenue.init(nibName: "ViewTopRevenue", bundle: nil)
        viewTopRevenue.array = self.arrayRevenue
        self.addChildViewController(viewTopRevenue)
        self.view.addSubview(viewTopRevenue.view)
    }
    
    @IBAction func onClickOtherShop(_ sender: Any) {
        // kick vao đây hiển thị danh sách các cửa hàng chi nhánh.
        let requestAPI = RequestAPIModel()
        requestAPI.getShops { (status, arrayShop) in
            let otherVC = OtherShops.init(nibName: "OtherShops", bundle: nil)
            otherVC.arrayShop = arrayShop
            self.arrayShop = arrayShop
            otherVC.delegate = self
            self.present(otherVC, animated: true, completion: nil)
        }
        
    }
    
    /// hàm set sự kiện khi chọn thời gian
    ///
    /// - Parameter sender:
    @IBAction func onClickDate(_ sender: Any) {
        let sheetUI = UIAlertController.init(title: "Tình hình doanh thu", message: "Chọn thời gian thống kê", preferredStyle: .actionSheet)
        let day = UIAlertAction.init(title: "Hôm nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            self.btDate.setTitle("Hôm nay", for: .normal)
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 0) { (status, array) in
                DispatchQueue.main.async {
                    self.drawChart(array: array)
                }
                
            }
        }
        let week = UIAlertAction.init(title: "Tuần nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            self.btDate.setTitle("Tuần này", for: .normal)
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 1) { (status, array) in
                DispatchQueue.main.async {
                    self.drawChart(array: array)
                }
            }
            self.getTopRevenue(index: 1)
        }
        let month = UIAlertAction.init(title: "Tháng nay", style: .default) { (action) in
            if let subview = self.viewChart.viewWithTag(100) {
                subview.removeFromSuperview()
            }
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: self.id, type: 2) { (status, array) in
                DispatchQueue.main.async {
                    self.drawChart(array: array)
                }
            }
            self.btDate.setTitle("Tháng này", for: .normal)
            self.getTopRevenue(index: 2)
        }
        sheetUI.addAction(day)
        sheetUI.addAction(week)
        sheetUI.addAction(month)
        self.present(sheetUI, animated: true, completion: nil)
    }
    
}

extension BusinessSituationViewController: OtherShopDelegate {
    func selectShop(id: Int, shop: Shop) {
        if let subview = self.viewChart.viewWithTag(100) {
            subview.removeFromSuperview()
            self.id = id
            self.lbNameShop.text = shop.shopName
            self.lbAddress.text = shop.address
            //        lấy thông tin doanh số ứng với id cửa hàng.
            let requestAPI = RequestAPIModel()
            requestAPI.getRevenue(shopID: id, type: 0) { (status, array) in
                DispatchQueue.main.async {
                    self.drawChart(array: array)
                }
            }
        }
    }
}

extension BusinessSituationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayRevenue.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! TopRevenuesTableViewCell
        cell.diction = self.arrayRevenue[self.arrayRevenue.count - indexPath.row - 1]
        return cell
    }
}

