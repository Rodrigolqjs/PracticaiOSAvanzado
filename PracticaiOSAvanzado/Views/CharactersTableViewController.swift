//
//  CharactersTableViewController.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    let viewModel = CharactersTableViewModel()
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCharacters()
        if(!viewModel.characters.isEmpty) {
            characters = viewModel.characters
        }
        self.title = "Characters"
        tableView?.register(
            UINib(nibName: "CustomTableViewCell", bundle: nil),
            forCellReuseIdentifier: "customCell"
        )
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No content"
            return cell
        }
        cell.set(customCellModel:
                    CustomCellModel(
                        name: characters[indexPath.row].name,
                        description: characters[indexPath.row].description,
                        photo: characters[indexPath.row].photo
                    )
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      cell.center.x += 50
      UIView.animate(withDuration: 0.5) {
        cell.center.x -= 50
      }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CharacterMapViewController {
            let index = self.tableView.indexPathForSelectedRow!
            let indexNumber = index.row
            let vc = segue.destination as? CharacterMapViewController
            vc?.selectedCharacter = characters[indexNumber]
        }
    }

}
