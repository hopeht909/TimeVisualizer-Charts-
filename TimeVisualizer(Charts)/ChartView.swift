//
//  WeeklyToDoItems.swift
//  TimeVisualizer(Charts)
//
//  Created by admin on 15/05/1443 AH.
//

import UIKit
import Charts

class ChartView: UIViewController, ChartViewDelegate {

    let track = ["Income", "Expense", "Wallet"]
    let money = [50.0, 50.0, 50.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateChartData() 
    }
    func updateChartData()  {

       let chart = PieChartView(frame: self.view.frame)
       // 2. generate chart data entries
      

       var entries = [PieChartDataEntry]()
       for (index, value) in money.enumerated() {
           let entry = PieChartDataEntry()
           entry.y = value
           entry.label = track[index]
           entries.append( entry)
       }

       // 3. chart setup
        let set = PieChartDataSet(entries: entries, label: "Pie Chart")
       // this is custom extension method. Download the code for more details.
       var colors: [UIColor] = []

       for _ in 0..<money.count {
           let red = Double(arc4random_uniform(256))
           let green = Double(arc4random_uniform(256))
           let blue = Double(arc4random_uniform(256))
           let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
           colors.append(color)
       }
       set.colors = colors
       let data = PieChartData(dataSet: set)
       chart.data = data
       chart.noDataText = "No data available"
       // user interaction
       chart.isUserInteractionEnabled = true

       let d = Description()
       d.text = "iOSCharts.io"
       chart.chartDescription = d
       chart.centerText = "Pie Chart"
       chart.holeRadiusPercent = 0.2
       chart.transparentCircleColor = UIColor.clear
       self.view.addSubview(chart)

   }
   
}
