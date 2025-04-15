//
//  ContentView.swift
//  DragAndDropStarter
//
//  Created by Sean Allen on 7/18/23.
//

import SwiftUI

struct ContentView: View {

    @State private var toDoTasks: [String] = ["@Observable Migration", "Keyframe Animations", "Migrate to Swift Data"]
    @State private var inProgressTasks: [String] = []
    @State private var doneTasks: [String] = []

    var body: some View {
        HStack(spacing: 12) {
            KanbanView(title: "To Do", tasks: toDoTasks)
            KanbanView(title: "In Progress", tasks: inProgressTasks)
            KanbanView(title: "Done", tasks: doneTasks)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

struct KanbanView: View {

    let title: String
    let tasks: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.footnote.bold())

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.secondarySystemFill))

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                    }

                    Spacer()
                }
                .padding(.vertical)
            }
        }
    }
}
