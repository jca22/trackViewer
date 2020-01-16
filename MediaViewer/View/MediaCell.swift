//
//  MediaCell.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

/*
    MediaCell class represents a row in the table view.
 */

import Foundation
import UIKit
import Alamofire

class MediaCell: UITableViewCell {
    // MARK: - Properties
    
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset to placeholder image to avoid incorrect/duplicate images
        artWork.image = #imageLiteral(resourceName: "img_placeholder")
    }
}
