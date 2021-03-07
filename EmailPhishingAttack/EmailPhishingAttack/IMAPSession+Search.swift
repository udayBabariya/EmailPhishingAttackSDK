//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Snips
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public enum SearchKind {
    case all
    case from(value: String)
    case to(value: String)
    case cc(value: String)
    case bcc(value: String)
    case recipient(value: String) // recipient is the combination of to, cc and bcc
    case subject(value: String)
    case content(value: String)
    case body(value: String)
    case uids(uids: IndexSet)
    case numbers(numbers: IndexSet)
    case header(header: String, value: String)
    case read
    case unread
    case flagged
    case unflagged
    case answered
    case unanswered
    case draft
    case undraft
    case deleted
    case spam
    case beforeDate(date: Date)
    case onDate(date: Date)
    case sinceDate(date: Date)
    case beforeReceivedDate(date: Date)
    case onReceivedDate(date: Date)
    case sinceReceivedDate(date: Date)
    case sizeLarger(size: uint)
    case sizeSmaller(size: uint)
    case gmailThreadId(id: uint)
    case gmailMessageId(id: uint)
    case gmailRaw(string: String)
}

public indirect enum SearchFilter {
    case and(SearchFilter, SearchFilter)
    case or(SearchFilter, SearchFilter)
    case not(SearchFilter)
    case base(SearchKind)
}

// MARK: CustomStringConvertible extensions

extension SearchKind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .all: return ".all"
        case .from(let value): return ".from(\(value))"
        case .to(let value): return ".to(\(value))"
        case .cc(let value): return ".cc(\(value))"
        case .bcc(let value): return ".bcc(\(value))"
        case .recipient(let value):return ".recipient(\(value))" // recipient is the combination of to, cc and bcc
        case .subject(let value): return ".subject(\(value))"
        case .content(let value): return ".content(\(value))"
        case .body(let value): return ".body(\(value))"
        case .uids(let uids): return ".uids(\(uids))"
        case .numbers(let numbers): return ".numbers(\(numbers))"
        case .header(let header, let value): return ".header(\(header), \(value))"
        case .read: return ".read"
        case .unread: return ".unread"
        case .flagged: return ".flagged"
        case .unflagged: return ".unflagged"
        case .answered: return ".answered"
        case .unanswered: return ".unanswered"
        case .draft: return ".draft"
        case .undraft: return ".undraft"
        case .deleted: return ".deleted"
        case .spam: return ".spam"
        case .beforeDate(let date): return ".beforeDate(\(date))"
        case .onDate(let date): return ".onDate(\(date))"
        case .sinceDate(let date): return ".sinceDate(\(date))"
        case .beforeReceivedDate(let date): return ".beforeReceivedDate(\(date))"
        case .onReceivedDate(let date): return ".onReceivedDate(\(date))"
        case .sinceReceivedDate(let date): return ".sinceReceivedDate(\(date))"
        case .sizeLarger(let size): return ".sizeLarger(\(size))"
        case .sizeSmaller(let size): return ".sizeSmaller(\(size))"
        case .gmailThreadId(let id): return ".gmailThreadId(\(id))"
        case .gmailMessageId(let id): return ".gmailMessageId(\(id))"
        case .gmailRaw(let raw): return ".gmailRaw(\(raw))"
        }
    }
}


 

private extension SearchFilter {
    func unreleasedImapSearchKey(_ configuration: Configuration) -> Any {
        return "Connection"
    }
    
}

// MARK: - Operators

public func &&(lhs: SearchKind, rhs: SearchFilter) -> SearchFilter {
    return .and(.base(lhs), rhs)
}

public func &&(lhs: SearchFilter, rhs: SearchKind) -> SearchFilter {
    return .and(lhs, .base(rhs))
}

public func &&(lhs: SearchFilter, rhs: SearchFilter) -> SearchFilter {
    return .and(lhs, rhs)
}

public func &&(lhs: SearchKind, rhs: SearchKind) -> SearchFilter {
    return .and(.base(lhs), .base(rhs))
}

public func ||(lhs: SearchKind, rhs: SearchFilter) -> SearchFilter {
    return .or(.base(lhs), rhs)
}

public func ||(lhs: SearchFilter, rhs: SearchKind) -> SearchFilter {
    return .or(lhs, .base(rhs))
}

public func ||(lhs: SearchFilter, rhs: SearchFilter) -> SearchFilter {
    return .or(lhs, rhs)
}

public func ||(lhs: SearchKind, rhs: SearchKind) -> SearchFilter {
    return .or(.base(lhs), .base(rhs))
}

public prefix func !(rhs: SearchFilter) -> SearchFilter {
    return .not(rhs)
}

public prefix func !(rhs: SearchKind) -> SearchFilter {
    return .not(.base(rhs))
}
