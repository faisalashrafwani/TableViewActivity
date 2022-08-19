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
    var readyToStartNext: Bool

}
/*
 let cell = activityTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityTableViewCell
 
 cell.activityNameLbl.text = dataForActivity[indexPath.row].title
 cell.startStopButton.setTitle("START", for: .normal)
 cell.completedDateTimeStack.isHidden = true
 
 if (dataForActivity[indexPath.row].startDateTime != nil ) { //&& dataForActivity[indexPath.row].endDateTime == nil
     cell.contentView.alpha = 1
     cell.selectionStyle = .default
     
     if (dataForActivity[indexPath.row].startDateTime != nil && dataForActivity[indexPath.row].endDateTime != nil) {
         cell.startStopButton.isHidden = false
         
     }
     
 }
 
 else {
     cell.contentView.alpha = 0.5
     cell.selectionStyle = .none
 }
 
 cell.callbackForStartStopButton = {
     
     if cell.startStopButton.titleLabel?.text == "START" {
         cell.startStopButton.setTitle("STOP", for: .normal)
//                print("Here: \(indexPath.row)")
         //TODO: TIMER FUNCTION HERE
         
     } else {
         
         if (indexPath.row < self.dataForActivity.count - 1) {
             self.dataForActivity[indexPath.row + 1].startDateTime = self.getDateTime()
             self.dataForActivity[indexPath.row + 1].endDateTime = self.getDateTime()
             
         }
         self.activityTableView.reloadData()
         
     }
     
 }
 
 return cell
 */














/*
 //        if (dataForActivity[indexPath.row].startDateTime != nil) {
 //            if (dataForActivity[indexPath.row].endDateTime != nil) {
 //
 //                //TODO: FOR SECOND CELL
 //                cell.doneBtn.isHidden = true
 //                cell.CheckAndDateStackView.isHidden = false
 //
 //            }
 //
 //            else {
 //                //TODO: FOR FIRST CELL
 //                cell.doneBtn.isHidden = false
 //                cell.CheckAndDateStackView.isHidden = true
 //
 //                cell.callbackForDoneButton = {
 //
 //                    cell.doneBtn.isHidden = true
 //                    cell.CheckAndDateStackView.isHidden = false
 //                    cell.yetToStartLbl.isHidden = true
 //                    let dateTime = self.getDateTime()
 //
 //                    self.dataForActivity[indexPath.row].endDateTime = dateTime
 //                    if (indexPath.row < 4) {
 //                        self.dataForActivity[indexPath.row + 1].startDateTime = dateTime
 //                    }
 //
 //                    self.activityTableView.reloadData()
 //                }
 //            }
 //
 //            cell.dateTimeLbl.text = dataForActivity[indexPath.row].endDateTime
 //            cell.yetToStartLbl.isHidden = true
 //            cell.contentView.alpha = 1
 //
 //
 //
 //        } else {
 //            cell.doneBtn.isHidden = true
 //            cell.yetToStartLbl.isHidden = false
 //            cell.CheckAndDateStackView.isHidden = true
 //            cell.contentView.alpha = 0.5
 //            cell.selectionStyle = .none
 //        }

 */
