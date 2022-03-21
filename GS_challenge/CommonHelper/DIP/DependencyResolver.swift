//
//  DependencyResolver.swift
//  GS_challenge
//
//  Created by Kaushik on 20/03/22.
//

import Foundation
import Dip

// MARK: - DependencyResolver struct

/**
 *  Struct for describing Dip configuration for all protocols.
 *  - container -  DependencyResolver instance
 *  - `configure()` configure using DIP container.
 */

/// Dependency Resolver provides Dip container references to the available services in GS application.
struct DependencyResolver {
    
    static let container: DependencyContainer = DependencyContainer()
    
    /// Dip configuration
    static func configure()  {
        
        /// Register all validators
        self.container.register(.shared) { PictureofthedayServices() as PictureofthedayServicesProtocol }
    }
}

// MARK: - PictureofthedayServices
extension DependencyResolver {
    
    /// `PictureofthedayServices` interacts with NASA Pictureoftheday API.
    ///
    /// - Returns: 'PictureofthedayServicesProtocol'.
    static func resolvePictureofthedayServices() -> PictureofthedayServicesProtocol {
        return try! container.resolve() as PictureofthedayServicesProtocol
    }
}

