//
//  QLPreviewViewController.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 27/07/2023.
//

import UIKit
import QuickLook




class QLPreviewViewController: QLPreviewController {

    var fileUrl: URL?
    var pageTitle: String?
    
    var fileList: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pageTitle
    }
    
    // MARK: - Navigation
    
    

}
