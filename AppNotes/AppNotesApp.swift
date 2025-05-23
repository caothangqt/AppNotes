//
//  AppNotes.swift
//  AppNotes
//
//  Created by Tran Cao Thang on 15/02/2025.
//

import SwiftUI

@main
struct NotesToDocApp: App {
    let coreDataManager = CoreDataManager()
    @StateObject var notesViewModel: NotesViewModel

        init() {
            let viewModel = NotesViewModel(manager: coreDataManager)
            _notesViewModel = StateObject(wrappedValue: viewModel)
        }


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notesViewModel)
        }
    }
}
