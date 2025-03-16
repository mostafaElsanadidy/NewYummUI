//
//  NewYummUIApp.swift
//  NewYummUI
//
//  Created by mostafa elsanadidy on 16.03.25.
//

import SwiftUI

@main
struct NewYummUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
