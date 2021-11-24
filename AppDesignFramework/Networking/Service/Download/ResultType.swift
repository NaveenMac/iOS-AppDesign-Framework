//
//  ResultType.swift
//  FileManager
//
//  Created by Naveen Chauhan on 19/11/21.
//

import Foundation

public enum ResultType<T> {

   public typealias Completion = (ResultType<T>) -> Void

   case success(T)
   case failure(Swift.Error)

}
