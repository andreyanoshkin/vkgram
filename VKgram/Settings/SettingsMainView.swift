//
//  SettingsMainView.swift
//  VKgram
//
//  Created by Andrey on 31/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class SettingsMainView: UIView {
    
    private (set) var sectionHeaderView: SectionHeaderView = {
        let view = SectionHeaderView()
        view.backgroundColor = UIColor.red
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private (set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let cellID = "AccountTableViewCell"
    
    let sectionHeaderViewID = "SectionHeaderView"
    
    private let tableViewRowHeight: CGFloat = 52
    
    private let tableViewHeaderInSectionHeight: CGFloat = 40
    
    private let tableViewFooterInSectionHeight: CGFloat = 36
    
    var accountData: [SectionData]?
    
    var parentViewController: SettingsViewController?
    
    func configureTableView() {
        
        self.addSubview(tableView)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .white
    tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellID)
    tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderViewID)
    tableView.delegate = self
    tableView.dataSource = self
    setupConstraints()
    tableView.tableHeaderView?.layoutIfNeeded()
        
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               
               tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
               tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
           ])
       }
    
}

extension SettingsMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (accountData?[section].rowTitles.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingsTableViewCell
        
        cell.selectionStyle = .none
        
        let sectionData = accountData?[indexPath.section]
        
        let rowTitle = sectionData?.rowTitles[indexPath.row].title
        
        let switchIsShown = sectionData?.switchIsShown
        
        cell.configure(rowTitle: rowTitle!, switchIsShown: switchIsShown!, row: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderInSectionHeight
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewFooterInSectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderViewID) as! SectionHeaderView
        header.sectionNameLabel.text = accountData?[section].sectionTitle
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sectionData = accountData?[indexPath.section]
        
        let VC = sectionData!.rowTitles[indexPath.row].VC  as! UIViewController

        parentViewController?.show(VC, sender: nil)
    }
    
}

