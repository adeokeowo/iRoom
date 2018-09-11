////
//  ViewController.swift
//  iRoom-Register
//
//  Created by Adedayo Okeowo on 11/09/2018.
//  Copyright © 2018 Adedayo Okeowo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: constants
    //MARK: components
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var textFieldPwd: UITextField!
    @IBOutlet weak var labelPwd: UILabel!
    @IBOutlet weak var textFieldConfirmPwd: UITextField!
    @IBOutlet weak var labelConfirmPwd: UILabel!
    @IBOutlet var titleCollection: [UIButton]!
    @IBOutlet weak var titleVal1: UILabel!
    @IBOutlet weak var textFieldFName: UITextField!
    @IBOutlet weak var textFieldLName: UITextField!
    @IBOutlet weak var labelMsg: UILabel!
    @IBOutlet weak var textDobPicker: UITextField!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(ViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecogniser:)))
        
        view.addGestureRecognizer(tapGesture)
        
        textDobPicker.inputView = datePicker
        // self.dobPicker.date = NSDate.init(timeIntervalSinceNow: 0) as Date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventEmail(_ sender: UITextField) {
        if isValid(textFieldUsername.text!){
            labelUsername.text = "Email is valid."
        } else {
            labelUsername.text = "Email is not valid."
        }
    }
    
    @IBAction func eventPwd(_ sender: UITextField) {
        if isValidPassword(testStr: textFieldPwd.text){
            labelPwd.text = "Password is valid."
        } else {
            labelPwd.text = "Password is not valid."
        }
    }
    
    @IBAction func eventConfirmPwd(_ sender: UITextField) {
        if ( (textFieldPwd.text?.elementsEqual(textFieldConfirmPwd.text!))! != true ){
            labelConfirmPwd.text = "Password don't match."
        } else {
            labelConfirmPwd.text = "Passwords match."
        }
    }
    
    @IBAction func eventHandleTitleSelection(_ sender: UIButton) {
        titleCollection.forEach{(button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    enum Titles: String {
        case mr = "Mr"
        case miss = "Miss"
        case mrs = "Mrs"
        
    }
    
    @IBAction func eventTitleTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let city1 = Titles(rawValue: title) else {
            return
        }
        switch city1 {
        case .mr:
            titleVal1.text = "Selected: Mr"
        case .miss:
            titleVal1.text = "Selected: Miss"
        case .mrs:
            titleVal1.text = "Selected: Mrs"
        }
        titleCollection.forEach{(button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func eventDobAtion(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        //let strDate = dateFormatter.string(from: dobPicker.date)
        //self.labelMsg.text = strDate
    }
    
    //MARK: functions
    @objc func viewTapped(gestureRecogniser: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        textDobPicker.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    /// Validate email string
    ///
    /// - parameter email: A String that rappresent an email address
    ///
    /// - returns: A Boolean value indicating whether an email is valid.
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }

}

