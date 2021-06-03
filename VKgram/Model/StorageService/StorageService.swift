//
//  StorageService.swift
//  LoginForm
//
//  Created by Andrey on 04/10/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import CoreData

class StorageService {
    
    let coreDataStack = CoreDataStack(modelName: "CoreDataModel")
    
    lazy var viewContext: NSManagedObjectContext = {
        return coreDataStack.persistentContainer.viewContext
    }()
    
    lazy var cacheContext: NSManagedObjectContext = {
        return coreDataStack.persistentContainer.newBackgroundContext()
    }()
    
    lazy var updateContext: NSManagedObjectContext = {
        let _updateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        _updateContext.parent = self.viewContext
        return _updateContext
    }()
    
    func deleteAllData(entity: String)
    {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func getUpdate() {
        let context = coreDataStack.persistentContainer.viewContext
        // Add Observer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context)
        notificationCenter.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: context)
        notificationCenter.addObserver(self, selector: #selector(contextDidSave(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: context)
    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        print(notification)
    }
    func contextWillSave(_ notification: Notification) {
        print(notification)
    }
    @objc func contextDidSave(_ notification: Notification) {
        print(notification)
    }
    
    func saveUsers(users:[User]) {
        let context = updateContext
        for user in users {
            let localUser = NSEntityDescription.insertNewObject(forEntityName: "LocalUser", into: context)
            localUser.setValue(user.id, forKey: "id")
            localUser.setValue(user.firstName, forKey: "firstName")
            localUser.setValue(user.lastName, forKey: "lastName")
            localUser.setValue(user.canAccessClosed, forKey: "canAccessClosed")
            localUser.setValue(user.isClosed, forKey: "isClosed")
            localUser.setValue(user.photo200, forKey: "photo200")
            localUser.setValue(user.verified, forKey: "verified")
        }
        coreDataStack.saveContext()
    }
    
    func loadUsers() -> [User] {
        let context = updateContext
        var users = [User]()
        let localUsers = (try? context.fetch(LocalUser.fetchRequest()) as? [LocalUser] ?? [])
        for localUser in localUsers! {
            let user = User(id: Int(localUser.id),
                            firstName: localUser.firstName,
                            lastName: localUser.lastName,
                            canAccessClosed: localUser.canAccessClosed,
                            isClosed: localUser.isClosed,
                            photo200: localUser.photo200,
                            verified: localUser.verified)
            users.append(user)
        }
        return users
    }
    
    func savePhotos(photos:[Photo]) {
        let context = updateContext
        for photo in photos {
            let localPhoto = NSEntityDescription.insertNewObject(forEntityName: "LocalPhoto", into: context)
            localPhoto.setValue(photo.id, forKey: "id")
            localPhoto.setValue(photo.albumID, forKey: "albumID")
            localPhoto.setValue(photo.date, forKey: "date")
            localPhoto.setValue(photo.height, forKey: "height")
            localPhoto.setValue(photo.ownerID, forKey: "ownerID")
            localPhoto.setValue(photo.photo130, forKey: "photo130")
            localPhoto.setValue(photo.photo604, forKey: "photo604")
            localPhoto.setValue(photo.photo807, forKey: "photo807")
            localPhoto.setValue(photo.text, forKey: "text")
            localPhoto.setValue(photo.width, forKey: "width")
            localPhoto.setValue(photo.postID, forKey: "postID")
            localPhoto.setValue(photo.likes.count, forKey: "likesCount")
            localPhoto.setValue(photo.reposts.count, forKey: "repostsCount")
        }
        coreDataStack.saveContext()
    }
    
    func loadPhotos() -> [Photo] {
        let context = updateContext
        var photos = [Photo]()
        var localPhotos = [LocalPhoto]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalPhoto")
        localPhotos = ( try? context.fetch(fetchRequest)) as! [LocalPhoto]
        for localPhoto in localPhotos {

            let photo = Photo(albumID: Int(localPhoto.albumID),
                              date: Int(localPhoto.date),
                              id: Int(localPhoto.id),
                              ownerID: Int(localPhoto.ownerID),
                              height: Int(localPhoto.height),
                              photo130: localPhoto.photo130,
                              photo604: localPhoto.photo604,
                              photo807: localPhoto.photo807,
                              postID: Int(localPhoto.postID),
                              text: localPhoto.text,
                              width: Int(localPhoto.width),
                              likes: Count(count: Int(localPhoto.likesCount)),
                              reposts: Count(count: Int(localPhoto.repostsCount))
            )
            photos.append(photo)
        }
        return photos
    }
}
