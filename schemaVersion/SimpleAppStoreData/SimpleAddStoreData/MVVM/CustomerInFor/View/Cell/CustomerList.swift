//
//  CustomerList.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit

class CustomerList: UITableViewCell {
    
    static var identifier = "CustomerList"
    
    lazy  var bgView: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = .gray.withAlphaComponent(0.2)
        bg.layer.cornerRadius = 10
        return bg
    }()
    
    lazy var lblName: UILabel = {
        let lbl = UILabel()
//        lbl.text = "Name : \(name ?? "")"
        return lbl
    }()
    
    lazy var lblAge: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "Age : \(age ?? 0)"
        return lbl
    }()
    
    lazy var lblGender: UILabel = {
        let lbl = UILabel()
//        lbl.text = "Gender : \(gender ?? "")"
        return lbl
    }()
    
    
    lazy var containerlabel : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        lblName,lblGender
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .leading
        return stack
    }()
    
    lazy var btnEdit: MainButton = {
        let btn = MainButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    lazy var btnDelete: MainButton = {
        let btn = MainButton(type: .system)
        btn.setTitle("Delete", for: .normal)
        btn.backgroundColor = .red
        return btn
    }()
    
    lazy var containerBtn : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            btnEdit,btnDelete
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .leading
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
         addSubview(bgView)
        addSubview(containerlabel)
        addSubview(lblAge)
        addSubview(containerBtn)
        
        NSLayoutConstraint.activate([
            bgView.widthAnchor.constraint(equalTo:  widthAnchor, multiplier: 1),
            bgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bgView.topAnchor.constraint(equalTo:  topAnchor,constant: 0),
            bgView.bottomAnchor.constraint(equalTo:  bottomAnchor,constant: -10),
            
            containerlabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 20),
            containerlabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10),
            containerlabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10),
            
            containerBtn.topAnchor.constraint(equalTo: containerlabel.bottomAnchor, constant: 20),
            containerBtn.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10),
            containerBtn.leadingAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 0),
            containerBtn.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10),
            
            btnEdit.heightAnchor.constraint(equalToConstant: 30),
            btnDelete.heightAnchor.constraint(equalToConstant: 30),
            
            lblAge.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10),
            lblAge.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10),
        ])
    }
   
}
