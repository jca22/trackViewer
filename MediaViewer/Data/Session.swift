//
//  Session.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {
    @objc dynamic var trackID: Int = 0
    @objc dynamic var lastAccess = Date(timeIntervalSince1970: 1)
}
