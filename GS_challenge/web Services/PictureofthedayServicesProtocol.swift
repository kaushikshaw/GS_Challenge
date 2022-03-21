//
//  PictureofthedayServicesProtocol.swift
//  GS_challenge
//
//  Created by kaushik on 20/03/22.
//

import Foundation

/**
 *  Protocol `PictureofthedayServicesProtocol` defines set of protocols for `PictureofthedayServices`
 */
protocol PictureofthedayServicesProtocol {
    
    /// get NASA Picture of the day
    ///
    /// - Parameters:
    ///   - Pictureoftheday: string` of 'Picture of the day`
    ///   - completion: type of `[HomeModel]` for matching PictureofthedayServices
    func getNASAPictureoftheday(_ completion: @escaping ([HomeModel]) -> Void)
    
    
    /// get NASA Selected Day Picture
    ///
    /// - Parameters:
    ///   - Pictureoftheday: string` of 'Selected Day Picture`
    ///   - completion: type of `[HomeModel]` for matching SelectedDayPicture
    func getNASASelectedDayPicture(selectedDate: String, _ completion: @escaping ([HomeModel]) -> Void)

}

