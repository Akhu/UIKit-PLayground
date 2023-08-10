//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 11/07/2023.
//

import UIKit
import QuickLook
import UniformTypeIdentifiers
import Foundation
import CoreServices

struct TableViewSectionFile {
    var fileList: [FileCustomData]
    var title: String
}

struct FileCustomData {
    let title: String
    let size: Int
    let url: URL
    let type: String
}

extension FileListViewController: QLPreviewControllerDataSource {
    
    
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return selectedUrlFile != nil ? 1 : 0
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        if let url = selectedUrlFile {
            return url as QLPreviewItem
        } else { fatalError("Could not load file") }
    }
}

extension FileListViewController: UIDocumentPickerDelegate {
    
    func openPreviewForData(_ data: Data){
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        urls.forEach { url in
            guard url.startAccessingSecurityScopedResource() else { return }
            
            defer {
                url.stopAccessingSecurityScopedResource()
                self.reloadSections()
                self.tableView.reloadData()
            }
            
            // Copying file to in app sandbox folder
            do {
                if #available(iOS 14.0, *) {
                    let resourceValues = try url.resourceValues(forKeys: [.fileSizeKey, .contentTypeKey])
                    guard let fileSize = resourceValues.fileSize else { return }
                    // check if filesize is inferior to 20 mb
                    if fileSize > 20_000_000 {
                        print("File is too big")
                        return
                    }
                }
                
                let destinationUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                if let destinationFolder = destinationUrls[safe: 0], let sections = self.sections {
                    let targetFileName = url.lastPathComponent
                    let targetUrl = destinationFolder.appendingPathComponent(targetFileName)
                    if !FileManager.default.fileExists(atPath: targetUrl.path) {
                        try FileManager.default.copyItem(at: url, to: targetUrl)
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}



class FileListViewController: UITableViewController {
    var files = [FileCustomData]()
    private var selectedUrlFile: URL?
    var importedFiles = [FileCustomData]()
    
    var sections: [TableViewSectionFile]?
    
    var selectedFileIndex: Int? = nil
    
    var allowedDocumentTypes: [String] {
        [
            FileReader.retreiveUTTypeForMimeType(mimeType: MimeType.jpeg)
        ]
    }
    
    let previewVC = QLPreviewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        self.reloadSections()
        
        self.navigationController?.isNavigationBarHidden = false
        title = "Files"
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importFile)),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
        ]
        
    }
    
    func reloadSections() {
        var bundleItems = [FileCustomData]()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if !item.hasSuffix("DS_Store") {
                let currentUrl = URL(fileURLWithPath: path + "/" + item)
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                   
                
                bundleItems.append(FileCustomData(title: resourcesValues.name!, size: resourcesValues.fileSize ?? 0, url: currentUrl, type: resourcesValues.contentType!.description))
                
            }
        }
        
        self.files = bundleItems
        
        do {
            var importedItems = [FileCustomData]()
            let uDirectoryUrls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let userDirectoryUrl = uDirectoryUrls[safe: 0] {
                try fm.contentsOfDirectory(atPath: userDirectoryUrl.path).forEach { pathInDirectory in
                    let url = userDirectoryUrl.appendingPathComponent                   (pathInDirectory)
                    let resourcesValues = try! url.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                    importedItems.append(FileCustomData(title: resourcesValues.name!, size: resourcesValues.fileSize!, url: url, type: resourcesValues.contentType!.description))
                    //importedItems.append(pathInDirectory)
                }
            }
            self.importedFiles = importedItems
        } catch {
            print(error.localizedDescription)
        }
        
        sections = [
            TableViewSectionFile(fileList: self.importedFiles, title: "Importations"),
            TableViewSectionFile(fileList: self.files, title: "Bundles")]
        
    }
    
    @objc func importFile() {
        //Do additional thing
        // 1. Open the picker
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeJPEG), String(kUTTypePNG), String(kUTTypePDF)], in: .open)
        
        documentPicker.delegate = self
        // Since unavailable before iOS 13
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true) {
            print("Document selected")
        }
        // 2. Select File (outside app)
        // 3. Save file in project
        // 4. Add file to the list of file to check if everything is ok (preview with QL)
    }
    
    @objc func actionTapped() {
        openEmailApp(toEmail: "me@anthony-dacruz.com", subject: "Hello Subject", body: "Hello Body")
    }
    
    func openEmailApp(toEmail: String, subject: String, body: String) {
        guard
            let subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let body = "Just testing ...".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {
            print("Error: Can't encode subject or body.")
            return
        }
        
        let urlString = "mailto:\(toEmail)?subject=\(subject)&body=\(body)"
        let url = URL(string:urlString)!
        
        UIApplication.shared.open(url)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        if let sectionsUnwrapped = self.sections {
            cell.textLabel?.text = sectionsUnwrapped[indexPath.section].fileList[indexPath.row].title
            cell.detailTextLabel?.text = ByteCountFormatter.string(fromByteCount: Int64(sectionsUnwrapped[indexPath.section].fileList[indexPath.row].size), countStyle: .file)
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionsArray = self.sections {
            return sectionsArray[section].fileList.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = self.sections {
            return sections[section].title
        }
        return nil
    }
    
    func instantiateQLPreviewController(withUrl url: URL) {
        self.selectedUrlFile = url
        let qlPreviewController = QLPreviewController()
        qlPreviewController.dataSource = self
        //qlPreviewController.fileUrl = url
        //qlPreviewController.pageTitle = "My Preview Page File"
        //qlPreviewController.currentPreviewItemIndex = indexPath.row
        
        navigationController?.present(qlPreviewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//                vc.selectedImage = files[indexPath.row]
//                navigationController?.isNavigationBarHidden = false
//                navigationController?.pushViewController(vc, animated: true)
//            }
//
//        let wrapperVC = PreviewWrapperViewController()
//        wrapperVC.
        
        
        
        if let sectionUnwrapped = self.sections {
            let file = sectionUnwrapped[indexPath.section].fileList[indexPath.row]
            self.instantiateQLPreviewController(withUrl: file.url)
        }
//
////            self.addChild(qlPreviewController)
////
////            qlPreviewController.view.frame = self.view.bounds
////            qlPreviewController.didMove(toParent: self)
//
//            navigationController?.pushViewController(qlPreviewController, animated: true)
        }
}

