//
//  GSConstant.swift
//  GS_challenge
//
//  Created by kaushik on 21/03/22.
//

import Foundation


/// Application constants available here in the form of different enum.
/// This enum is only used for constant purpose, we can create constant by using struct also. But struct will have a chance to initiate, so it behaves as value type.
enum  HomeConstant  {
    
    //MARK: - HomeConstant enum
    
    /// Segue naming identifiers
    enum SegueID {
        // Segue names
    }
    
    /// Pictureoftheday API  Detail
    enum PictureofthedayAPI {
        // Pictureoftheday API
        static let pictureofthedayApiUrl = "https://api.nasa.gov/planetary/apod?api_key=VwjoaBDNAIxliae25GtOOy0IbSKeP5dtPHpkagTH"
        
        static let selectedDatePictureApiUrl = "https://api.nasa.gov/planetary/apod?api_key=VwjoaBDNAIxliae25GtOOy0IbSKeP5dtPHpkagTH&date="
    }
    
    /// GS  AlertDetail
    enum AlertDetail {
        // GS Alert Detail messages
        static let title = "GS"
        static let message = "No matching picture found for given date"
        static let buttonTitle = "OK"
    }
    
    
    /// Picture Detail Cell identifier
    enum PictureDetailIdentifier {
        // Cell identifier
        static let cellIdentifier = "PictureDetailTableViewCell"
    }
}

