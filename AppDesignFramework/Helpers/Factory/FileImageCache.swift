//
//  ImageCache.swift
//  FileManager
//
//  Created by Naveen Chauhan on 13/11/21.
//
import UIKit
import Foundation
//public class FileImageCache {
//    
//    public static let publicCache = FileImageCache()
//    var placeholderImage = UIImage(named: "menu")!
//    private let cachedImages = NSCache<File, UIImage>()
//    //private var loadingResponses = [NSURL: [(Item, UIImage?, Data?) -> Swift.Void]]()
//    private var loadingFileResponses = [File: [(File,UIImage?,Data?) -> Swift.Void]]()
//    
//    public final func image(file: File) -> UIImage? {
//        return cachedImages.object(forKey: file)
//    }
//    /// - Tag: cache
//    // Returns the cached image if available, otherwise asynchronously loads and caches it.
//    final func load(file: File, request:NSURLRequest, completion: @escaping (File,UIImage?,Data?) -> Swift.Void) {
//        // Check for a cached image.
//        if let cachedImage = image(file: file) {
//            DispatchQueue.main.async {
//                completion(file, cachedImage,nil)
//            }
//            return
//        }
//        // In case there are more than one requestor for the image, we append their completion block.
//        if loadingFileResponses[file] != nil {
//            loadingFileResponses[file]?.append(completion)
//            return
//        } else {
//            loadingFileResponses[file] = [completion]
//        }
//        // Go fetch the image.
//        ImageFileProtocol.urlSession().dataTask(with: request as URLRequest) { (data, response, error) in
//            // Check for the error, then data and try to create the image.
//            guard let responseData = data, let image = UIImage(data: responseData),
//                let blocks = self.loadingFileResponses[file], error == nil else {
//                DispatchQueue.main.async {
//                    completion(file,nil,data)
//                }
//                return
//            }
//            // Cache the image.
//            self.cachedImages.setObject(image, forKey: file, cost: responseData.count)
//            // Iterate over each requestor for the image and pass it back.
//            for block in blocks {
//                DispatchQueue.main.async {
//                    block(file,image,data)
//                }
//                return
//            }
//        }.resume()
//    }
//    
//    
//    
//       
//}
