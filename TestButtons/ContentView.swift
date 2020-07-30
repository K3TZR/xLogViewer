//
//  ContentView.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/24/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    
    VStack {      
      LogView()
      ButtonsView()
    }.frame(minWidth: 600, idealWidth: 1000, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .topLeading)
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}




