//
//  Content.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

/*
    A content model. This represents each track/movie as returned from iTunes API.
 */

import Foundation
import RealmSwift

class Content: Object {
    // MARK: - Properties
    
    @objc dynamic var trackID: Int = 0
    @objc dynamic var trackName: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var artWorkURL: String = ""
    @objc dynamic var artWork100URL: String = ""
    @objc dynamic var trackPrice: Float = 0
    @objc dynamic var genre: String = ""
    @objc dynamic var currency: String = ""
    @objc dynamic var longDescription: String = ""
    @objc dynamic var album: String = ""
    @objc dynamic var year: Int = 0
    
    // MARK: - Methods
    
    override static func primaryKey() -> String? {
        return "trackID"
    }
}
