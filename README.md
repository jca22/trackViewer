# mediaViewer
A simple application utilising Apple's iTunes search API to view media

Dependencies:
  Alamofire - Used for handling API requests
  
  SwiftyJSON - Handles easy parsing of JSON data
  
  RealmSwift - A convenient way of doing data persistence
  
Architecture:
  App makes use of the traditional MVC pattern to update and generate views. Made use of Xcode master-detail template to have a splitview controller setup. Views are generated using storyboard. A model 'Content' is used to represent a track and use it around the app for displaying data and also for persistence. MasterViewController handles data operations in the master view and MediaDetailViewController handles track details.
  
  A singleton class 'ActiveSession' is a helper class used for convenience with CRUD operations for data persistence. 
  
  Apple, by default, uses delegation pattern in most of its classes.
 
Persistence:
  This application makes use of RealmSwift for data persistence. Aside from the obvious convenience and easier way of writing the code, RealmSwift also is relatively faster compared to CoreData in my experience.
  
NOTE: Please install git-lfs prior to cloning as one of the dependecies contain some large files. See more information here: https://git-lfs.github.com/
