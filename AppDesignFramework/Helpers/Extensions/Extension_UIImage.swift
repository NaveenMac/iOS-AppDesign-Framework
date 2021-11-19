//
//  Extension_UIImage.swift
//  FileManager
//
//  Created by Naveen Chauhan on 16/11/21.
//

import UIKit

extension UIImage {
    static let curveImage = UIImage(named: "transparent-curve")
    static let filesHeader = UIImage(named: "files-background")
    static let trashBin = UIImage(named: "empty-drive")
    
    static let uploadImage = UIImage(named: "upload-cloud")
    
    static let chevronRight = UIImage(named: "chevron-right")
    
    
    static func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
    
}


