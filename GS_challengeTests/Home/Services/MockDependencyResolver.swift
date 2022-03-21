//
//  MockDependencyResolver.swift
//  GS_challengeTests
//
//  Created by Kaushik on 21/03/22.
//

import Foundation
@testable import GS_challenge

extension DependencyResolver {
    
    /// Dip configuration
    ///
    /// - Returns: registered class will be returned
    
   // Register Mock Github Service
      static func configureMockAcronymsServices(_ mockPictureofthedayServices: PictureofthedayServicesProtocol) {
          self.container.register(.singleton) { mockPictureofthedayServices as PictureofthedayServicesProtocol }
      }
}

