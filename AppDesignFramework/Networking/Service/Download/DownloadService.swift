//
//  DownloadService.swift
//  FileManager
//
//  Created by Naveen Chauhan on 19/11/21.
//

import UIKit

 class DownloadService: NSObject {

   private var session: URLSession!
   private var downloadTasks = [GenericDownloadTask]()

   public static let shared = DownloadService()

   private override init() {
      super.init()
      let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    configuration.urlCache = nil
    
      session = URLSession(configuration: configuration,
                           delegate: self, delegateQueue: nil)
   }

   func download(request: URLRequest) -> DownloadTask {
      let task = session.dataTask(with: request)
      let downloadTask = GenericDownloadTask(task: task)
      downloadTasks.append(downloadTask)
      return downloadTask
   }
}


extension DownloadService: URLSessionDataDelegate {

   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                   completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {

      guard let task = downloadTasks.first(where: { $0.task == dataTask }) else {
         completionHandler(.cancel)
         return
      }
      task.expectedContentLength = response.expectedContentLength
    
      completionHandler(.allow)
   }

   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
      guard let task = downloadTasks.first(where: { $0.task == dataTask }) else {
         return
      }
      task.buffer.append(data)
      
      let percentageDownloaded = Double(task.buffer.count) / Double(task.expectedContentLength)
   
        DispatchQueue.main.async {
            task.progressHandler?(Double(task.expectedContentLength),percentageDownloaded)
         }
   
   }

   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      guard let index = downloadTasks.index(where: { $0.task == task }) else {
         return
      }
      let task = downloadTasks.remove(at: index)
      DispatchQueue.main.async {
         if let e = error {
            task.completionHandler?(.failure(e))
         } else {
            task.completionHandler?(.success(task.buffer))
         }
      }
   }
}




