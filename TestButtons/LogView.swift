//
//  LogView.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/28/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import SwiftUI

struct LogView: View {
  @EnvironmentObject var data : LogData
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(data.logLines) { line in
          HStack{
            Text(line.text)
              .font(.system(.subheadline, design: .monospaced))
              .padding(.leading, 2)
              .foregroundColor(Color.black)
            Spacer()
          }
          .frame(maxHeight: 15)
          .multilineTextAlignment(.leading)
        }
      }
    }
    .foregroundColor(.black)
    .background(Color(.lightGray))
  }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
      LogView().environmentObject(LogData())
    }
}
