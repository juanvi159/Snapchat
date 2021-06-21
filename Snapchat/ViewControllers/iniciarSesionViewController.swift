//
//  ViewController.swift
//  Snapchat
//
//  Created by Juan Vicente Obando Aquice on 5/26/21.
//  Copyright © 2021 Juan Vicente Obando Aquice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class iniciarSesionViewController: UIViewController, GIDSignInDelegate{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
    }

    @IBAction func RegistrarteTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "crearususegue", sender: nil)
    }
    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                let alerta = UIAlertController(title: "Usuario no existe", message: "el Usuario \(self.emailTextField.text!) no exite ", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Crear", style: .default, handler: { (UIAlertAction ) in
                    self.performSegue(withIdentifier: "crearususegue", sender: nil)
                })
                let btncancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alerta.addAction(btnOK)
                alerta.addAction(btncancel)
                self.present(alerta, animated: true, completion: nil)
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    @IBAction func googleTapped(_ sender: Any) {
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error != nil {
        return
      }
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential, completion: { (authResult, error) in
            if (error != nil) {
                return
            }
            
        })
    }

    
    
}

