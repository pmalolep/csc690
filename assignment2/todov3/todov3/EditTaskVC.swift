//
//  editTaskVC.swift
//  todov3
//
//  Created by P M on 11/3/18.
//  Copyright © 2018 pmalolep. All rights reserved.
//

import UIKit


class EditTaskVC: UIViewController{
    
    var taskCTRL:TaskController = TaskController()
    var index:Int = 0
    var status:Bool = false
    
    override func viewDidLoad() {
        let task = taskCTRL.get(index)
        
        taskNameEntry.text = task.name
        status = task.status
        statusSwitch.setOn(status, animated: true)
        
        navigationItem.title = task.name
        
        //print("\(task.name) : \(status)")
    }
    
    @IBOutlet weak var taskNameEntry: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBAction func statusSwitch(_ sender: Any) {
        status = statusSwitch.isOn
    }
    
    
    @IBAction func acceptChangesBtnPressed(_ sender: Any) {
        let tempString = taskNameEntry.text ?? "new task"
        taskCTRL.set(name:tempString, status:status, index:index)
        //print("\(tempString):\(status)")
        //print("ACCEPT")
    }
    
    @IBAction func deleteTaskBtnPressed(_ sender: Any) {
        taskCTRL.remove(index)
        
        //print("DELETE")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC = segue.destination as! MainViewController
        mainVC.taskCTRL = taskCTRL
        saveData()
    }
    
    func saveData(){
        let nameList = taskCTRL.getNameList()
        let statusList = taskCTRL.getStatusList()
        UserDefaults.standard.set(nameList, forKey: "nameList")
        UserDefaults.standard.set(statusList, forKey: "statusList")
        //print("SAVED")
    }
    
}
