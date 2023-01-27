//
//  ViewController.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "Rodrigo.latorre@outlook.com"
        passwordTextField.text = "rlq12345"
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        viewModel.login(
            email: emailTextField.text!, password: passwordTextField.text!
        ) { token, error in
            if let error = error {
                print(error)
            }
            guard let token = token else {
                return print("no hay token \(token ?? "")")
            }
            self.viewModel.loginSaveToken(token: token)
            DispatchQueue.global(qos: .userInitiated).async {
                self.viewModel.saveCharacters { characters in
                    DispatchQueue.main.async {
                        self.characters = characters
                        self.performSegue(withIdentifier: "goToTable", sender: nil)
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CharactersTableViewController {
            let vc = segue.destination as? CharactersTableViewController
            vc?.characters = characters
        }
    }
}

