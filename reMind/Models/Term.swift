//
//  Term.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import Foundation
import CoreData

@objc(Term)
public final class Term: NSManagedObject {

}

extension Term {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var creationDate: Date
    @NSManaged public var identifier: UUID
    @NSManaged public var lastReview: Date
    @NSManaged public var meaning: String
    @NSManaged public var rawSRS: Int16
    @NSManaged public var rawTheme: Int16
    @NSManaged public var value: String
    @NSManaged public var boxID: Box?
}

extension Term: CoreDataModel {

    /// Check if it is pending.
    var isPending: Bool {

        let srs = Int(self.rawSRS)

        guard srs > 0 else { return true }

        guard let nextReview = Calendar.current.date(byAdding: .day, value: srs, to: self.lastReview)
        else { return false }

        return nextReview <= Date()
    }

    var srs: SpacedRepetitionSystem {
        return SpacedRepetitionSystem(rawValue: rawSRS) ?? SpacedRepetitionSystem.first
    }

    var theme: reTheme {
        return reTheme(rawValue: self.rawTheme) ?? reTheme.lavender
    }
}

enum SpacedRepetitionSystem: Int16 {
    case none = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 5
    case fifth = 8
    case sixth = 13
    case seventh = 21

    var next: Self {
        switch self {
        case .none: return .first
        case .first: return .second
        case .second: return.third
        case .third: return .fourth
        case .fourth: return.fifth
        case .fifth: return .sixth
        case .sixth, .seventh: return .seventh

        }
    }

    var previous: Self {
        switch self {
        case .none, .first: return .none
        case .second: return.first
        case .third: return .second
        case .fourth: return.third
        case .fifth: return .fourth
        case .sixth: return .fifth
        case .seventh: return .sixth

        }
    }
}


struct TermAux: Identifiable, Hashable {
    internal init(term: Term) {
        self.id = term.identifier 
        self.boxID = term.boxID?.identifier ?? UUID()
        self.creationDate = term.creationDate 
        self.lastReview = term.lastReview 
        self.meaning = term.meaning 
        self.rawSRS = Int(term.rawSRS)
        self.rawTheme = Int(term.rawTheme)
        self.value = term.value 
    }

    internal init(
        id: UUID = UUID(),
        boxID: UUID,
        creationDate: Date = Date(),
        lastReview: Date = Date(),
        meaning: String,
        rawSRS: Int = 0,
        rawTheme: Int = 0,
        term: String
    ) {
        self.id = id
        self.boxID = boxID
        self.creationDate = creationDate
        self.lastReview = lastReview
        self.meaning = meaning
        self.rawSRS = rawSRS
        self.rawTheme = rawTheme
        self.value = term
    }

    var id = UUID()
    var boxID: UUID

    var creationDate: Date
    var lastReview: Date
    var meaning: String
    var rawSRS: Int
    var rawTheme: Int
    var value: String
}
