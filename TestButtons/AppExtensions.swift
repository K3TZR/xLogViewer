//
//  AppExtensions.swift
//  xSDR6000
//
//  Created by Douglas Adams on 9/22/15.
//  Copyright © 2015 Douglas Adams. All rights reserved.
//

import Cocoa

extension FileManager {
  
  static func appFolder(for bundleIdentifier: String) -> URL {
    let fileManager = FileManager.default
    let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask )
    let appFolderUrl = urls.first!.appendingPathComponent( bundleIdentifier )
    
    // does the folder exist?
    if !fileManager.fileExists( atPath: appFolderUrl.path ) {
      
      // NO, create it
      do {
        try fileManager.createDirectory( at: appFolderUrl, withIntermediateDirectories: true, attributes: nil)
      } catch let error as NSError {
        fatalError("Error creating App Support folder: \(error.localizedDescription)")
      }
    }
    return appFolderUrl
  }
}

@propertyWrapper struct Toggle {

  private var method : ()->Void
  var wrappedValue: Bool {
    didSet {
      if wrappedValue {
        method()
        wrappedValue = false
      }
    }
  }
  
  init(wrappedValue: Bool, method: @escaping ()->Void ) {
    self.wrappedValue = wrappedValue
    self.method = method
    
  }
}
