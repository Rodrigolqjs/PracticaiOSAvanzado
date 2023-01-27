//
//  CharacterMapViewModel.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation
import MapKit

final class CharacterMapViewModel {
    
    let coreDataManager = CoreDataManager()
    let manager = CLLocationManager()
    
    var character: Character? = nil
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            manager.requestAlwaysAuthorization()
        } else {
            //Errors
        }
    }
    
    func getCharacterAnnotation(completion: (MKAnnotation) -> Void ) {
        guard let character = character else {return print("no llego un character al viewModel map")}
        let dataDevuelta: [CharacterCD] = coreDataManager.fetchCharacter(with: NSPredicate(format: "name LIKE %@", "\(character.name)"))
        
        let annotation = MKPointAnnotation()
        annotation.title = dataDevuelta[0].name
        annotation.coordinate = CLLocationCoordinate2D(latitude: dataDevuelta[0].latitude, longitude: dataDevuelta[0].longitude)
        completion(annotation)
    }
}
