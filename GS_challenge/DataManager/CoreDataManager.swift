//
//  CoreDataManager.swift
//  GS_challenge
//
//  Created by Kaushik on 21/03/22.
//

import Foundation
import CoreData

// A NSPersistentContainer property to perform coredata action
var persistentContainer: NSPersistentContainer? = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "GS_challenge")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

public class CoreDataManager: ObservableObject {
    
    // A singleton for our entire app to use
    public static let shared = CoreDataManager()
}


extension CoreDataManager {
    
    private func clearCoreDataStore() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NASAPicture")
        let deleteReqest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer?.viewContext.execute(deleteReqest)
        } catch {
            print(error)
        }
    }
    
    func maintanePictureRecord(_ model: HomeModel) {
        clearCoreDataStore()
        guard let container = persistentContainer else { return }
        let pictureDetail = NASAPicture(context: container.viewContext)
        pictureDetail.copyright = model.copyright
        pictureDetail.date = model.date
        pictureDetail.hdurl = model.hdurl
        pictureDetail.url = model.url
        pictureDetail.explanation = model.explanation
        pictureDetail.title = model.title
        pictureDetail.mediaType = model.mediaType
        pictureDetail.serviceVersion = model.serviceVersion
        do {
            try container.viewContext.save()
            print("Picture saved succesfuly")
        } catch let error {
            print("Failed to save picture: \(error.localizedDescription)")
        }
    }
    
    func fetchLastupdatedRecord() -> [HomeModel] {
        let fetchRequest = NSFetchRequest<NASAPicture>(entityName: "NASAPicture")
        do {
            let fetchedResults = try persistentContainer?.viewContext.fetch(fetchRequest)
            guard let pictureResult = fetchedResults else {
                return []
            }
            let pictureObject: NASAPicture = pictureResult[0]
            return [HomeModel(copyright: pictureObject.copyright, date: pictureObject.date, explanation: pictureObject.explanation, hdurl: pictureObject.hdurl, mediaType: pictureObject.mediaType, serviceVersion: pictureObject.serviceVersion, title: pictureObject.title, url: pictureObject.url)]
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return []
    }
}

