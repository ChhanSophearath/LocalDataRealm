//
//  CustomerInForVC.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit
import RealmSwift

class CustomerInForVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    let realm = try! Realm()
    var isFromRoomName: String? = nil
    var isFromHomeOfIndex: Int? = nil
    var adddata:(()->())?
    
    var isTappedEdit: Bool = false
    let  itemsGender = ["Male", "Female", "Other"]
    var indexPath: Int = 0
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Inpout name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Inpout age"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Gender"
        textField.borderStyle = .roundedRect
        //        textField
        //        textField
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField,ageTextField,genderTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomerList.self, forCellReuseIdentifier: "CustomerList")
        return tableView
    }()
    
    lazy var addPerson: MainButton = {
        let btn = MainButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(didTappedAdd), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Customer Information"
        setupUI()
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTextField.inputView = pickerView
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }
    
    private func setupUI(){
        view.addSubview(stackView)
        view.addSubview(tableView)
        view.addSubview(addPerson)
        
        nameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ageTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addPerson.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            addPerson.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 20),
            addPerson.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
    
    
    //MARK: DidTapped Add Button
    @objc private func didTappedAdd(){
        let appentItems = realm.objects(CustomerInforModel.self)
        let id = appentItems[isFromHomeOfIndex ?? 0]._id
        
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let gender = genderTextField.text ?? ""
        
        //call func insert element
        addTaskAtIndex(roomId: id , age: Int(age) ?? 0, gender: gender, name: name, index: isFromHomeOfIndex ?? 0)
        
        //MARK: clear text field
        nameTextField.text = ""
        ageTextField.text  = ""
        genderTextField.text  = ""
    }
    
    
    //MARK: Appent using with Id Realm BD
    private func addTaskAtIndex(roomId: ObjectId, age: Int, gender: String, name: String, index: Int) {
        
        // Find the specific CustomerInforModel instance using the primary key
        if let customerInfo = realm.object(ofType: CustomerInforModel.self, forPrimaryKey: roomId) {
            let newTask = PersonModel()
            newTask.age = String(age)
            newTask.gender = gender
            newTask.fullName = name
            
            
            if isTappedEdit == true{
                
                let customerModel = realm.objects(CustomerInforModel.self)
                
                let idPerson = customerModel[isFromHomeOfIndex ?? 0].person[indexPath]._id
                if let personToUpdate = realm.object(ofType: PersonModel.self, forPrimaryKey: idPerson ){
                    try! realm.write {
                        personToUpdate.fullName = name
                        personToUpdate.age = String(age)
                        personToUpdate.gender = gender
                    }
                }
                isTappedEdit = false
            }else{
                // Insert the new task at the specified index
                try! realm.write {
                    customerInfo.person.append(newTask)
                }
            }
            self.tableView.reloadData()
        }
    }
    
}

//MARK: TableView
extension CustomerInForVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let listStore = realm.objects(Task.self)
        
        let appentItems = realm.objects(CustomerInforModel.self)
        let row = appentItems[isFromHomeOfIndex ?? 0].person.count
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerList") as! CustomerList
        
        let appentItems = realm.objects(CustomerInforModel.self)
        let personInfor = appentItems[isFromHomeOfIndex ?? 0].person
        
        cell.lblAge.text =  "Age : " + personInfor[indexPath.row].age
        cell.lblName.text = "Name : " +  personInfor[indexPath.row].fullName
        cell.lblGender.text = "Gender : " +  personInfor[indexPath.row].gender
        
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(didTappedDelete), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(didTappedEdit), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func didTappedDelete(_ sender: UIButton){
        
        indexPath = sender.tag
        
    
        let alertController = UIAlertController(title: "Massage", message: "Do you want to delete it?", preferredStyle: .alert)
        
        // Add a "Yes" button
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
            let customerModel = realm.objects(CustomerInforModel.self)
            let idPerson = customerModel[isFromHomeOfIndex ?? 0].person[indexPath]._id
            if let personToUpdate = realm.object(ofType: PersonModel.self, forPrimaryKey: idPerson ){
                try! realm.write {
                    realm.delete(personToUpdate)
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addAction(yesAction)
        
        // Add a "No" button
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            // Handle "No" button tap
            print("User tapped No")
        }
        alertController.addAction(noAction)
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func didTappedEdit(_ sender: UIButton){
        
        indexPath = sender.tag
        
        
        let alertController = UIAlertController(title: "Massage", message: "Do you want to edit it?", preferredStyle: .alert)
        
        // Add a "Yes" button
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
            let customerModel = realm.objects(CustomerInforModel.self)
            
            let idPerson = customerModel[isFromHomeOfIndex ?? 0].person[indexPath]._id
            if let personToUpdate = realm.object(ofType: PersonModel.self, forPrimaryKey: idPerson ){
                nameTextField.text = personToUpdate.fullName
                ageTextField.text = personToUpdate.age
                genderTextField.text = personToUpdate.gender
                isTappedEdit = true
            }
        }
        alertController.addAction(yesAction)
        
        // Add a "No" button
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            // Handle "No" button tap
            print("User tapped No")
        }
        alertController.addAction(noAction)
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
}


// MARK: PickerView
extension CustomerInForVC {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of columns in the picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  itemsGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  itemsGender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text =  itemsGender[row]
        genderTextField.resignFirstResponder() // Hide the picker view
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Show the picker view when the text field is tapped
        pickerView.isHidden = false
        return true
    }
}

