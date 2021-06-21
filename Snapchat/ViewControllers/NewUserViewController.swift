//
//  NewUserViewController.swift
//  Snapchat
//
//  Created by Juan Vicente Obando Aquice on 6/8/21.
//  Copyright © 2021 Juan Vicente Obando Aquice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class NewUserViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var contra: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func crearUsuarioTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: nombre.text!, password: contra.text!) {(user, error) in
             if error != nil{
                 print("Se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.nombre.text!, password: self.contra.text!, completion:{(user, error) in
                     print("Intentando crear un usuario")
                     if error != nil{
                         print("Se presento el siguienta error al crear el usuario: \(error)")
                     }else{
                         print("El usuario fue creado exitosamente")
                     Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario \(self.nombre.text!) se creo correctamente ", preferredStyle: .alert)
                         let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction ) in
                             self.performSegue(withIdentifier: "usucreadosegue", sender: nil)
                         })
                         alerta.addAction(btnOK)
                         self.present(alerta, animated: true, completion: nil)
                     }
                 })
             }else{
                print("Usuario ya existente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                   let alerta = UIAlertController(title: "Usuario existente", message: "Usuario \(self.nombre.text!) ya existe, creo otro ", preferredStyle: .alert)
                    let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction ) in
                    })
                    alerta.addAction(btnOK)
                    self.present(alerta, animated: true, completion: nil)
                 
             }
         }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
