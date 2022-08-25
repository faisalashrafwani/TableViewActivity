//
//  ActivityModel.swift
//  TableViewActivity
//
//  Created by admin on 16/08/22.
//
import Foundation
struct ActivityModel {
    var id: Int?
    var title: String
    var startDateTime: String?
    var endDateTime: String?
    var duration: Int?
    var status: ActivityStatus

}

enum ActivityStatus {
    case yetToReady
    case readyToStart
    case ongoing
    case completed
    
}
