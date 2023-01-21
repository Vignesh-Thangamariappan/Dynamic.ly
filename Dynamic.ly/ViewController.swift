//
//  ViewController.swift
//  Dynamic.ly
//
//  Created by Vignesh on 11/08/22.
//

import UIKit
import CustomViewPresenter
import SwiftDate

class NewVC: UIViewController, CustomViewPresentable {
    func didChangeToFullScreen() {
        
    }
    
    var heightForMiniMode: CGFloat? = UIScreen.main.bounds.height * 0.4
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func loadView() {
        view = customView
    }
}

extension Date {
    
    var weekStartDate: Date {
        return self.calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self.dateAt(.startOfDay))) ?? Date()
    }
    
    var weekEndDate: Date {
        self.weekStartDate.dateByAdding(6, .day).date
    }
}

var monthTitleStyle: SymbolFormatStyle = .short
var shouldDisplayCurrentYearOnMonthTitle = false

public func getHeaderTitle(
    forDate activeDate: Date
) -> String {
    
    let title: String
//    switch mode {
//    case .monthly, .hidden:
//        let monthStr = activeDate.monthName(monthTitleStyle)
//        let yearStr = activeDate.year
//        title = (activeDate.year == Date().year) && !shouldDisplayCurrentYearOnMonthTitle ? monthStr : monthStr + " " + yearStr.description
//    case .weekly:
    let weekStart = activeDate.dateAtStartOf(.day)
        let weekEnd = activeDate.weekEndDate
        let monthStr = weekStart.monthName(monthTitleStyle)
        let yearStr = activeDate.year
        if weekEnd.month == activeDate.month && weekStart.month == activeDate.month {
            title = (weekStart.year == Date().year) && !shouldDisplayCurrentYearOnMonthTitle ? monthStr : monthStr + " " + yearStr.description
        } else {
            let nextMonthStr = weekEnd.monthName(monthTitleStyle)
            
            /// THIS RETURNS `MNT - MNT YYYY` instead
            if weekEnd.year == activeDate.year {
                let monthTitle = "\(monthStr) - \(nextMonthStr)"
                title = (activeDate.year == Date().year) && !shouldDisplayCurrentYearOnMonthTitle ? monthTitle : monthTitle + " " + yearStr.description
            } else {
                title = "\(monthStr) \(weekStart.year) - \(nextMonthStr) \(weekEnd.year)"
            }
        }
//    }
    return title
}
