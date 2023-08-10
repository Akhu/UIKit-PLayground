//
//  MimeTypeTools.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 07/08/2023.
//

import Foundation

public extension String {
    /// The path extension, if any, of the string as interpreted as a path.
   var pathExtension: String {
        return (self as NSString).pathExtension
  }
}

// Code inside modules can be shared between pages and other source files.
public enum MimeType: String, CaseIterable {
    // text
    case html = "text/html"
    case plain = "text/plain"
    case css = "text/css"
    case xml = "text/xml"
    case sgml = "text/sgml"
    case xspeech = "text/x-speech"
    case xsql = "text/x-sql"
    
    // image
    case gif = "image/gif"
    case jpeg = "image/jpeg"
    case tiff = "image/tiff"
    case png = "image/png"
    case svg = "image/svg+xml"
    case bmp = "image/x-ms-bmp"
    case xwd = "image/x-xwindowdump"
    case ief = "image/ief"
    case g3f = "image/g3fax"
    case psd = "image/x-psd"
    case freehand = "image/x-freehand"
    
    case eml = "message/rfc822"
    
    case pdf = "application/pdf"
    
    // word
    case odt = "application/vnd.oasis.opendocument.text"
    case odp = "application/vnd.oasis.opendocument.presentation"
    case ods = "application/vnd.oasis.opendocument.spreadsheet"
    case odb = "application/vnd.oasis.opendocument.database"
    
    case doc = "application/msword"
    case xls = "application/vnd.ms-excel"
    case msg = "application/vnd.ms-outlook"
    
    case docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    case xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    case dotx = "vnd.openxmlformats-officedocument.wordprocessingml.template"
    case xltx = "application/application/vnd.openxmlformats-officedocument.spreadsheetml.template "
    case xlsb = "application/application/vnd.ms-excel.sheet.binary.macroEnabled.12"
    case docm = "application/vnd.ms-word.document.macroEnabled.12"
    case dotm = "application/vnd.ms-word.template.macroEnabled.12"
    case xlam = "application/vnd.ms-excel.addin.macroEnabled.12"
    
    case ppt = "application/vnd.ms-powerpoint"
    case pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    case mpp = "application/vnd.ms-project"
    case mdb = "application/vnd.ms-access"
    case vsd = "application/vnd.visio"
    case pub = "application/x-mspublisher"
    
    case dcm = "application/dicom"
    case rtf = "application/rtf"
    case postscript = "application/postscript"
    case xtex = "application/x-tex"
    case xlatex = "application/x-latex"
    case xtexinfo = "application/x-texinfo"
    case troff = "application/x-troff"
    case mif = "application/x-mif"
    
    case zip = "application/zip"
    case rar = "application/x-rar-compressed"
    case tar = "application/x-tar"
    case gzip = "application/x-gzip"
    case tgz = "application/x-compressed-tar"
    
    case basic = "audio/basic"
    case midi = "audio/midi"
    case aifc = "audio/x-aifc"
    case aif = "audio/x-aiff"
    case mpga = "audio/mpeg"
    case mpa = "audio/x-mpeg"
    case mp2a = "audio/x-mpeg2"
    case wav = "audio/x-wav"
    case echospeed = "audio/echospeed"
    case vox = "audio/voxware"
    case aac = "audio/aac"
    case ogg = "audio/ogg"
    
    case mpeg = "video/mpeg"
    case mpv2 = "video/mpeg2"
    case quicktime = "video/quicktime"
    case avi = "video/x-msvideo"
    case movie = "video/x-sgi-movie"
    
    case m4a = "audio/mp4a-latm"
    case json = "application/json"
    case octetStream = "application/octet-stream"

    public static func getMimeEnumFromExtension(_ pathExtension: String) -> MimeType? {
return         MimeType.allCases.first { "\($0)" == pathExtension }
    }
    
    
    public var value: String? {
        return String(describing: self)
    }
    
    public func getExtension() -> String? {
        guard let value = value else {
            return nil
        }
        return "." + value
    }
    
    public func needToOpenInQl() -> Bool {
        switch self {
        case .pdf, .gif, .jpeg, .tiff, .png, .svg, .bmp, .xwd, .ief, .g3f, .psd, .freehand, .html:
            return false
        default:
            return true
        }
    }
}
