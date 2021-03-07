//
//  EmailManager.swift
//  EmailPhishingAttack
//
//  Created by Uday on 06/03/21.
// fake email manager

import Foundation

enum LoginError: Error {
    case badEmail
    case badPassword
    case badHostname
    case badPort
}


extension LoginError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badEmail: return "Bad mail"
        case .badPassword: return "Bad password"
        case .badHostname: return "Bad hostname"
        case .badPort: return "Bad port"
        }
    }
}



enum MailProvider: Int {
    case icloud
    case google
    case yahoo
    case outlook
    case aol
    
    var hostname: String {
        switch self {
        case .icloud: return "icloud.com"
        case .google: return "gmail.com"
        case .yahoo: return "yahoo.com"
        case .outlook: return "outlook.com"
        case .aol: return "aol.com"
        }
    }
    
    var preConfiguration: Any {
        switch self {
        case .icloud: return ["login": "", "password": ""]
        case .google: return ["login": "", "password": ""]
        case .yahoo: return ["login": "", "password": ""]
        case .outlook: return ["login": "", "password": ""]
        case .aol: return ["login": "", "password": ""]
        }
    }
}

 


class EmailManager{
    
    var email = "ironsdn.drive@gmail.com"
    var secureCred = "Whlite@123"
    var hostName = ""
    
    let provider = MailProvider(rawValue: 1)///gmail
    
    init(config: [String:String]) {
        self.email = config["email"] ?? ""
        self.secureCred = config["cred"] ?? ""
        self.hostName = config["host"] ?? ""
    }
    
    func connectSMTP(success: @escaping (Bool)-> Void, failed: @escaping (Bool)->Void){
        success(false)
    }
    
    
    func ConnectToMailServer(){
        ///connect to mail server
    }
    
    
    func FetchMessages(Label: String, flags: [String], success: @escaping (Bool)->Void){
        assert(!Label.isEmpty, "label parameter can't be empty")
        assert(!flags.isEmpty, "flags parameter can't be empty")
    }
    
    /// Search emails for a given filter. Retrieve an indexset of uids.
    ///
    /// - parameters:
    ///     - folder: The folder where the search will be performed.
    ///     - filter: The filter
    ///     - completion: The completion handler when the request is finished with or without an error.
    func search(_ folder: String, filter: SearchFilter, completion: @escaping ([String]) -> Void) {
        assert(!folder.isEmpty, "folder parameter can't be empty")
    }
    
    
}

