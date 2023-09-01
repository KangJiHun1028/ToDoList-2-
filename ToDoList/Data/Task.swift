//
//  Data.swift
//  ToDoList
//
//  Created by t2023-m0053 on 2023/08/30.
//

import Foundation

struct Task: Codable {
    var title: String
    var done: Bool // 새로운 completed 속성 추가
}
