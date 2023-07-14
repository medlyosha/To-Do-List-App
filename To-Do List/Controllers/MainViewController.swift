//
//  ViewController.swift
//  To-Do List
//
//  Created by Lesha Mednikov on 12.07.2023.
//

import UIKit
class MainViewController: UIViewController {
    weak var mainView: MainView? {return self.view as? MainView}
    var taskModel = TaskModel()
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do List"
        mainView?.taskTableView.dataSource = self
        taskModel.fetchTask()
        self.mainView?.delegate = self
        self.navigationItem.rightBarButtonItem = mainView?.addButton
        mainView?.addButton.target = self
        mainView?.addButton.action = #selector(addButtonTapped)
    }
    func presentNewTaskAlert() {
        let alert = UIAlertController(title: "New task", message: " ", preferredStyle: .alert)
        alert.addTextField { field in field.placeholder = "Enter new task"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        self?.taskModel.saveTask(toDoSave: text)
                        self?.mainView?.taskTableView.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
}
extension MainViewController: MainViewDelegate, TaskTableViewCellDelegate, UITableViewDataSource {
    @objc func addButtonTapped() {
        presentNewTaskAlert()
    }
    func checkboxButtonTapped(at indexPath: IndexPath) {
        let selectedTask = taskModel.tasks[indexPath.row]
        let isSelected = selectedTask.value(forKey: "isSelected") as? Bool ?? false
            taskModel.updateSelectedState(at: indexPath.row, isSelected: !isSelected)
            mainView?.taskTableView.reloadRows(at: [indexPath], with: .none)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskModel.tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell
        if let cell = cell {
            cell.taskLabel.text = taskModel.tasks[indexPath.row].value(forKey: "toDo") as? String
        let isSelected = taskModel.tasks[indexPath.row].value(forKey: "isSelected") as? Bool ?? false
            cell.checkboxButton.isSelected = isSelected
            cell.delegate = self
            cell.indexPath = indexPath
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskModel.deleteTask(at: indexPath.row)
        }
        tableView.reloadData()
    }
}
