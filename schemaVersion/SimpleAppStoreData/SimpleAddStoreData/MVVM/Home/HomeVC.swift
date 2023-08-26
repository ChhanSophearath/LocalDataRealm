//
//  RoomInformationVC.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {
    
    
    var firstTime: Bool? = nil
    var realm: Realm!
    var list = CustomerInforModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoomInformationCell.self, forCellWithReuseIdentifier: "RoomInformationCell")
        return collectionView
    }()
    
    lazy var addButton: MainButton = {
        let button = MainButton(type: .system)
        button.setTitle("Create New Room ", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var lblList: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.text = name.
        label.textColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title =  "Home"
        setupUI()
        
      
        
        let config = Realm.Configuration(
            schemaVersion: 5, // Increment this value whenever schema changes
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 5 {
                    // Enumerate through objects of the Person class
                    //MARK: Add new field
                    migration.enumerateObjects(ofType: CustomerInforModel.className()) { oldObject, newObject in
                        // Set a default value for the ponumber property
                        newObject!["floor"] = "Phnom penh"
                    }
                    //MARK: Edit field anme
                    //migration.renameProperty(onType: PersonModel.className(), from: "name", to: "fullName")
                }
            }
        )
        
        do {
            realm = try Realm(configuration: config)
            
            if firstTime == true{
                
                try! realm.write {
                    realm.add(list)
                    self.collectionView.reloadData()
                }
                
            }else{
                print("First time home sceen ")
            }
            
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        let listStore = realm.objects(CustomerInforModel.self)
        if listStore.isEmpty {
            lblList.text = "Empty list!"
        }else{
            lblList.text = ""
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print("filePathRealmSwift: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    // MARK: - Button Action
    @objc func addButtonTapped() {
        let vc =  CreateRoomVCViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: CollectionView
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let listStore = realm.objects(CustomerInforModel.self)
        return listStore.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomInformationCell", for: indexPath) as! RoomInformationCell
        
        let listStore = realm.objects(CustomerInforModel.self)
        cell.titleLabel.text = listStore[indexPath.row].roomName
        cell.backgroundColor = .orange
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CustomerInForVC()
        vc.isFromHomeOfIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: SetupUI
extension HomeVC{
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(addButton)
        view.addSubview(lblList)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            collectionView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -10),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            lblList.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblList.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

