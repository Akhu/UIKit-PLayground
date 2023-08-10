//
//  ActivityViewControllerImple.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 26/07/2023.
//

import Foundation
import UIKit
import LinkPresentation
import MobileCoreServices


import UniformTypeIdentifiers

class ImageActivityItemSource: NSObject, UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if let file = fileToShare {
            return file
        }
        if let url = urlToFile {
            return url
        }
        return nil
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
    
    @available(iOS 13.0, *)
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        if let file = fileToShare {
            let metadata = LPLinkMetadata()
            metadata.title = title
            metadata.iconProvider = NSItemProvider(object: UIImage(data: file)!)
            // Trick to put a subtitle
            metadata.originalURL = URL(fileURLWithPath: text)
            return metadata
        }
        return nil
    }
    
    var title: String
    var text: String
    var fileToShare: Data?
    var urlToFile: URL?
    
    init(title: String, text: String, fileToShare: Data?, urlToFile: URL?) {
        self.title = title
        self.text = text
        self.fileToShare = fileToShare
        self.urlToFile = urlToFile
        super.init()
    }
}
