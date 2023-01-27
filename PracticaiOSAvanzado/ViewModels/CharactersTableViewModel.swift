//
//  CharactersTableViewModel.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation
import KeychainSwift

final class CharactersTableViewModel {

    private var networkModel: NetworkModel
    private var keyChain: KeychainSwift
    private var coreDataManager: CoreDataManager
    
    let tokenKey = "TOKEN_KEY"
    var characters: [Character] = []

    init(
        networkModel: NetworkModel = NetworkModel(),
        keyChain: KeychainSwift = KeychainSwift(),
        coreDataManager: CoreDataManager = CoreDataManager()
    ) {
        self.networkModel = networkModel
        self.keyChain = keyChain
        self.coreDataManager = coreDataManager
    }
    
    func getCharacters() {
        characters = coreDataManager.fetchCharacter().map {
            Character(
                photo: $0.photo!,
                id: $0.id!,
                favorite: $0.favorite,
                name: $0.name!,
                description: $0.desc!,
                latitud: $0.longitude,
                longitude: $0.latitude
            )
        }
        print("despues del caste a \(characters)")
    }
    
}
