//
//  ViewController.swift
//  todov3
//
//  Created by P M on 11/3/18.
//  Copyright © 2018 pmalolep. All rights reserved.
//

import UIKit

struct Task{
    var name:String!
    var status:Bool!
}

class TaskController{
    
    var taskList:[Task]
    
    init(){
        taskList = []
    }
    
    init(namesList:[String],statusList:[Bool]){
        var index = 0
        taskList = []
        while index < namesList.count{
            taskList.append(Task(name: namesList[index], status: statusList[index]))
            index += 1
        }
    }
    
    func count()->Int{
        return taskList.count
    }
    
    func get(_ index:Int)->Task{
        return taskList[index]
    }
    
    func set(name:String,status:Bool,index:Int){
        taskList[index].name = name
        taskList[index].status = status
    }
    
    func remove(_ index:Int){
        taskList.remove(at: index)
    }
    
    func getIndexByName(name:String)->Int{
        var index = 0
        while index < taskList.count{
            if name == taskList[index].name{
                return index
            }
            index += 1
        }
        return index
    }
    
    func getNameList()->[String]{
        var nameList: [String] = []
        var index = 0
        while index < taskList.count{
            nameList.append(taskList[index].name)
            index += 1
        }
        return nameList
    }
    
    func getStatusList()->[Bool]{
        var statusList: [Bool] = []
        var index = 0
        while index < taskList.count{
            statusList.append(taskList[index].status)
            index += 1
        }
        return statusList
    }
    
    func new()->Int{
        taskList.append(Task(name: "new task", status: false))
        return taskList.count - 1
    }
    
    func new(name:String){
        taskList.append(Task(name: name, status: false))
    }
    
    func new(name:String,status:Bool){
        taskList.append(Task(name: name, status: status))
    }
    
    func uncompletedCount()->Int{
        var count = 0
        var index = 0
        while index < taskList.count{
            if taskList[index].status == false{
                count += 1
            }
            index += 1
        }
        return count
    }
    
    func completedCount()->Int{
        var count = 0
        var index = 0
        while index < taskList.count{
            if taskList[index].status == true{
                count += 1
            }
            index += 1
        }
        return count
    }
    
    func uncompletedList()->[String]{
        var list:[String] = []
        var index = 0
        while index < taskList.count{
            if taskList[index].status == false{
                list.append(taskList[index].name)
            }
            index += 1
        }
        return list
    }
    
    func completedList()->[String]{
        var list:[String] = []
        var index = 0
        while index < taskList.count{
            if taskList[index].status == true{
                list.append(taskList[index].name)
            }
            index += 1
        }
        return list
    }
    
    func printAll(){
        print("PRINTING LIST...")
        var index = 0
        while index < taskList.count{
            print("\(taskList[index].name) : \(taskList[index].status)")
            index += 1
        }
    }
    
    func getTruePosition(section:Int,row:Int)->Int{
        if section == 0{
            let index = getIndexByName(name: completedList()[row])
            //print("section:\(section) row:\(row) index:\(index)")
            return index
            
        }else{
            let index = getIndexByName(name: uncompletedList()[row])
            //print("section:\(section) row:\(row) index:\(index)")
            return index
        }
    }
}

class MainViewController: UITableViewController {

    var taskCTRL:TaskController = TaskController()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set default delegate and fix touch controls
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delaysContentTouches = false
        self.tableView.isEditing = false
        
        loadData()
        
        // set header and hide back button on main screen
        navigationItem.title = "iTaskManager"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .blue
        navigationItem.hidesBackButton = true
        
        //taskCTRL.printAll()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return taskCTRL.completedCount()
        } else{
            return  taskCTRL.uncompletedCount()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")!
        
        let taskName:String
        if indexPath.section == 0 {
            taskName = taskCTRL.completedList()[indexPath.row]
        }else{
            taskName = taskCTRL.uncompletedList()[indexPath.row]
        }
        
        //cell.textLabel?.text = "name:\(taskName) position:\(indexPath.row) section:\(indexPath.section)"
        cell.textLabel?.text = taskName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let completedHeader = UILabel()
            completedHeader.text = "COMPLETED"
            completedHeader.backgroundColor = .green
            return completedHeader
        }else {
            let uncompletedHeader = UILabel()
            uncompletedHeader.text = "NOT COMPLETED"
            uncompletedHeader.backgroundColor = .red
            return uncompletedHeader
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = taskCTRL.getTruePosition(section: indexPath.section, row: indexPath.row)
        self.performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! EditTaskVC
        
        editVC.taskCTRL = taskCTRL
        editVC.index = index
    }
    
    @IBAction func addNewTaskBtnPressed(_ sender: Any) {
        index = taskCTRL.new()
        self.performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    func loadData(){
        //print("LOADING")
        if let nameList = UserDefaults.standard.array(forKey: "nameList") as? [String],
            let statusList = UserDefaults.standard.array(forKey: "statusList") as? [Bool]
            {
                taskCTRL = TaskController(namesList: nameList, statusList: statusList)
                //print("LOADED")
        }else{
            taskCTRL.new()
            //print("FAILED TO LOAD")
        }
    }
}

