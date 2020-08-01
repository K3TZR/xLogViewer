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
    }.frame(minWidth: 900, idealWidth: 1200, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .center)
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}




