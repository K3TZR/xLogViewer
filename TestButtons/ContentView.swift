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
      ScrollingLogView().frame(minWidth: 200, alignment: .leading)
      ButtonsView()
      Spacer()
    }.frame(minWidth: 400, idealWidth: 800, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .topLeading)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ScrollingLogView: View {
  var body: some View {
    ScrollView {
      VStack {
        ForEach(0..<50) {
          Text("Line \($0) - A line of logging information")
            .frame(minWidth: 300, maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}

struct ButtonsView: View {
  var body: some View {
    HStack {
      
      Picker(selection: .constant(4), label: Text("Log Level")) {
        Text("Error").tag(1)
        Text("Warning").tag(2)
        Text("Debug").tag(3)
        Text("Info").tag(4)
      }
      .frame(width: 150, height: 20)
      .padding([.horizontal])
    
      Spacer()
      HStack {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {Text("Load")}
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {Text("Save")}
      }
      .frame(width: 100)
      .padding([.horizontal])
    }
//    .frame(minWidth: 400, idealWidth: 800, maxWidth: 1600, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .topLeading)
  }
}
