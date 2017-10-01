//
//  Alarm.swift
//  chef
//
//  Created by Diwakar Kamboj on 20/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class Alarm: Object {
    dynamic var uuid = NSUUID().uuidString
    dynamic var hour = 0
    dynamic var minute = 0
    let shouldRepeatOnDays = List<RealmBool>()
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

class RealmBool: Object {
    dynamic var uuid = NSUUID().uuidString
    dynamic var value = false
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
