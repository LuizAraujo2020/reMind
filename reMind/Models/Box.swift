//
//  Box.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation
import CoreData
import SwiftUI

@objc(Box)
public final class Box: NSManagedObject {

}

extension Box {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Box> {
        return NSFetchRequest<Box>(entityName: "Box")
    }

    @NSManaged public var identifier: UUID
    @NSManaged public var name: String
    @NSManaged public var keywords: String
    @NSManaged public var descriptions: String
    @NSManaged public var rawTheme: Int16
    @NSManaged public var terms: NSSet?

}

// MARK: Generated accessors for terms
extension Box {

    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)

}

extension Box : Identifiable {

}

extension Box: CoreDataModel {
    var theme: reTheme {
        return reTheme(rawValue: self.rawTheme) ?? reTheme.lavender
    }

    var numberOfTerms: Int { self.terms?.count ?? 0 }
}

enum reTheme: Int16, CaseIterable {
    case aquamarine = 0
    case mauve
    case lavender

    var name: String {
        switch self {
        case .aquamarine:
            return "aquamarine"
        case .mauve:
            return "mauve"
        case .lavender:
            return "lavender"
        }
    }

    var render: Color {
        Color(self.name)
    }
}

struct BoxAux: Identifiable {

    var id = UUID()

    var name: String
    var keywords: String
    var descriptions: String
    var rawTheme: Int16
    var terms: [TermAux]

    internal init(id: UUID = UUID(), name: String, keywords: String, descriptions: String, rawTheme: Int16, terms: [TermAux]) {
        self.id = id
        self.name = name
        self.keywords = keywords
        self.descriptions = descriptions
        self.rawTheme = rawTheme
        self.terms = terms
    }

    internal init(box: Box) {
        self.id = box.identifier
        self.name = box.name
        self.keywords = box.keywords
        self.descriptions = box.descriptions
        self.rawTheme = box.rawTheme
        self.terms = []
    }

    internal init() {
        self.id = UUID()
        self.name = ""
        self.keywords = ""
        self.descriptions = ""
        self.rawTheme = 0
        self.terms = []
    }
}
