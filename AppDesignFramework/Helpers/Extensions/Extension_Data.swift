//
//  Extension_Data.swift
//  FileManager
//
//  Created by Naveen Chauhan on 14/11/21.
//

import Foundation

extension Data {
    func sizeString(units: ByteCountFormatter.Units = [.useAll], countStyle: ByteCountFormatter.CountStyle = .file) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = units
        bcf.countStyle = .file

        return bcf.string(fromByteCount: Int64(count))
     }
}
