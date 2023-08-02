//
//  WebView.swift
//  EventExplorer
//
//  Created by Julien Pretet on 01/08/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    @StateObject var viewModel: WebViewModel
    @State var webView = WKWebView()
    @Binding var didClickOnEvent: Bool

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self, viewModel: viewModel)
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if didClickOnEvent == true {
            self.webView.evaluateJavaScript("document.querySelectorAll('.event-wrapper')[0].querySelector('a').click();")
        }
    }

    func makeUIView(context: Context) -> WKWebView {

        self.webView.navigationDelegate = context.coordinator
        self.webView.isOpaque = false
        self.webView.backgroundColor = .gray
        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }

        return self.webView
    }
}


class WebViewCoordinator: NSObject, WKNavigationDelegate {

    let parent: WebView
    @ObservedObject var viewModel: WebViewModel

    init(_ parent: WebView, viewModel: WebViewModel) {
        self.parent = parent
        self.viewModel = viewModel
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if self.viewModel.isLoading == true {
            webView.evaluateJavaScript("document.querySelectorAll('.event-wrapper')[0].querySelector('span[itemprop=\"name\"]').textContent") { result, error in
                guard error == nil, let eventName = result as? String else {
                    self.viewModel.eventName = error.debugDescription
                    return
                }

                self.viewModel.eventName = eventName
            }
            self.viewModel.isLoading = false
        }
    }
}
