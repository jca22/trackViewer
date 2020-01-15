//
//  MasterViewController.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ContentDelegate {
    func onContentSelected(_ content: Content)
}

class MasterViewController: UITableViewController {

    var detailViewController: MediaDetailViewController? = nil
    var contentList = [Content]()
    
    var delegate: ContentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MediaDetailViewController
        }
        
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        navigationItem.title = "Media"
    }

    func loadData() {
        let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
        
        Alamofire.request(url, method: .get).responseData { response in
            switch response.result {
            case .success:
                if response.data != nil {
                    do {
                        let jsonData = try JSON(data: response.data!)
                        
                        if (jsonData == JSON.null) {
                            self.showAlert("", "No data to display")
                            return
                        }
                      
                        if let result = jsonData["results"].array {
                            for data in result {
                                if let trackName = data["trackName"].string, let artwork = data["artworkUrl60"].string,
                                    let price = data["trackPrice"].float, let currency = data["currency"].string,
                                    let genre = data["primaryGenreName"].string  {
                                    // Create a track object
                                    let track = Content()
                                    track.trackName = trackName
                                    track.artWorkURL = artwork
                                    track.trackPrice = price
                                    track.currency = currency
                                    track.genre = genre
                                    
                                    // Save artist name
                                    if let artist = data["artistName"].string {
                                        track.artist = artist
                                    }
                                    
                                    // Save 100x100 artwork
                                    if let artwork100 = data["artworkUrl100"].string {
                                        track.artWork100URL = artwork100
                                    }
                                    
                                    // Get album
                                    if let album = data["collectionName"].string {
                                        track.album = album
                                    }
                                    
                                    // Extract year, just did a manual string manipulation instead of Date formatters
                                    if let date = data["releaseDate"].string {
                                        if let year = Int(date.split(separator: "-", maxSplits: 1)[0]) {
                                            track.year = year
                                        }                                        
                                    }
                                    
                                    // Some tracks does not contain a long description so making this optionally added
                                    if let longDescription = data["longDescription"].string {
                                        track.longDescription = longDescription
                                    }
                                    
                                    self.contentList.append(track)
                                }
                            }
                            
                            if self.contentList.count > 0 {
                                self.tableView.reloadData()
                            }
                        } else {
                            self.showAlert("", "No data to display")
                            return
                        }
                    } catch {
                        self.showAlert("", "Unable to parse JSON!")
                    }
                }
                        
            case .failure(let error):
                print(error)
                self.showAlert("Error", error.localizedDescription)
                return
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let currentContent = contentList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! MediaDetailViewController
                controller.content = currentContent
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View delegate and datasource methos

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentContent = contentList[indexPath.row]
        var mediaCell = MediaCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "medialCell") as? MediaCell {
            mediaCell = cell
        }
        
        // Load image asynchronously
        let url = URL(string: currentContent.artWorkURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                DispatchQueue.main.async {
                    mediaCell.artWork.image = UIImage(data: data!)
                }
            }
        }
        
        // Load other data of cells
        mediaCell.trackNameLabel.text = currentContent.trackName
        mediaCell.genreLabel.text = currentContent.genre
        mediaCell.priceLabel.text = "\(currentContent.trackPrice) \(currentContent.currency)"
        
        return mediaCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contentList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Some useful methods
    
    
    func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""),
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
}

