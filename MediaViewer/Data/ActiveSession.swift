//
//  ActiveSession.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 16/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

import Foundation
import RealmSwift

class ActiveSession: NSObject {
    static let currentSession: ActiveSession = ActiveSession()
    var session: Session?
    var lastAccess: Date?
    
    func getLastSession() {
        do {
            let realm = try Realm()
            let sessions = realm.objects(Session.self).sorted(byKeyPath: "lastAccess")
            if sessions.count > 0 {
                session = sessions[0]
                lastAccess = session?.lastAccess
                try realm.write {
                    if let session = session {
                        session.lastAccess = Date.init(timeIntervalSinceNow: 0)
                    }
                }
            } else {
                // Happens when this is the initial run
                let newSession = Session()
                lastAccess = Date.init(timeIntervalSinceNow: 0)
                newSession.lastAccess = Date.init(timeIntervalSinceNow: 0)
                session = newSession
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
    }
    
    func saveSession() {
        if let session = session {
            saveSession(session: session)
        }
    }
    
    func saveSession(session: Session) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(session)
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
    }
}
