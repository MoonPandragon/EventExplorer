//
//  WebViewModel.swift
//  EventExplorer
//
//  Created by Julien Pretet on 02/08/2023.
//

import Combine

final class WebViewModel: ObservableObject {
    @Published var url: String = "https://www.sfstation.com/calendar"
    @Published var isLoading: Bool = true
    @Published var loadingText: String = "Loading..."
    @Published var eventName: String = ""
}
