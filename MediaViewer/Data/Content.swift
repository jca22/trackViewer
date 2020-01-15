//
//  Content.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

import Foundation
import RealmSwift

class Content: NSObject {
    var trackID: Int = 0
    var trackName: String = ""
    var artist: String = ""
    var artWorkURL: String = ""
    var artWork100URL: String = ""
    var trackPrice: Float = 0
    var genre: String = ""
    var currency: String = ""
    var longDescription: String = ""
    var album: String = ""
    var year: Int = 0
}
