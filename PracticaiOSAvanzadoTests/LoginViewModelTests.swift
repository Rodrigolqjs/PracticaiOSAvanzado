//
//  LoginViewModelTests.swift
//  PracticaiOSAvanzadoTests
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import XCTest
import KeychainSwift
@testable import PracticaiOSAvanzado

final class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!

    override func setUpWithError() throws {
        sut = LoginViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_login_and_saveToken() {
        let keyChainTest = KeychainSwift()
        sut = LoginViewModel(networkModel: NetWorkModelSpy(), keyChain: keyChainTest)
        sut.login(email: "test@test.com", password: "test") {}

        let token = keyChainTest.get("TestToken")

        XCTAssertEqual(token, "testToken")

    }

    func test_saveHeroes() {
        let coreDataManager = CoreDataManager()
        sut = LoginViewModel(coreDataManager: coreDataManager)
        sut.saveCharacters(devMode: true) {_ in}
        let characters: [Character] = coreDataManager.fetchCharacter().map({ Character(photo: $0.photo!,
                                                                          id: $0.id!,
                                                                          favorite: $0.favorite,
                                                                          name: $0.name!,
                                                                          description: $0.desc!,
                                                                          latitud: $0.latitude,
                                                                          longitude: $0.longitude)})
        let expectedCharacters = [
            Character(
                photo: URL(string: "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg")!,
                id: "test1",
                favorite: true,
                name: "NameTestGoku",
                description: "This is the entire description ofo= this character",
                latitud: Double(0.000),
                longitude: Double(0.000)
            ),
            Character(
                photo: URL(string: "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg")!,
                id: "test2",
                favorite: false,
                name: "NameTestVegeta",
                description: "This is the entire description of this characterTest2",
                latitud: Double(0.000),
                longitude: Double(0.000)
            )
        ]
        XCTAssertEqual(characters, expectedCharacters)
    }
}
