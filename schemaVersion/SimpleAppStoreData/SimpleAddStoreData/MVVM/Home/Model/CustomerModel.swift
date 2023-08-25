//
//  CustomerModel.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 21/8/23.
//

import Foundation
import RealmSwift


class CustomerInforModel: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var roomName : String?
    @Persisted var person: List<PersonModel> // need the same "person"
}

class PersonModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId // autonmatic
    @Persisted var name: String = ""
    @Persisted var gender: String = ""
    @Persisted var age: String = ""
    // Backlink to the user. This is automatically updated whenever
    // this task is added to or removed from a user's task list.
    @Persisted(originProperty: "person") var assignee: LinkingObjects<CustomerInforModel>
    // need the same "person"
    @Persisted var ponumber: String? = "000000000000000"// New field: Purchase Order Number
    @Persisted var nextName: String? = "&kkk09"
//    static func migratePersonModel(_ migration: Migration, oldSchemaVersion: UInt64) {
//           if oldSchemaVersion < 2 {
//               // Add the 'ponumber' property to the PersonModel class
//               migration.enumerateObjects(ofType: PersonModel.className()) { oldObject, newObject in
//                   // Set a default value for 'ponumber' or handle as needed
//                   newObject?["ponumber"] = "DefaultPONumber"
//               }
//           }
//       }
    
}



