//
//  LogData.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/25/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import Cocoa
import SwiftUI

public class LogData: ObservableObject {
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal properties
  
  enum MessageLevel: String, CaseIterable, Identifiable {
    case debug
    case info
    case warning
    case error
    
    var id: String { self.rawValue }
  }
  enum Restriction: String, CaseIterable, Identifiable {
    case none
    case prefix
    case includes
    case excludes
    
    var id: String { self.rawValue }
  }

  var reload  = false { didSet { if reload { loadLines() ; reload = false }}}
  var save    = false { didSet { if save { saveLogFile() ; save = false }}}

  // ----------------------------------------------------------------------------
  // MARK: - Published properties
  
  @Published var messageLevel : MessageLevel = .debug {
    didSet { logLines = filterLog(level: messageLevel, restriction: .none) }}
  @Published var logLines = [Line]()
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  private var _allLines     = [Line]()
  private var _openFileUrl  : URL?
  
  // ----------------------------------------------------------------------------
  // MARK: - Initialization
  
  init() {
    
    let appFolder = FileManager.appFolder(for: "net.k3tzr.xsdr6000/Logs")
    let logUrl = appFolder.appendingPathComponent("xSDR6000.log")
    
    let fileManager = FileManager()
    if fileManager.fileExists( atPath: logUrl.path ) {
      readLogFile(url: logUrl)
    }
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Private methods
  
  private func loadLines() {
    
    // allow the user to select a Log file
    let openPanel = NSOpenPanel()
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    openPanel.allowedFileTypes = ["log"]
    openPanel.directoryURL = FileManager.appFolder(for: "net.k3tzr.xsdr6000/Logs")
    
    if openPanel.runModal() == NSApplication.ModalResponse.OK {
      readLogFile(url: openPanel.url!)
    }
  }
  
  private func readLogFile(url: URL) {
    _allLines.removeAll()

    // save the current URL
    _openFileUrl = url
    
    // get the contents of the file
    let logString = try! String(contentsOf: url, encoding: .ascii)
    // parse it into lines
    let texts = logString.components(separatedBy: "\n")
    for (i, lineText) in texts.enumerated() {
      _allLines.append(Line(id: i, text: lineText ))
    }
    logLines = filterLog(level: messageLevel, restriction: .none)
  }
  
  private func filterLog(level: MessageLevel, restriction: Restriction, restrictionText: String = "") -> [Line] {
    var lines = [Line]()
    var limitedLines = [Line]()
    
    // filter the log entries
    switch level {
    case .debug:     lines = _allLines
    case .info:      lines = _allLines.filter { $0.text.contains(" [Error] ") || $0.text.contains(" [Warning] ") || $0.text.contains(" [Info] ") }
    case .warning:   lines = _allLines.filter { $0.text.contains(" [Error] ") || $0.text.contains(" [Warning] ") }
    case .error:     lines = _allLines.filter { $0.text.contains(" [Error] ") }
    }
    
    switch restriction {
    case .none:      limitedLines = lines
    case .prefix:    limitedLines = lines.filter { $0.text.hasPrefix(restrictionText) }
    case .includes:  limitedLines = lines.filter { $0.text.contains(restrictionText) }
    case .excludes:  limitedLines = lines.filter { !$0.text.contains(restrictionText) }
    }
    return limitedLines
  }

  
  private func saveLogFile() {
    
    let homeUrl = FileManager.default.homeDirectoryForCurrentUser
    let desktopUrl = homeUrl.appendingPathComponent("Desktop/")
    
    // Allow the User to save a copy of the Log file
    let savePanel = NSSavePanel()
    savePanel.allowedFileTypes = ["log"]
    savePanel.allowsOtherFileTypes = false
    savePanel.nameFieldStringValue = _openFileUrl?.lastPathComponent ?? ""
    savePanel.directoryURL = desktopUrl
    
    // if the user pressed Save
    if savePanel.runModal() == NSApplication.ModalResponse.OK {
      
      print("Copy \(_openFileUrl!) to \(savePanel.url!)")
      
      let fileManager = FileManager()
      try! fileManager.copyItem(at: _openFileUrl!, to: savePanel.url!)
    }
  }
}

