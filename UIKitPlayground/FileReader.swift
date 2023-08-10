//
//  FileReader.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 11/07/2023.
//

import Foundation
import CoreServices


extension Data {
    func copyTo(folder: URL, withFileName fileName: String) throws -> URL {
        if #available(iOS 16.0, *) {
            return try self.copyToUrl(folder.appending(component: fileName))
        } else {
            return try self.copyToUrl(folder.appendingPathComponent(fileName))
        }
    }
    func copyToUrl(_ destinationUrl: URL) throws -> URL {
        
        try self.write(to: destinationUrl, options: .atomic)
        return destinationUrl
    }
}

public class FileReader {
    
    static func retreiveUTTypeForMimeType(mimeType: MimeType) -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, mimeType.rawValue as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return MimeType.octetStream.rawValue
    }
    
    static func loadContent(ofUrl url: URL) -> Data? {
        return FileManager.default.contents(atPath: url.path)
    }
    
    static func writeContent(toUrl: URL, toDirectory: FileManager.SearchPathDirectory, in: FileManager.SearchPathDomainMask) {
        
    }
    
    static func getPath(ofFileName fileName: String, withExtension type: String = "json") -> String? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.path(forResource: fileName, ofType: type) else {
            return nil
        }
        
        return pathOfFile
    }
    
    static func getUrl(ofFileName fileName: String, withExtension type: String = "json") -> URL? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.url(forResource: fileName, withExtension: type) else {
            return nil
        }
        
        return pathOfFile
    }
    
    static func getRawContent(ofFileName fileName:String, withExtension type: String = "json") -> Data? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.url(forResource: fileName, withExtension: type) else {
            print("[FILE][ERROR] Cannot find file for path : \(fileName).\(type)")
            return nil
        }
        
        
        guard let contentData = try? Data(contentsOf: pathOfFile) else {
            print("[FILE][ERROR] Cannot read file : \(fileName).\(type)")
            return nil
        }
        
        return contentData
    }
    
    static func getContent(ofFileName fileName:String, withExtension type: String = "json") -> Data? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.path(forResource: fileName, ofType: type) else {
            print("[FILE][ERROR] Cannot find file for path : \(fileName).\(type)")
            return nil
        }
        
        guard let contentString = try? String(contentsOfFile: pathOfFile, encoding: String.Encoding.utf8) else {
            print("[FILE][ERROR] Cannot read file : \(fileName).\(type)")
            return nil
        }
        
        guard let dataFromFile = contentString.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            print("[FILE][ERROR] Cannot decode file : \(fileName).\(type)")
            return nil
        }
        
        return dataFromFile
    }
}
