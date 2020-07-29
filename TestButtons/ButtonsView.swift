//
//  ButtonsView.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/28/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import SwiftUI

struct ButtonsView: View {
  @EnvironmentObject var data : LogData
  
  var body: some View {
    HStack {
      
      Picker(selection: .constant(4), label: Text("Log Level")) {
        Text("Error").tag(1)
        Text("Warning").tag(2)
        Text("Debug").tag(3)
        Text("Info").tag(4)
      }
      .frame(width: 150, height: 20)
      .padding([.horizontal], 20)
      
      Spacer()
      HStack {
        Button(action: {self.data.loadLines()}) {Text("Load")}
        Button(action: {}) {Text("Save")}
      }
      .frame(width: 100)
      .padding([.horizontal], 20)
    }
    .padding([.vertical], 10)
  }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
      ButtonsView().environmentObject(LogData())
    }
}
