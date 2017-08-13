//
//  ViewController.swift
//  Social-fire
//
//  Created by Samwel Charles on 13/08/2017.
//  Copyright © 2017 younggeeks. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase
class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func fbLoginBtnPressed(_ sender: UIButton) {
       let loginMgr = LoginManager()
        loginMgr.logIn([.publicProfile], viewController: self, completion: { result in
            switch result {
            case .failed(let error ):
                print("Login Error ",error)
             
            case .cancelled:
                print("User Cancelled Logging in ")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
               let credential  = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
        })
        
        
        
    }
    
    func firebaseAuth(_ credentials: AuthCredential){
        Auth.auth().signIn(with: credentials, completion: { (user,error) in
            if error != nil {
                print("Unable to authenticate with firebase",error)
            }else{
                print("Successfully authenticated with firebase")
            }
        })
    }




}

