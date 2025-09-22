//
//  TranslateViewApp.swift
//  TranslateView
//
//  Created by Yuki Sasaki on 2025/09/22.
//

import SwiftUI

@main
struct TranslateViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
