//
//  CreateRoomVCViewController.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit
import RealmSwift

class CreateRoomVCViewController: UIViewController,UITextFieldDelegate {
    let realm = try! Realm()
    
    var bottomConstraint = NSLayoutConstraint()
    lazy var roomTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter room name"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var btnSave: MainButton = {
        let btn = MainButton(type: .system)
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(didTappedSave), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Room"
       
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        roomTextField.resignFirstResponder()
    }
    
    func setupUI(){
        view.addSubview(roomTextField)
        
        view.addSubview(btnSave)
        
        NSLayoutConstraint.activate([
            roomTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100),
            roomTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            roomTextField.heightAnchor.constraint(equalToConstant: 50),
            
            btnSave.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            btnSave.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        bottomConstraint =  btnSave.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint.isActive = true
        
    }
    
    @objc func didTappedSave(_ sander: UIButton){
        
        if roomTextField.text == ""{
            showAlert(title: "Error", message: "Please input your room name")
        }else{
             let createRoomName = roomTextField.text ?? ""
            let userDefaults = UserDefaults.standard
            let vc = HomeVC()
            vc.firstTime = true
            if userDefaults.object(forKey: "isFirstTime") == nil {
                
                vc.list.roomName = createRoomName
                userDefaults.set(true, forKey: "isFirstTime")
 
            } else {
                vc.list.roomName = createRoomName
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARK: Keyborad hide and show
extension CreateRoomVCViewController{
    // When keyboard is hidden
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.isActive = false
        bottomConstraint.constant = 0
        bottomConstraint.isActive = true
    }
    
    //When keyboard is show
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let heightKeyboard =  -keyboardSize.size.height + 30
            
            bottomConstraint.isActive = false
            bottomConstraint.constant =  heightKeyboard
            bottomConstraint.isActive = true
        }
    }
}
