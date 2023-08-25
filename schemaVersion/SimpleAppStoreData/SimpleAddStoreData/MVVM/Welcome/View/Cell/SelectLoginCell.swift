//
//  SelectLoginCell.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit

class SelectLoginCell: UICollectionViewCell {
    static var identifier = "SelectLoginCell"
    
    let titleLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
            label.text = "title"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        setupUI()
//        layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
            // Add and configure your UI elements here
            contentView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
}
