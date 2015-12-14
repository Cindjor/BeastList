//
//  Database.swift
//  BeastList
//
//  Created by Luke CHEUNG on 11/13/15.
//  Copyright © 2015 Luke Cheung. All rights reserved.
//

import Foundation

class Database {
    static func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String];
        return paths[0]
    }
    static func dataFilePath(schema: String) -> String{
        return "\(Database.documentsDirectory())/\(schema)"
        Database.dataFilePath("BeastList")
    }
    static func save(arrayOfObjects: [AnyObject], toSchema: String, forKey: String) {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(arrayOfObjects, forKey: "\(forKey)")
        archiver.finishEncoding()
            data.writeToFile(Database.dataFilePath(toSchema), atomically: true)
        Database.save(arrayOfTasks, toSchema: "theList", forKey: "Tasks")
    }
}

class Task: NSObject, NSCoding {
    static let key: String = "Tasks"
    static let schema: String = "theList"
    var objective: String
    var createdAt: NSDate
    
    init(obj: String) {
        objective = obj //this is for creating a new Task
        createdAt = NSDate()
        
    }
    func encodeWithCoder(aCoder: NSCoder) { //NScoding protocol used for encoding(saving) objects
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    required init?(coder aDecoder: NSCoder) { // used to decode and load objects
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    static func all() -> [Task] {
        var tasks = [Task]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedArchiver(forWritingWithMutableData: data)
                tasks = unarchiver.decodeObjectForKey(Task.key) as! [Task]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }
    func save() {
        var tasksFromStorage = Task.all()
        var exists = false
        for var i = 0; i < tasksFromStorage.count; ++i {
            if tasksFromStorage[i].createdAt == self.createdAt {
                tasksFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            tasksFromStorage.append(self)
        }
        Database.save(tasksFromStorage, toSchema: Task.schema, forKey: Task.key)
    }
}