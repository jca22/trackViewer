//
//  MediaDetailViewController.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

/*
    MediaDetailViewController is a subclass if UIViewController
    responsible for displaying selected content details. When a content
    data is set, it would trigger an update to the view with the
    song/movie details.
 */

import Foundation
import UIKit
import RealmSwift

class MediaDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var content: Content? {
        didSet {
            configureView()
            
            // Save current session
            if let content = content {
                if let session = ActiveSession.currentSession.session {
                    
                    do {
                        let realm = try Realm()
                        try realm.write {
                            session.trackID = content.trackID
                        }
                    } catch let error as NSError {
                        // TODO
                        print(error.localizedDescription)
                    }
                    
                    ActiveSession.currentSession.saveSession()
                }
            }
        }
    }

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Functions
    
    func configureView() {
        // Update description text
        if let content = content {
            // Load image asynchronously
            let url = URL(string: content.artWork100URL)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if data != nil {
                    DispatchQueue.main.async {
                        if let art = self.artwork {
                            art.image = UIImage(data: data!)
                        }
                    }
                }
            }
            
            if let descText = descriptionText, content.longDescription.count > 0 {
                descText.text = content.longDescription
            }
            
            if let trackName = trackNameLabel {
                trackName.adjustsFontSizeToFitWidth = true
                trackName.minimumScaleFactor = 0.2
                trackName.text = content.trackName
            }
            
            if let artistName = artistNameLabel {
                artistName.adjustsFontSizeToFitWidth = true
                artistName.minimumScaleFactor = 0.2
                artistName.text = content.artist
            }
            
            if let albumYear = albumYearLabel {
                albumYear.adjustsFontSizeToFitWidth = true
                albumYear.minimumScaleFactor = 0.2
                albumYear.numberOfLines = 0
                albumYear.text = "\(content.album) (\(content.year))"
            }
            
            if let genre = genreLabel {
                genre.adjustsFontSizeToFitWidth = true
                genre.minimumScaleFactor = 0.2
                genre.text = content.genre
            }
        }
    }
}
