//
//  ViewController.swift
//  Dynamic.ly
//
//  Created by Vignesh on 11/08/22.
//

import UIKit
import CustomViewPresenter
import SwiftDate
import NavigationKit

class ViewController: UIViewController, NavigationEnabled, SearchEnabled {
    var searchController: UISearchController = UISearchController()
    
    lazy var leftBarButtons: [NavigationKit.BarButtonItem] = [
        .init(identifier: "Settings.title", mode: .image((UIImage(named: "Settings")!.withTintColor(.black).withRenderingMode(.alwaysOriginal))), target: nil, action: nil)
    ]
    
    lazy var rightBarButtons: [NavigationKit.BarButtonItem] = [
        .closeButton(target: self, action: #selector(didTapCloseButton)),
        .backButton(target: self, action: #selector(actionForBackButton))
    ]
    
    var prefersLargeTitle: Bool = true
    
    var showsSearchBar: Bool = true
    
    var hidesNavBarWhileSearch: Bool = true
    
    func didSearch(for text: String?) {
        print("Searched for \(text)")
    }
    
    @objc
    func updateSearchResults(for searchController: UISearchController) {
        didSearch(for: searchController.searchBar.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Header Title", getHeaderTitle(forDate: Date()))
        setupNavigation()
        setupSearch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.set(title: "Older")
            self.set(rightBarButtons: [])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.set(title: "Newbie")
            self.set(rightBarButtons: [
                .closeButton(target: self, action: #selector(self.didTapCloseButton)),
                .backButton(target: self, action: #selector(self.actionForBackButton))
            ])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.set(title: "Work Mode")
            self.set(rightBarButtons: [])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let newVC = NewVC()
//        self.interactivelyPresent(newVC, animated: true) {
//        }
    }
}

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
