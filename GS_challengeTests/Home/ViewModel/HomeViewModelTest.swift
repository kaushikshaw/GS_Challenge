//
//  HomeViewModelTest.swift
//  GS_challengeTests
//
//  Created by kaushik on 21/03/22.
//

import XCTest
@testable import GS_challenge

class HomeViewModelTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        DependencyResolver.container.reset()
        DependencyResolver.configureMockAcronymsServices(MockPictureofthedayServices())
        viewModel = HomeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
}
