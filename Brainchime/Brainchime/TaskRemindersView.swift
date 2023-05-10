import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool = false
    var scheduledDate: Date?
}

struct TaskRemindersView: View {
    @State private var tasks: [Task] = []
    @State private var newTask: String = ""
    @State private var showingDatePicker: Bool = false
    @State private var scheduledDate: Date = Date()
    
    var body: some View {

            
        VStack {
            List {
                ForEach(tasks) { task in
                    TaskRow(task: task, toggleCompletion: {
                        toggleCompletion(for: task)
                    })
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.black)
            .cornerRadius(10)
            .padding()
            
            HStack {
                TextField("Enter a new task", text: $newTask)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addTask) {
                    Text("Add")
                        .padding(.horizontal)
                }
                .disabled(newTask.isEmpty)
                
                Button(action: {
                    showingDatePicker.toggle()
                }) {
                    Image(systemName: "calendar")
                        .padding(.horizontal)
                }
                .sheet(isPresented: $showingDatePicker) {
                    DatePicker(selection: $scheduledDate, displayedComponents: [.date, .hourAndMinute]) {
                        Text("Select a date")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Reminders")
    }

    func addTask() {
        let task = Task(title: newTask, scheduledDate: scheduledDate)
        tasks.append(task)
        newTask = ""
    }
    
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

struct TaskRow: View {
    let task: Task
    let toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Button(action: toggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .foregroundColor(task.isCompleted ? .green : .gray)
            
            Text(task.title)
                .strikethrough(task.isCompleted)
            
            Spacer()
            
            if let scheduledDate = task.scheduledDate {
                Text("Scheduled for \(scheduledDate, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

struct TaskRemindersView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRemindersView()
    }
}
