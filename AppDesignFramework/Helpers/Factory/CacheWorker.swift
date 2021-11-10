//
//  CacheWorker.swift
//  FileManager
//
//  Created by Naveen Chauhan on 26/10/21.
//

import Foundation
import RealmSwift

class CacheWorker: BackgroundWorker {
  private var token: NotificationToken?

  override init() {
    super.init()
    start { [weak self] in
      let realm = try! Realm()
      let files = realm.objects(DataObject.self)
        .filter("localPath = ''")
        
      self?.token = files.observe { changes in
        switch changes {
        case .update(_, _, let insertions, _):
          for index in insertions {
            
          //  print("download: \(files[index].name)")
//            print("[main thread: \(Thread.isMainThread)]")
            // download from web ...
            // update files[index].localUrl = "file:///..."
          }
        default: break
        }
      }
    }
  }

  deinit {
    token?.invalidate()
  }
}
