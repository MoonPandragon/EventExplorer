//
//  ContentView.swift
//  EventExplorer
//
//  Created by Julien Pretet on 01/08/2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject var webViewModel = WebViewModel()
    @State var didClickOnEvent: Bool = false

    var body: some View {
        VStack {
            Text("Events Explorer")
                .font(.custom("Helvetica", size: 32))
                .padding()
            WebView(viewModel: self.webViewModel, didClickOnEvent: $didClickOnEvent)
                .padding()
            Text(webViewModel.eventName.isEmpty ? webViewModel.loadingText : webViewModel.eventName)
                .onTapGesture {
                    self.didClickOnEvent = true
                }
                .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
