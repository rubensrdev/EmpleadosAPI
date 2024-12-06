//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Empleados API App")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    EntryView()
}
