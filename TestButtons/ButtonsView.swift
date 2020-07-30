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
      
      Picker(selection: $data.messageLevel, label: Text("Log Level")) {
        ForEach(LogData.MessageLevel.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }
      .frame(width: 150, height: 20)
      .padding([.horizontal], 20)
      
      Picker(selection: $data.restriction, label: Text("Restriction")) {
        ForEach(LogData.Restriction.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }
      .frame(width: 150, height: 20)

      TextField("Enter restriction text", text: $data.restrictionText)
        .background(Color(.gray))
        .frame(width: 150, alignment: .leading)
      
      Spacer()
      HStack {
        Toggle("Show times", isOn: $data.showTimes)
          .frame(height: 20, alignment: .center)
        Spacer()
        Button(action: {self.data.reload = true}) {Text("Load")}
        Button(action: {self.data.save = true}) {Text("Save")}
      }
      .frame(width: 300)
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
