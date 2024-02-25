//
//  ActiveRecord.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation

protocol Redable {
    static func find(query: String, arguments: [Any]?) -> [Self]
    static func all() -> [Self]
}

protocol Deletable {
    func destroy()
}

protocol Writeable {
    static func newObject() -> Self
}

protocol ActiveRecordType: Redable, Writeable, Deletable { }

protocol ModelType: ActiveRecordType {
    associatedtype Context
    static var context: Self.Context { get }
}
