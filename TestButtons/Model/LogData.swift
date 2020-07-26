//
//  LogData.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/25/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import Cocoa

var logLines : [Line] = loadLines()

func loadLines() -> [Line] {
  var lines = [Line]()
  
  // allow the user to select a Log file
  let openPanel = NSOpenPanel()
  openPanel.canChooseFiles = true
  openPanel.canChooseDirectories = false
  openPanel.allowsMultipleSelection = false
  openPanel.allowedFileTypes = ["log"]
  openPanel.directoryURL = FileManager.appFolder(for: "net.k3tzr.xsdr6000/Logs")
  
    if openPanel.runModal() == NSApplication.ModalResponse.OK {
        let logString = try! String(contentsOf: openPanel.url!, encoding: .ascii)
        
        let texts = logString.components(separatedBy: "\n")
        for (i, lineText) in texts.enumerated() {
          lines.append(Line(id: i, text: lineText ))
        }
    }
    return lines
  }
