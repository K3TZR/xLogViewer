//
//  ScrollingLogView.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/27/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import SwiftUI

struct ScrollingLogView: View {

  var data : LogData

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

struct ScrollingLogView_Previews: PreviewProvider {
    static var previews: some View {
      ScrollingLogView(data: LogData())
    }
}
