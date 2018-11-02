//
//  RoutineClass.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 8/28/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

class Routine {
    var id: Int
    var name: String
    var duration: Int?

    init(id: Int, name: String, duration: Int) {
        self.id = id
        self.name = name
        self.duration = duration
    }
}
