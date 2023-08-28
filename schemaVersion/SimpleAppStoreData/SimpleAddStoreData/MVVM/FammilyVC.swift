//
//  FammilyVC.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 26/8/23.
//


import RealmSwift

class FamilyModel: Object {
    @Persisted(primaryKey: true) var familyId: ObjectId
    @Persisted var familyName: String = ""
    @Persisted var members = List<MemberIFamilyModel>() // need the same "members"
}

class MemberIFamilyModel: Object{
    @Persisted(originProperty: "members") var assignee: LinkingObjects<FamilyModel>
    
    @Persisted(primaryKey: true) var personId: ObjectId
    @Persisted var fullName: String = "" //Edit field name to fullname
    @Persisted var age: Int = 0
    @Persisted var gender: String = ""
//    @Persisted var email: String = "" // New field email
}





import UIKit



//class FammilyVC: UIViewController {
//
//    var realm = try! Realm()
//    let familyModel = FamilyModel()
//
//    let newSchemaVersion: UInt64 = 0 // if we have updated or edit file we need change schemaVersion in to +1
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Family"
//        view.backgroundColor = .white
//
//
//
//        //MARK: Use for udete version bd and edit field mane
//        let config = Realm.Configuration(
//            schemaVersion: newSchemaVersion, // Increment this value whenever schema changes
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < self.newSchemaVersion {
//                    //MARK: Add new field
////                    migration.enumerateObjects(ofType: FamilyModel.className()) { oldObject, newObject in
////                        // Set a default value for the ponumber property
////                        newObject!["floor"] = "Phnom penh"
////                    }
//
//                    //MARK: Edit field anme
//                    //migration.renameProperty(onType: FamilyModel.className(), from: "name", to: "fullName")
//                }
//            }
//        )
//
//
//
//        let id =  fetchData[1].familyId
//
//         do {
//             // Fetch the fetchData you want to edit by its id
//             if let family = realm.object(ofType: FamilyModel.self, forPrimaryKey: id ) {
//                 // Perform edits
//                 try realm.write {
//                     family.familyName = "Family ABCDEF"
// //                    realm.add(fetchData)
//                 }
//                 print("family updated successfully")
//             } else {
//                 print("family not found")
//             }
//         } catch {
//            print(" // Handle error")
//         }
//
//        //MARK: Fetch data from db
//        let fetch = realm.objects(FamilyModel.self)
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //MARK: URL open view data Realm Studio
//        print("filePathRealmSwift: \(Realm.Configuration.defaultConfiguration.fileURL!)")
//    }
//}





import RealmSwift

class RealmStudio: UIViewController{
    var realm = try! Realm()
//    var realm:    Realm!
    
    let familyModel = FamilyModel()
    let newSchemaVersion:  UInt64 = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Family"
        view.backgroundColor = .white
        
//         MARK: Add data to DB
////        do{
//            try realm.write{
//            familyModel.familyName = "Family ABCDEF"
//            realm.add(familyModel)
//        }
//
////        }catch{
////
////        }
       
      
        //
        //MARK: Fetch data from DB
//                let fetchFamily = realm.objects(FamilyModel.self)
//                let id = fetchFamily[0].familyId
//
               // MARK: Edit data from DB
        //        do{
        //
        //            try realm.write {
        //                if let family = realm.object(ofType: FamilyModel.self, forPrimaryKey: id ) {
        //                    family.familyName = "Family ABC"
        //                }
        //            }
        //
        //        }catch{
        //            print("Error")
        //        }
        //
        
        //MARK: Fetch data from DB
//                let fetchFamily = realm.objects(FamilyModel.self)
//                let id = fetchFamily[0].familyId
//
        
        // MARK: Delete data from DB
//                do{
//                    try realm.write {
//                        if let family = realm.object(ofType: FamilyModel.self, forPrimaryKey: id ) {
//                            realm.delete(family)
//                        }
//                    }
//        
//                }catch{
//                    print("Error")
//                }
        //
        //
        //
//        MARK: Use for udete version bd and edit field mane
//                let config = Realm.Configuration(
//                    schemaVersion: newSchemaVersion, // Increment this value whenever schema changes
//                    migrationBlock: { migration, oldSchemaVersion in
//
//                    }
//                )
//
//
//                do{
//                    realm = try Realm(configuration: config)
//                    try realm.write {
////                        realm.add(familyModel)
//                    }
//
//                }catch{
//                    print("Error")
//                }

    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        print("filePathRealmSwift: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
}




