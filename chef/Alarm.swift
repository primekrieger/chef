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
    dynamic var hour = 0
    dynamic var minute = 0
    let shouldRepeatOnDays = List<RealmBool>()
}

class RealmBool: Object {
    dynamic var value = false
}
