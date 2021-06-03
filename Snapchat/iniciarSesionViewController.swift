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
import GoogleSignIn

class iniciarSesionViewController: UIViewController, GIDSignInDelegate{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presento el siguiente error: \(error)")
            }else{
                print("Inicio de sesion exitoso")
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

