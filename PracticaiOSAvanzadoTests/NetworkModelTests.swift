//
//  NetworkModelTests.swift
//  PracticaiOSAvanzadoTests
//
//  Created by Rodrigo Latorre on 27/01/23.
//

import XCTest
@testable import PracticaiOSAvanzado

class NetworkModelTests: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        
        sut = NetworkModel(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getHerosSuccess() {
        var error: Error?
        var retrievedHeroes: [Character]?
        
        urlSessionMock.data = getHeroesData(resourceName: "heroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.networkGetHeroes(token: "testToken") { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        
        XCTAssertEqual(retrievedHeroes?.first?.id, "Hero ID")
        XCTAssertNil(error)
    }
    
}

extension NetworkModelTests {
  func getHeroesData(resourceName: String) -> Data? {
    let bundle = Bundle(for: NetworkModelTests.self)
      
    guard let path = bundle.path(forResource: resourceName, ofType: "json") else {return nil}
    
    return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
  }
}
