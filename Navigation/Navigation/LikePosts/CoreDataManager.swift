//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Vadim on 04.08.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var postArray: [LikePosts] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "PostModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        return context
    }()
    //
    //    private lazy var managedObjectModel: NSManagedObjectModel = {
    //        guard let modelURL = Bundle.main.url(forResource: "PostModel", withExtension: "momd") else { fatalError() }
    //        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else { fatalError() }
    //        return managedObjectModel
    //    }()
    //
    //    private var persistentStoreURL: NSURL {
    //        let storeName = "PostModel.sqlite"
    //        let fileManager = FileManager.default
    //        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //        return documentsDirectoryURL.appendingPathComponent(storeName) as NSURL
    //    }
    //
    //    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    //        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    //
    //        do {
    //            let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
    //            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.persistentStoreURL as URL, options: options)
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //        return persistentStoreCoordinator
    //    }()
    //
    //    private lazy var mainManagedObjectContext: NSManagedObjectContext = {
    //        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    //        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    //        return managedObjectContext
    //    }()
    
    func savePost(index: Int, post: [Post]) {
        guard let favoritePost = NSEntityDescription.insertNewObject(forEntityName: "PostCoreDataModel", into: self.backgroundContext) as? PostCoreDataModel else { return }
        let fetchRequest = PostCoreDataModel.fetchRequest()
        let posts = try! backgroundContext.fetch(fetchRequest)
        for i in posts {
            if i.title != post[index].title {
                favoritePost.descript = post[index].description
                favoritePost.image = post[index].image
                favoritePost.title = post[index].title
                favoritePost.likes = Int16(post[index].likes)
                favoritePost.views = Int16(post[index].views)
                favoritePost.author = post[index].author
                do {
                    try self.backgroundContext.save()
                } catch {
                    print("Ошибка сохранения")
                }
            } else {
                print("dublicate")
            }
        }
    }
    
    func getPost(callback: () -> Void) {
        CoreDataManager.shared.postArray.removeAll()
        let fetchRequest = PostCoreDataModel.fetchRequest()
        do {
            let posts = try backgroundContext.fetch(fetchRequest)
            for i in posts {
                let tempPost = LikePosts(title: i.title ?? "",
                                         description: i.descript ?? "",
                                         image: i.image ?? "",
                                         likes: Int(i.likes),
                                         views: Int(i.views),
                                         author: i.author ?? "")
                if CoreDataManager.shared.postArray.contains(where: {$0.title == tempPost.title}) == false {
                    CoreDataManager.shared.postArray.append(tempPost)
                    print(CoreDataManager.shared.postArray)
                }
            }
        } catch {
            fatalError()
        }
        callback()
    }
    
    func update(author: String, completion: @escaping ([LikePosts]) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            var filterPost: [LikePosts] = []
            let fetchRequest = PostCoreDataModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "author CONTAINS[cd] %@", author)
            do {
                let filtred = try self.backgroundContext.fetch(fetchRequest)
                for post in filtred {
                    let tempPost = LikePosts(title: post.title ?? "",
                                             description: post.descript ?? "",
                                             image: post.image ?? "",
                                             likes: Int(post.likes),
                                             views: Int(post.views),
                                             author: post.author ?? "")
                    if filterPost.contains(where: {$0.title == tempPost.title}) == false {
                        filterPost.append(tempPost)
                        print(CoreDataManager.shared.postArray)
                    }
                }
            } catch {
                fatalError()
            }
            completion(filterPost)
        }
    }
    
    func delete(index: Int, callback: () -> Void) {
        let fetchRequest = PostCoreDataModel.fetchRequest()
        do {
            let posts = try backgroundContext.fetch(fetchRequest)
            for i in posts.indices {
                if i == index {
                    backgroundContext.delete(posts[i])
                    CoreDataManager.shared.postArray.remove(at: i)
                }
            }
            try backgroundContext.save()
            
        } catch {
            fatalError()
        }
        callback()
    }
}

