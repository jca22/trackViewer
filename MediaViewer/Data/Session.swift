//
//  Session.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

/*
    A session model. This data is persisted to save all sessions.
 */

import Foundation
import RealmSwift

class Session: Object {
    // MARK: - Properties
    
    @objc dynamic var sessionID = UUID().uuidString
    @objc dynamic var trackID: Int = 0
    @objc dynamic var lastAccess = Date(timeIntervalSince1970: 1)
    
    // MARK: - Methods
    
    override static func primaryKey() -> String? {
        return "sessionID"
    }
}
