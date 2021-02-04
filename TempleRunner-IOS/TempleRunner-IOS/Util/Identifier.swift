import UIKit

class Identifier : NSObject, NSCoding {
    var aString = ""
    static var USER_ID = ""

    init(s: String){
        super.init()
        aString = s
    }

    static func getId() -> String {
        return USER_ID
    }

    static func setId(s:String) {
        USER_ID = s
    }


    required init?(coder aDecoder: NSCoder){
        super.init()
        aString = aDecoder.decodeObject(forKey: "the_text") as! String 
    }

    func encode(with aCoder: NSCoder){
        aCoder.encode(aString, forKey: "the_text")
    }
}