//
//  PhotoContentView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 15/08/2024.
//  Copyright © 2024 whackylabs. All rights reserved.
//

import SwiftUI

struct PhotoContentView: View {
  var state: AppController.State
  var retryAction: () -> Void
  
  init(_ state: AppController.State, retryAction: @escaping () -> Void) {
    self.state = state
    self.retryAction = retryAction
  }
  
  var body: some View {
    switch state {
    case .loading:
      ProgressView()
    case .error:
      VStack {
        Text("Something went wrong.")
        Text("Please try again.")
        Button {
          retryAction()
        } label: {
          Text("Retry")
        }
        .padding()
      }
      
    case .data(let photos):
      PhotoListView(photos: photos)
    }
  }
}

#Preview("loading") {
  PhotoContentView(.loading, retryAction: {})
}

#Preview("error") {
  PhotoContentView(.error, retryAction: {})
}

#Preview("data") {
  PhotoContentView(.data(Photo.previews), retryAction: {})
}
