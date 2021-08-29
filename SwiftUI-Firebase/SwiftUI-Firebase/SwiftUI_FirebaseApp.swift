//
//  SwiftUI_FirebaseApp.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI

@main
struct SwiftUI_FirebaseApp: App {
    @StateObject private var quotesFactory = QuotesFactory()
    var body: some Scene {
        WindowGroup {
            ContentView(quotesFactory: testFactory)
        }
    }
}
