//
//  main.swift
//  
//
//  Created by Alexander Botkin on 2/15/20.
//

import Foundation
import Mantle


// MARK: -
// MARK: Main

print("Hello world!")

let json = ["username": "MyUniqueUsername",
            "nested": ["name": "FirstName LastName"],
            "count": "21"] as [String : Any]
let model = try? MTLJSONAdapter.model(of: TestModel.self, fromJSONDictionary: json) as? TestModel
let name = model?.name ?? ""
print("Name: \(name)")
print("Model: \(String(describing: model))")

let newJson = try? MTLJSONAdapter.jsonDictionary(fromModel: model)
print("JSON: \(String(describing: newJson))")
