//
//  TaskModel.swift
//  To-Do List
//
//  Created by Lesha Mednikov on 12.07.2023.
//
import UIKit
import CoreData
class TaskModel {
    var tasks = [NSManagedObject]()
    var selectedIndexes = Set<Int>()
    func saveTask(toDoSave: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let task = NSManagedObject(entity: entity, insertInto: context)
        task.setValue(toDoSave, forKey: "toDo")
        do {
            try context.save()
            tasks.insert(task, at: 0)
        } catch {
        }
    }
    func updateSelectedState(at index: Int, isSelected: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let task = tasks[index]
        task.setValue(isSelected, forKey: "isSelected")
        do {
            try context.save()
            if isSelected {
                selectedIndexes.insert(index)
            } else {
                selectedIndexes.remove(index)
            }
        } catch {
        }
    }
    func fetchTask(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let result = try context.fetch(fetchRequest)
            tasks = result as! [NSManagedObject]
            tasks.reverse()
        } catch {
        }
    }
    func deleteTask(at: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            context.delete(tasks[at])
            tasks.remove(at: at)
            try context.save()
        } catch {
        }
    }
}
