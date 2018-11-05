//
//  todov3Tests.swift
//  todov3Tests
//
//  Created by P M on 11/3/18.
//  Copyright © 2018 pmalolep. All rights reserved.
//

import XCTest
@testable import todov3

class todov3Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_newTask(){
        let taskCTRL = TaskController()
        let count = taskCTRL.count()
        let index = taskCTRL.new()
        
        XCTAssert( count + 1 == taskCTRL.count())
        XCTAssert( index == taskCTRL.count() - 1)
        XCTAssert( taskCTRL.get(taskCTRL.count()-1).name == "new task")
    }
    
    func test_delete(){
        let taskCTRL = TaskController()
        taskCTRL.new()
        taskCTRL.remove(0)
        
        XCTAssert(taskCTRL.count() == 0)
    }
    
    func test_statusSwitch(){
        let taskCTRL = TaskController()
        taskCTRL.new(name: "test task", status: false)
        taskCTRL.set(name: "test task", status: true, index: 0)
        
        XCTAssert(taskCTRL.get(0).name == "test task")
        XCTAssert(taskCTRL.get(0).status == true)
        
    }
    
    func test_nameSwitch(){
        let taskCTRL = TaskController()
        taskCTRL.new(name: "test task", status: false)
        taskCTRL.set(name: "hello", status: false, index: 0)
        
        XCTAssert(taskCTRL.get(0).name == "hello")
        XCTAssert(taskCTRL.get(0).status == false)
        
    }
    
    func test_lists(){
        let taskCTRL = TaskController()
        taskCTRL.new()
        taskCTRL.new(name: "test 1", status: true)
        taskCTRL.new(name: "test 2", status: true)
        
        XCTAssert( taskCTRL.completedCount() == 2)
        XCTAssert( taskCTRL.uncompletedCount() == 1)
        XCTAssert( taskCTRL.getTruePosition(section: 1, row: 0) == 0)
    }
    
    
}
