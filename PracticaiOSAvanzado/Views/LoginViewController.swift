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
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    let viewModel = LoginViewModel()
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextField.text != "") {
            loading.startAnimating()
            viewModel.login(
                email: emailTextField.text!, password: passwordTextField.text!
            ) { error in
                if (error != nil) {
                    DispatchQueue.main.async {
                        self.loading.stopAnimating()
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.loginButton.isEnabled = false
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    self.viewModel.saveCharacters { characters in
                        DispatchQueue.main.async {
                            self.loading.stopAnimating()
                            self.characters = characters
                            self.performSegue(withIdentifier: "goToTable", sender: nil)
                        }
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

