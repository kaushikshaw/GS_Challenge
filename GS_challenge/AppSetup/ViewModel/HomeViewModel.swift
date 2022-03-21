//
//  HomeViewModel.swift
//  GS_challenge
//
//  Created by kaushik on 21/03/22.
//

import Foundation
import Bond
import AFNetworking

//MARK: - HomeViewModel class

/// User Home events can be performed here
final class HomeViewModel {
    
    typealias Model = [HomeModel]
    
    typealias Completion = (Model) -> Void
    
    /// Picture of the day detail  model.
    var homeViewModel: HomeModel!
    
    /// `string` for the currentDate
    var currentDate = Observable<String?>("Select Date Of Your Choice")
    
    
    /// `MutableObservableArray` for the acronymResults
    var resultArray = MutableObservableArray<HomeModel>([])
    
    /// Resolve dependency with `PictureofthedayServicesProtocol`.
    var pictureofthedayServices: PictureofthedayServicesProtocol {
        return DependencyResolver.resolvePictureofthedayServices()
    }
    
    /// get Picture of the day
    ///
    /// - Parameter completion: `Completion` value for getting the Pictureoftheday result
    func getPictureOfTheDayForCurrentDate(completion: @escaping Completion){
        if AFNetworkReachabilityManager.shared().isReachable {
            let pictureRecord : [HomeModel] = CoreDataManager.shared.fetchLastupdatedRecord()
            self.resultArray.removeAll()
            self.resultArray.insert(contentsOf: pictureRecord , at: 0)
            completion(pictureRecord)
        }
        else{
            pictureofthedayServices.getNASAPictureoftheday() { [weak self] (response) in
                if (response.count > 0){
                    self?.resultArray.removeAll()
                    self?.resultArray.insert(contentsOf: response , at: 0)
                    completion(response)
                }else{
                    completion(response)
                }
            }
        }
    }
    
    /// get Picture For selected date
    ///
    /// - Parameter completion: `Completion` value for getting the Pictureoftheday result
    func getPictureOfTheDayForSelectedDate(completion: @escaping Completion){
        if AFNetworkReachabilityManager.shared().isReachable {
            let pictureRecord : [HomeModel] = CoreDataManager.shared.fetchLastupdatedRecord()
            self.resultArray.removeAll()
            self.resultArray.insert(contentsOf: pictureRecord , at: 0)
            completion(pictureRecord)
        }
        else{
            guard let date = currentDate.value else {
                return
            }
            pictureofthedayServices.getNASASelectedDayPicture(selectedDate: date) { [weak self] (response) in
                if (response.count > 0){
                    self?.resultArray.removeAll()
                    self?.resultArray.insert(contentsOf: response , at: 0)
                    completion(response)
                }else{
                    completion(response)
                }
            }
        }
    }
}
