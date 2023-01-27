//
//  LoginViewModel.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation
import KeychainSwift

final class LoginViewModel {
    
    private var networkModel: NetworkModel
    private var keyChain: KeychainSwift
    private var coreDataManager: CoreDataManager
    
    let tokenKey = "TOKEN_KEY"

    init(
        networkModel: NetworkModel = NetworkModel(),
        keyChain: KeychainSwift = KeychainSwift(),
        coreDataManager: CoreDataManager = CoreDataManager()
    ) {
        self.networkModel = networkModel
        self.keyChain = keyChain
        self.coreDataManager = coreDataManager
    }
    
    func loginSaveToken(token: String) {
        keyChain.set(token, forKey: tokenKey)
    }
    
    func login(email: String, password: String, completion: ((String?, (Error)?) -> Void)?) {
        //Para borrar core data
        coreDataManager.deleteCoreData(entityName: "CharacterCD")
        //
        networkModel.networkLogin(user: email, password: password, completion: completion)
    }
    
    func saveCharacters(completion: @escaping ([Character]) -> Void) {
        guard let token = keyChain.get(tokenKey) else {return print("no hay token en viewModel")}
        if(coreDataManager.fetchCharacter().isEmpty) {
            networkModel.networkGetHeroes(token: token) { networkCharacterArray, error in
                if let error = error {
                    print("este es el error LoginViewModel \(error)")
                }
                networkCharacterArray.forEach { character in
                    self.networkModel.networkGetLocalizacionHeroe(token: token, id: character.id, completion: { coordenates, error in
                        let coords = coordenates.first
                        let coreDataCharacter = Character(
                            photo: character.photo,
                            id: character.id,
                            favorite: character.favorite,
                            name: character.name,
                            description: character.description,
                            latitud: Double(coords?.latitud ?? "0.0"),
                            longitude: Double(coords?.longitud ?? "0.0")
                        )
                        self.coreDataManager.createCharacter(character: coreDataCharacter)
                    })
                }
                completion(networkCharacterArray)
            }
        }
    }
}
