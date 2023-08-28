//
//  CustomerModel.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 21/8/23.
//

import Foundation
import RealmSwift
import UIKit


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
}



