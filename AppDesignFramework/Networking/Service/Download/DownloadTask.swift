//
//  DownloadTask.swift
//  FileManager
//
//  Created by Naveen Chauhan on 19/11/21.
//

import Foundation



protocol DownloadTask {

   var completionHandler: ResultType<Data>.Completion? { get set }
   var progressHandler: ((Double,Double) -> Void)? { get set }

   func resume()
   func suspend()
   func cancel()
}
