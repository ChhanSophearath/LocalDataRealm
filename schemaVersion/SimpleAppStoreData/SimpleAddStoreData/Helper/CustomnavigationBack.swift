//
//  CustomnavigationBack.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import Foundation
import UIKit
extension UIViewController{
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
//    func customizeBackButton() {
//         // Create a custom back button
//         let backButton = UIBarButtonItem(title: "Custom Back", style: .plain, target: self, action: #selector(backButtonTapped))
//         
//         // Apply the custom back button as the left bar button item
//         navigationItem.leftBarButtonItem = backButton
//            
//         // Optionally, you can also customize the back gesture
//         navigationController?.interactivePopGestureRecognizer?.delegate = nil
//     }
//     
//     @objc func backButtonTapped() {
//         // Handle the custom back button action here
//         navigationController?.popViewController(animated: true)
//     }
//    
//    
//    func customizeNavigationBarTitle(stringTitle: String) {
//           let titleLabel = UILabel()
//           titleLabel.text = "stringTitle"
//           titleLabel.textColor = .white
//           titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//           navigationItem.titleView = titleLabel
//       }
}

class MainButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    func setupButton() {
        // Customize the button's appearance, fonts, colors, etc.
        setTitleColor(.white, for: .normal)
        backgroundColor = .gray.withAlphaComponent(0.8)
        layer.cornerRadius = 8.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints  = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
}
