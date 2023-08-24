//
//  ViewController.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit


class WelcomeViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    var bottomConstraint =  NSLayoutConstraint()
    let titleLogIn = ["Email","Facebook","Apple ID"]
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.delegate = self
                textField.autocapitalizationType = .none
                textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nextButton: MainButton = {
        let button = MainButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SelectLoginCell.self, forCellWithReuseIdentifier: "SelectLoginCell")
      
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Welcome"
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
       


//        try! realm.write {
//            realm.add(person)
//        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
}

//MARK: ForButtonOnKeyboard
extension WelcomeViewController{
    // When keyboard is hidden
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.isActive = false
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
    }
    
    //When keyboard is show
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let heightKeyboard =  -keyboardSize.size.height + 30
            
            bottomConstraint.isActive = false
            bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: heightKeyboard)
            bottomConstraint.isActive = true
        }
    }
}

//MARK: ForNextButton
extension WelcomeViewController{
    @objc func nextButtonTapped() {
         // Call this method when the login button is tapped
         
         guard let email = emailTextField.text, !email.isEmpty else {
             showAlert(title: "Error", message: "Please enter an email.")
             return
         }
         
         guard isValidEmail(email) else {
             showAlert(title: "Error", message: "Please enter a valid email.")
             return
         }
         
         guard let password = passwordTextField.text, !password.isEmpty else {
             showAlert(title: "Error", message: "Please enter a password.")
             return
         }
         
         if isValidPassword(password) {
             DispatchQueue.main.async {
                 let newViewController = HomeVC() // Replace with your view controller's class
                 self.navigationController?.pushViewController(newViewController, animated: true)
                 self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
             }
         } else {
             showAlert(title: "Error", message: "Password must be at least 6 characters.")
         }
     }
     
     func isValidEmail(_ email: String) -> Bool {
         // Perform email validation here (you can use regular expressions or other methods)
         // This is a simple example
         return email.contains("@") && email.contains(".")
     }
     
     func isValidPassword(_ password: String) -> Bool {
         // Perform password validation here (you can implement your own rules)
         return password.count >= 1
     }
     
 
}

//MARK: ForCollectionview
extension WelcomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectLoginCell", for: indexPath) as! SelectLoginCell
        cell.layer.cornerRadius = collectionView.frame.height/2
        cell.titleLabel.text = titleLogIn[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widht = (collectionView.frame.width-20)/3
        let height = collectionView.frame.height
        return CGSize(width: widht, height: height)
    }
}

//MARK: ForSetupUI
extension WelcomeViewController{
    func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(collectionView)
        view.addSubview(nextButton)  // Add the button
        
        // Constraints for email text field
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        // Constraints for password text field
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        // collectionview
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -110),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 54),
               ])
        
        // Constraints for next button
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            nextButton.heightAnchor.constraint(equalToConstant: 54),
        ])
        
        bottomConstraint =   nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
    }
}
