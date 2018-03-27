//
//  ViewController.swift
//  GOOGLE_FB_SigniIn
//
//  Created by Arpit Srivastava on 27/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FacebookCore



class ViewController: UIViewController,GIDSignInUIDelegate{
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slidingViews: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton!

    var toggle:Bool = false
    var name:String?
    var email:String? = "Sign In"
    var menu = ["","HOME","PROFILE","SETTINGS","ABOUT US","RATE US","LOGOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.delegate=self
    }
    @IBAction func fbLogin(_ sender: UIButton) {
        
        if let accessToken = AccessToken.current {
            print(accessToken)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        FacebookSignInManager.basicInfoWithCompletionHandler(self) { (dataDictionary:Dictionary<String, AnyObject>?, error:NSError?) -> Void in
            print(dataDictionary)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    @IBAction func slidingView(_ sender: UIButton) {
        if !toggle{
            self.toggle = !self.toggle
            UIView.animate(withDuration: 1.0, animations: {
                self.slidingViews.transform = CGAffineTransform(translationX: 180, y: 0)
            })
        }else{
            self.toggle = !self.toggle
            UIView.animate(withDuration: 1.0, animations: {
                self.slidingViews.transform = .identity
            })
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell
            cell?.profileIV.image = UIImage(named: "1")
            print(self.name)
            if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            cell?.nameLB.text = self.name
            }else{
                cell?.nameLB.text = "Guest"
            }
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescpCell", for: indexPath) as? DescpCell
            cell?.descLB.text = self.menu[indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }else{
            return 40
        }
    }
}


extension ViewController : SignInSuccess {
    func mydata(_ name: String?, _ email: String?) {
          self.name = name
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC
        self.navigationController?.pushViewController(vc!, animated: true)
        self.tableView.reloadData()
    }
    
    
}

