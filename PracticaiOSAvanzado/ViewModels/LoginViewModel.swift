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
    
    func login(email: String, password: String, completion: @escaping () -> Void) {
        //Para borrar core data
        coreDataManager.deleteCoreData(entityName: "CharacterCD")
        //
        networkModel.networkLogin(user: email, password: password) { token, error in
            if let error = error {
                print(error)
            }
            guard let token = token else {
                return print("no hay token \(token ?? "")")
            }
            
            if (token == "testToken") {
                self.keyChain.set(token ?? "fakeToken", forKey: "TestToken")
            }
            print(token)
            self.keyChain.set(token, forKey: self.tokenKey)
            completion()
        }
    }
    
    func saveCharacters(devMode: Bool = false, completion: ( ([Character]) -> Void)?) {
        if(devMode) {
            coreDataManager.deleteCoreData(entityName: "CharacterCD")
            let characters = [
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
            characters.forEach { character in
                self.coreDataManager.createCharacter(character: character)
            }
        } else {
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
                    completion?(networkCharacterArray)
                }
            }
        }
    }
}
