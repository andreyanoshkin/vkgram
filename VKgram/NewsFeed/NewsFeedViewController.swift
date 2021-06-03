//
//  NewsFeedViewController.swift
//  VKgram
//
//  Created by Andrey on 20/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import PromiseKit

class NewsFeedViewController: UIViewController, NewsFeedTableViewCellDelegate {
    
    var newsFeedService = NewsFeedService()
    
    var newsFeedGroups = [Group]()
    
    var newsFeedProfiles = [Profile]()
    
    var photos = [String]()
    
    var profilesOfGroups = [ProfileInterface]()
    
    var profilesAndItems = [(profile: ProfileInterface?, newsItem: Item)]()
    
    var cellHeight: CGFloat = 0
    
    var cell = UITableViewCell()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        return refreshControl
    }()
    
    let cellID = "NewsFeedTableViewCell"
    
    let headerID = "NewsFeedCollectionViewHeader"
    
    var nextFrom = ""
    
    var isLoading = false
    
    var currentIndexPathRow: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeedService.getNewsFeedItems().done { result in
            self.handleGetNewsFeedResponse(item: result.0, profile: result.1, group: result.2)
        }
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.pin(to: view)

    }
    
    @objc func refreshNews() {
        
        self.refreshControl.beginRefreshing()
        newsFeedService.getNewsFeedItems().done { result in
            
            self.handleGetNewsFeedResponse(item: result.0, profile: result.1, group: result.2)
        }
    }
    
    
    
    func handleGetNewsFeedResponse(item: ItemResponse, profile: ProfileResponse, group: GroupResponse) {
        let items = item.items
        let profiles = profile.profiles
        let groups = group.groups
        self.nextFrom = item.nextFrom
        
        var profilesOrGroups = [ProfileInterface]()

        for item in items {
        
        if item.sourceID! >= 0 {
            profilesOrGroups = profiles
        } else {
            profilesOrGroups = groups
        }
        
        let positiveSourceId = item.sourceID! >= 0 ? item.sourceID : (item.sourceID! * -1)
        
        let profileDataToDisplay = profilesOrGroups.first(where: {$0.id == positiveSourceId })
            
        let newElement = (profile: profileDataToDisplay, newsItem: item)
        
        profilesAndItems.append(newElement)
            
        }
        
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func revealPost(for cell: NewsFeedTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilesAndItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsFeedTableViewCell
        
        cell.delegate = self
        
        let item = profilesAndItems[indexPath.row]

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configure(item: item.newsItem)
        cell.configureProfile(photo: item.profile?.photo, name: item.profile?.name)
        cell.photoCollageView.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cell.bounds.size.height
    }
    
    private func makeIndexSet(lastIndex: Int, _ newsCount: Int) -> [IndexPath] {
        let last = lastIndex + newsCount
        let indexPaths = Array(lastIndex + 1...last).map { IndexPath(row: $0, section: 0) }
        
        return indexPaths
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postFullSizeViewController = PostFullSizeViewController()
        let item = profilesAndItems[indexPath.row].newsItem
        let likes = String(describing: item.likes?.count)
        let text = item.text!
        guard let photos = item.attachments?.compactMap({$0?.postPhoto}) else { return }
        for photo in photos {
            let photoRepresentable = PhotoRepresentable(photo: photo, likes: likes, text: text)
            postFullSizeViewController.photos?.append(photoRepresentable)
        }
            postFullSizeViewController.selectedPostIndex = 0
        
        self.show(postFullSizeViewController, sender: nil)
    }
    
}

extension NewsFeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {

        guard indexPath.row == profilesAndItems.count - 1 else { return }
        
        guard !isLoading else { return }
            
            let lastIndex = indexPath.row
            isLoading = true
            firstly {
                newsFeedService.getNewsFeedItemsWithStartTime(startFrom: nextFrom)
            }.done { (result) in
                
                self.handleGetNewsFeedResponse(item: result.0, profile: result.1, group: result.2)
                
                let indexPaths = self.makeIndexSet(lastIndex: lastIndex, result.0.items.count)
                tableView.insertRows(at: indexPaths, with: .automatic)
                self.isLoading = false
            }.catch { (error) in
                debugPrint(error.localizedDescription)
                self.isLoading = false
            }
//        }
    }
}
}
