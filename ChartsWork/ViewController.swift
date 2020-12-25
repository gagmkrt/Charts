//
//  ViewController.swift
//  ChartsWork
//
//  Created by Gag Mkrtchyan on 15.11.20.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    var valueColors = [UIColor]()
    var dataEntries = [ChartDataEntry]()

    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
        
    func setView() {
        lineChartView.backgroundColor = .white
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.enabled = true
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.extraBottomOffset = 15
        lineChartView.extraTopOffset = 70
        lineChartView.xAxis.labelCount = 4
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.setVisibleXRangeMaximum(2)
        lineChartView.setScaleEnabled(false)
        lineChartView.resetViewPortOffsets()
        lineChartView.xAxis.labelTextColor = .lightGray
        lineChartView.zoom(scaleX: 2.1, scaleY: 0, x: 0, y: 0)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        
        lineChartView.delegate = self
        
        lineChartView.layer.shadowColor = UIColor.lightGray.cgColor
        lineChartView.layer.shadowOpacity = 1
        lineChartView.layer.shadowOffset = .zero
        lineChartView.layer.shadowRadius = 4
        
        
                
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setData(value: yValues)
        
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "Set1", style: .default) { (changeValue) in
            self.setData(value: self.yvalues2)
            self.labelText.text = "2020 order"
        }
        let alertAction2 = UIAlertAction(title: "Set2", style: .default) { (changeValue) in
            self.setData(value: self.yValues)
            self.labelText.text = "2019 orders graph"
        }
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        
        present(alert, animated: true, completion: nil)

    }
    

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let marker = CustomMarker()
        marker.chartView = lineChartView
        lineChartView.marker = marker
        
        
    }
    
    
    
    func setData(value: [ChartDataEntry]) {
        let set1 = LineChartDataSet(entries: value)
        set1.mode = .horizontalBezier
        set1.lineWidth = 3
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.setColor(.link)
        set1.drawCirclesEnabled = true
        set1.circleRadius = 9
        set1.circleHoleRadius = 4.5
        set1.setCircleColor(.white)
        set1.circleHoleColor = .link
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        lineChartView.data = data
    }
    
        
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0, y: 10),
        ChartDataEntry(x: 1, y: 5),
        ChartDataEntry(x: 2, y: 7),
        ChartDataEntry(x: 3, y: 5),
        ChartDataEntry(x: 4, y: 10),
        ChartDataEntry(x: 5, y: 6),
        ChartDataEntry(x: 6, y: 5),
        ChartDataEntry(x: 7, y: 7),
        ChartDataEntry(x: 8, y: 8),
        ChartDataEntry(x: 9, y: 12),
        ChartDataEntry(x: 10, y: 13),
        ChartDataEntry(x: 11, y: 5),
    ]
    
    let yvalues2: [ChartDataEntry] = [
        ChartDataEntry(x: 0, y: 15),
        ChartDataEntry(x: 1, y: 7),
        ChartDataEntry(x: 2, y: 10),
        ChartDataEntry(x: 3, y: 7),
        ChartDataEntry(x: 4, y: 10),
        ChartDataEntry(x: 5, y: 6),
        ChartDataEntry(x: 6, y: 5),
        ChartDataEntry(x: 7, y: 10),
        ChartDataEntry(x: 8, y: 8),
        ChartDataEntry(x: 9, y: 12),
        ChartDataEntry(x: 10, y: 20),
        ChartDataEntry(x: 11, y: 5),
        ]
}




