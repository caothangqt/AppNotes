//
//  ContentView.swift
//  ToDoList
//
//  Created by Tran Cao Thang on 15/02/2025.
//


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notesViewModel: NotesViewModel

    var body: some View {
        
        Group {
            if notesViewModel.isDataLoaded {
                NotesView()
            } else {
                ProgressView("Loading...")
            }
        }
    }
}
