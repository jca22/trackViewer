//
//  ActiveSession.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 16/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

/*
    This helper class is implemented as a singleton. This class is responsible for
    CRUD operations using Realm as well giving easy access to useful data retrieved
    during data fetching.
 */

import Foundation
import RealmSwift

class ActiveSession: NSObject {
    // MARK: - Properties
    
    static let currentSession: ActiveSession = ActiveSession()
    var session: Session?
    var lastAccess: Date?
    var contentList: [Int:Content?] = [Int:Content?]()
    
    // MARK: - Methods
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
    
    func getAllContent() {
        do {
            let realm = try Realm()
            let content = realm.objects(Content.self)
            if content.count > 0 {
                for aContent in content {
                    contentList[aContent.trackID] = aContent
                }
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
    }
    
    func updateTrackID(_ trackID: Int) {
        do {
            let realm = try Realm()
            try realm.write {
                if let session = session {
                    session.trackID = trackID
                }
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
        
        saveSession()
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
                realm.add(session, update: .modified)
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
    }
    
    func saveContent(content: Content) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(content, update: .modified)
            }
        } catch let error as NSError {
            // TODO
            print(error.localizedDescription)
        }
    }
}
