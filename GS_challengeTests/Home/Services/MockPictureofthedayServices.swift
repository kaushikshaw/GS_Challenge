//
//  MockPictureofthedayServices.swift
//  GS_challengeTests
//
//  Created by kaushik on 21/03/22.
//

import Foundation
@testable import GS_challenge

class MockPictureofthedayServices: PictureofthedayServicesProtocol {
    func getNASAPictureoftheday(_ completion: @escaping ([HomeModel]) -> Void) {
        
    }
    
    func getNASASelectedDayPicture(selectedDate: String, _ completion: @escaping ([HomeModel]) -> Void) {
        
    }
}
