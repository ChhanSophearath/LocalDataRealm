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
    @Persisted var floor : String?
    @Persisted var person: List<PersonModel> // need the same "person"
}

class PersonModel: Object {
    // Backlink to the user. This is automatically updated whenever
    // this task is added to or removed from a user's task list.
    // need the same "person"
    @Persisted(originProperty: "person") var assignee: LinkingObjects<CustomerInforModel>
    @Persisted(primaryKey: true) var _id: ObjectId // autonmatic
    @Persisted var fullName: String = ""
    @Persisted var gender: String = ""
    @Persisted var age: String = ""
  
    
    @Persisted var ponumber: String? = "000000000000000"// New field: Purchase Order Number
    @Persisted var nextName: String? = "&kkk09"
    @Persisted var address: String? = "pp"
    
}



