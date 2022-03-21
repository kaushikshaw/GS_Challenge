//
//  PictureofthedayServices.swift
//  GS_challenge
//
//  Created by kaushik on 20/03/22.
//

import Foundation
import AFNetworking

/**
 *  class `PictureofthedayServices` defines set of  fuction to communicate with the network APIs
 */
class PictureofthedayServices: PictureofthedayServicesProtocol {
    
    var nasaPictures: [HomeModel] = []
    
    /// get NASA Picture of the day
    ///
    /// - Parameters:
    ///   - Pictureoftheday: string` of 'Picture of the day`
    ///   - completion: type of `[HomeModel]` for matching PictureofthedayServices
    func getNASAPictureoftheday(_ completion: @escaping ([HomeModel]) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.get(HomeConstant.PictureofthedayAPI.pictureofthedayApiUrl
                    , parameters: nil, headers: nil, progress: nil, success: { task, object in
            guard let data = object as? Data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(HomeModel.self, from: data)
                self.nasaPictures.append(response)
                CoreDataManager.shared.maintanePictureRecord(response)
                completion(self.nasaPictures)
            } catch {
                print(error)
            }
        }, failure: { task, error in
            let pictureRecord : [HomeModel] = CoreDataManager.shared.fetchLastupdatedRecord()
            self.nasaPictures.append(pictureRecord.first!)
            completion(self.nasaPictures)
        })
    }
    
    /// get NASA Selected Day Picture
    ///
    /// - Parameters:
    ///   - Pictureoftheday: string` of 'Selected Day Picture`
    ///   - completion: type of `[HomeModel]` for matching SelectedDayPicture
    func getNASASelectedDayPicture(selectedDate: String, _ completion: @escaping ([HomeModel]) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.get(HomeConstant.PictureofthedayAPI.selectedDatePictureApiUrl + selectedDate
                    , parameters: nil, headers: nil, progress: nil, success: { task, object in
            guard let data = object as? Data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(HomeModel.self, from: data)
                CoreDataManager.shared.maintanePictureRecord(response)
                self.nasaPictures.append(response)
                completion(self.nasaPictures)
            } catch {
                print(error)
            }
        }, failure: { task, error in
            let pictureRecord : [HomeModel] = CoreDataManager.shared.fetchLastupdatedRecord()
            self.nasaPictures.append(pictureRecord.first!)
            completion(self.nasaPictures)
        })
    }
}
