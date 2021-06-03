//
//  UserGroupsViewController.swift
//
//  Created by Andrey on 05/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit


class UserGroupsViewController: UIViewController {
    
    private (set) var groupsService = GroupsService()
    
    private (set) var storageService = StorageService()
    
    private (set) var appsService = AppsService()
    
    private (set) var groups = [GroupItem]()
    
    private (set) var selectedGroup: GroupItem?
    
    private (set) var apps = [App]()
    
    private let appIds = "7649424_616595797, 7687945_616595797, 7180261, 7453367_616595797, 7385430_616595797, 7624579_616595797, 7629036_616595797, 7647942_616595797, 7577735_616595797"
    
    private (set) var groupHeaderView: UserGroupsHeaderView = {
        let view = UserGroupsHeaderView()
        view.backgroundColor = .lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private (set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let tableViewRowHeight: CGFloat = 40
    
    private let tableViewCellID = "UserGroupsTableViewCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private (set) var filteredGroups: [GroupItem] = []
    
    var groupsToDisplay = [GroupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupCollectionView()
        
        setupConstraints()
        
        tableView.tableHeaderView?.layoutIfNeeded()
        
        getGroups()
        
        getApps()
        
        setupSearchController()
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.register(UserGroupsTableViewCell.self, forCellReuseIdentifier: tableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = groupHeaderView
        tableView.pin(to: view)
    }
    
    private func setupCollectionView() {
        groupHeaderView.collectionView.delegate = self
        groupHeaderView.collectionView.dataSource = self
        groupHeaderView.collectionView.register(AppCell.self, forCellWithReuseIdentifier: AppCell.reuseId)
    }
    
    private func setupSearchBarFont() {
        let textFieldInsideUISearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.font = Constants.Fonts.regularOfSize16
    }
    
    private func getGroups() {
        groupsService.getUserGroups(userId: Int(ApiManager.session.userId)!)
            .done { groups in
                self.handleUserGroupsResponse(groups: groups.items)
                //                print (groups)
        }
    }
    
    private func getApps() {
        appsService.getApps(appIds: appIds)
            .done { apps in
                self.handleAppsResponse(apps: apps.items)
                //                print (groups)
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Groups"
        setupSearchBarFont()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGroups = groups.filter { (group: GroupItem) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased()) 
        }
        tableView.reloadData()
    }
    
    private func handleUserGroupsResponse(groups: [GroupItem]) {
        self.groups = groups
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    private func handleAppsResponse(apps: [App]) {
        self.apps = apps
        DispatchQueue.main.async { self.groupHeaderView.collectionView.reloadData() }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            groupHeaderView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            groupHeaderView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor),
            groupHeaderView.topAnchor.constraint(equalTo: self.tableView.topAnchor),
            groupHeaderView.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func getGroupsToDisplay() {
        
        if isFiltering {
            groupsToDisplay = filteredGroups
            tableView.tableHeaderView?.removeFromSuperview()
            tableView.tableHeaderView? = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        } else {
            groupsToDisplay = groups
            tableView.tableHeaderView = groupHeaderView
            setupConstraints()
        }
        
    }
    
}

extension UserGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getGroupsToDisplay()
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! UserGroupsTableViewCell
        
        cell.configure(for: groupsToDisplay[indexPath.row])
        
        return cell
    }
    
}

extension UserGroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension UserGroupsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCell.reuseId, for: indexPath) as! AppCell
        let app = apps[indexPath.row]
        cell.configure(for: app)
        return cell
    }
    
    
}


