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



class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
 
    @IBOutlet weak var signoutBT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slidingViews: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var timerLB: UILabel!
    @IBOutlet weak var sessionLB: UILabel!
    
    var toggle:Bool = false
    var name:String?
    var email:String? = "Sign In"
    var menu = ["","HOME","PROFILE","SETTINGS","ABOUT US","RATE US","LOGOUT"]
    var countdownTimer: Timer!
    var totalTime = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.sessionLB.isHidden = true
        self.timerLB.isHidden = true
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.delegate=self
        if !GIDSignIn.sharedInstance().hasAuthInKeychain(){
            self.signoutBT.isEnabled = false
        }else{
            self.signInButton.isEnabled = false
        }
        GIDSignIn.sharedInstance().delegate = self
    }
    @IBAction func fbLogin(_ sender: UIButton) {
        self.sessionLB.isHidden = false
        self.timerLB.isHidden = false
        self.totalTime = 60
        self.startTimer()
        if let accessToken = AccessToken.current {
            print(accessToken)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        FacebookSignInManager.basicInfoWithCompletionHandler(self) { (dataDictionary:Dictionary<String, AnyObject>?, error:NSError?) -> Void in
            for (k,v) in dataDictionary! {
                print("\(k) -----  \(v)")
            }
            print(dataDictionary)
        }
        
    }
    @IBAction func signOutBtn(_ sender: UIButton) {
//        self.endTimer()
           FacebookSignInManager.logoutFromFacebook()
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            self.signInButton.isEnabled = true
            self.signoutBT.isEnabled = false
            GIDSignIn.sharedInstance().signOut()
            print("Signout successfully....")
        }else{
//            self.signoutBT.isHidden = true
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
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLB.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            GIDSignIn.sharedInstance().signOut()
            self.timerLB.text = "Session expired !!"
            self.signoutBT.isEnabled = false
            self.signInButton.isEnabled = true
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
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
           
            if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            cell?.nameLB.text = self.name
                 print(self.name)
            }else{
                cell?.nameLB.text = "Guest"
                 print(self.name)
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


extension ViewController {
   
    
//    func mydata(_ name: String?, _ email: String?) {
//        self.name = name
//        self.signInButton.isEnabled = false
//        self.signoutBT.isHidden = false
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC
//        self.navigationController?.pushViewController(vc!, animated: true)
//        self.tableView.reloadData()
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            self.sessionLB.isHidden = false
            self.timerLB.isHidden = false
            self.totalTime = 60
            self.startTimer()
            // Perform any operations on signed in user here.
            self.signoutBT.isEnabled = true
            self.name = user.profile.name
            self.email = user.profile.email
            print(self.email!)
            print(self.name!)
            self.signInButton.isEnabled = false
            self.signoutBT.isHidden = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC
            self.navigationController?.pushViewController(vc!, animated: true)
            self.tableView.reloadData()
//            self.delegate?.mydata(self.name, self.email)
            
            
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("Singnin failed...")
    }
    
    
}

