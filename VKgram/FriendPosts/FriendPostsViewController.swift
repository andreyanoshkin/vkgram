//
//  FriendPostsViewController.swift
//  VKgram
//
//  Created by Andrey on 18/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class FriendPostsViewController: UIViewController {
    
    lazy var width =  { return ( self.view.frame.size.width - 2 * 2 ) / 3 }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width(), height: width())
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private (set) var userPhotoService = UserPhotoService()
    
    private (set) var storageService = StorageService()
    
    var selectedFriend: User?
    
    var photos = [Photo]()
    
    let cellID = "FriendPostsCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FriendPostsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.pin(to: view)
        
        userPhotoService.getPhotos(userId: selectedFriend!.id)
            .done { photos in
                self.handleGetUserPhotosResponse(photos: photos.items)
        }
        
    }
    
    func handleGetUserPhotosResponse(photos: [Photo]) {
        self.storageService.savePhotos(photos: photos)
        self.photos = self.storageService.loadPhotos()
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FriendPostsCollectionViewCell
        let postFullSizeViewController = PostFullSizeViewController()
        postFullSizeViewController.selectedPostIndex = indexPath.row

        guard photos.count > 0 else { return }
        for photo in photos {
            let photoRepresentable = PhotoRepresentable(photo: photo.mediumPhoto, likes: photo.likesCount, text: photo.text)
            postFullSizeViewController.photos?.append(photoRepresentable)
        }
        
        postFullSizeViewController.modalPresentationStyle = .fullScreen
        self.show(postFullSizeViewController, sender: nil)
    }
    
}

extension FriendPostsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FriendPostsCollectionViewCell
        cell.configure(for: photos[indexPath.row])
        return cell
    }
}

