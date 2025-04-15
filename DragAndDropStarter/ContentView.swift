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
                .dropDestination(for: String.self) { droppedTasks, location in
                    for task in droppedTasks {
                        toDoTasks.removeAll(where: { $0 == task })
                        doneTasks.removeAll(where: { $0 == task })
                    }
                    inProgressTasks += droppedTasks
                    return true
                }

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
#if os(iOS)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
#elseif os(macOS)
                            .background(Color.gray)
#endif
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                            .draggable(task)
                    }

                    Spacer()
                }
                .padding(.vertical)
            }
        }
    }
}
