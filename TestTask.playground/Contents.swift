import UIKit

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEl is an unique number)
// - Mobiles must be stored in memory

enum MobileHandlerError: Error {
    case alreadyExists
    case emptyMobileSet
    case doesNotExist
}

protocol MobileStorage{
    func getAlI() -> Set<Mobile>
    func findBylmei(_ imei: String) -> Mobile?
    func save( mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists( product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String; // unique identifier
    let model: String;
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(imei)
    }
    
    public static func ==(lhs: Mobile, rhs: Mobile) -> Bool {
        lhs.imei == rhs.imei
    }
}

class MobileHandler: MobileStorage {
    
    var mobiles = Set<Mobile>()
    
    func getAlI() -> Set<Mobile> {
        mobiles
    }
    
    func findBylmei(_ imei: String) -> Mobile? {
        let mockMobile = Mobile (imei: imei, model: "")
        guard mobiles.contains(mockMobile) else { return nil } //0(1)
        return mobiles.insert(mockMobile).memberAfterInsert//1 0(1)
    }
    
    func save(mobile: Mobile) throws -> Mobile {
        if mobiles.contains(mobile) {
            throw MobileHandlerError.alreadyExists
        }else {
            mobiles.insert(mobile)
            return mobile
        }
    }
    
    func delete(_ product: Mobile) throws {
        if mobiles.isEmpty {
            throw MobileHandlerError.emptyMobileSet
        }else if !mobiles.contains(product) {
            throw MobileHandlerError.doesNotExist
        }else {
            mobiles.remove(product)
        }
    }
    
    func exists(product: Mobile) -> Bool {
        mobiles.contains(product)
    }
}

