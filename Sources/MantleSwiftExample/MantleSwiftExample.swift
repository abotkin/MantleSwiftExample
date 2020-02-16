//
//  File.swift
//
//
//  Created by Alexander Botkin on 2/15/20.
//  Based off of MTLTestModel.h in MantleTests
//

import Mantle


class EmptyTestModel : MTLModel {

}

// NOTE: This is an incomplete implementation of MTLTestModel in Swift
class TestModel: MTLModel, MTLJSONSerializing {


    // Must be less than 10 characters.
    //
    // This property is associated with a "username" key in JSON.
    @objc var name: String? = nil

    // Defaults to 1. When two models are merged, their counts are added together.
    //
    // This property is a string in JSON.
    @objc var count: Int = 1

    // This property is associated with a "nested.name" key path in JSON. This
    // property should not be encoded into new archives.
    @objc var nestedName: String? = nil

    // Should not be stored in the dictionary value or JSON.
    @objc private(set) var dynamicName: String? = nil

    // Should not be stored in JSON, has MTLPropertyStorageTransitory.
    @objc weak var weakModel: EmptyTestModel?

    @objc static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        var mapping = NSDictionary.mtl_identityPropertyMap(withModel: self) ?? [:]
        mapping.removeValue(forKey: "weakModel")
        mapping["name"] = "username"
        mapping["nestedName"] = "nested.name"

       return mapping
    }

    @objc static func countJSONTransformer() -> ValueTransformer? {
        return MTLValueTransformer.init(usingForwardBlock: { (anyValue, success, errorPointer) -> Any? in
            let str = anyValue as? String ?? "0"
            return Int(str)
        }) { (anyValue, success, errorPointer) -> Any? in
            let intValue = anyValue as? Int ?? 0
            return String(intValue)
        }
    }
}
