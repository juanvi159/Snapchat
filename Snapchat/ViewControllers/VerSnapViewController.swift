//
//  VerSnapViewController.swift
//  Snapchat
//
//  Created by Juan Vicente Obando Aquice on 6/20/21.
//  Copyright © 2021 Juan Vicente Obando Aquice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class VerSnapViewController: UIViewController {
    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var imagenView: UIImageView!
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMensaje.text = "Mensaje: " + snap.descrip
        imagenView.sd_setImage(with: URL(string: snap.imagenURL), completed: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.id).removeValue()
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete{ (error) in
            print("Se elimino la imagen correctamente")
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
