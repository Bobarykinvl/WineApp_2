import UIKit
import RealmSwift



class RealmUser: Object {
    
    @objc dynamic var email = ""
    @objc dynamic var password = ""
}


let realm = try! Realm()

let person1 = RealmUser()
person1.email = "test@gmail.com"
person1.password = "11111111"

try! realm.write {
    realm.add(person1)
}
