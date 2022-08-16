//
//  ViewController.swift
//  TableViewActivity
//
//  Created by admin on 16/08/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityTableView: UITableView!
    var dataForActivity = [ActivityModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity1 = ActivityModel(id: 0, title: "Activity 1", startDateTime: nil, endDateTime: nil, yetToStart: "yet to start")
        dataForActivity.append(activity1)
        let activity2 = ActivityModel(id: 1, title: "Activity 2", startDateTime: nil, endDateTime: nil, yetToStart: "yet to start")
        dataForActivity.append(activity2)
        let activity3 = ActivityModel(id: 2, title: "Activity 3", startDateTime: nil, endDateTime: nil, yetToStart: "yet to start")
        dataForActivity.append(activity3)
        let activity4 = ActivityModel(id: 3, title: "Activity 4", startDateTime: nil, endDateTime: nil, yetToStart: "yet to start")
        dataForActivity.append(activity4)
        let activity5 = ActivityModel(id: 4, title: "Activity 5", startDateTime: nil, endDateTime: nil, yetToStart: "yet to start")
        dataForActivity.append(activity5)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityTableView.isHidden = true
        showAlert()
    }
    
    
    
    
    
    
    
    //TODO: SHOWING ALERT BEFORE STARTING SURVEY.
    func showAlert() {
        let alert = UIAlertController(title: "Survey", message: "Do you want to take this Survey?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { action in
            print("GO TO OTHER VIEWCONTROLLER")
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.activityTableView.isHidden = false
            self.dataForActivity[0].startDateTime = self.getDateTime()
            self.reloadTableView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        self.activityTableView.reloadData()
    }
    
    //TODO: TO GET DATE AND TIME
    func getDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "US")
        dateFormatter.locale = Locale(identifier: "en_US")
        return (dateFormatter.string(from: Date()))
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = ((activityTableView.frame.size.height)/8 + 50)
//        return CGFloat(height)
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityTableViewCell
        
        
        
        
        
        
        
        
        
//        if ((indexPath.row == 0) && dataForActivity[indexPath.row].endDateTime == nil) {
//            cell.doneBtn.isHidden = false
//            cell.yetToStartLbl.isHidden = true
//            cell.CheckAndDateStackView.isHidden = true
//
//            cell.callbackForDoneButton = {
//                cell.doneBtn.isHidden = true
//                cell.CheckAndDateStackView.isHidden = false
//                cell.yetToStartLbl.isHidden = true
//                let dateTime = self.getDateTime()
//                cell.dateTimeLbl.text = self.getDateTime()
//                self.dataForActivity[indexPath.row].endDateTime = dateTime
//
//                self.reloadTableView()
//            }
//
//        } else if (dataForActivity[indexPath.row].endDateTime != nil) {
//            cell.doneBtn.isHidden = true
//            cell.yetToStartLbl.isHidden = true
//            cell.CheckAndDateStackView.isHidden = false
//            cell.dateTimeLbl.text = dataForActivity[indexPath.row].endDateTime
//        } else {
//
//            //TODO: "TO SHOW YET TO START IN OTHER CELLS"
//            cell.doneBtn.isHidden = true
//            cell.CheckAndDateStackView.isHidden = true
//            cell.yetToStartLbl.isHidden = false
//            cell.yetToStartLbl.text = dataForActivity[indexPath.row].yetToStart
//        }
        cell.activityNameLbl.text = dataForActivity[indexPath.row].title
        cell.dateTimeLbl.text = dataForActivity[indexPath.row].endDateTime
        
        if (dataForActivity[indexPath.row].startDateTime != nil) {
            
            if (dataForActivity[indexPath.row].endDateTime != nil) {
                cell.doneBtn.isHidden = true
                cell.yetToStartLbl.isHidden = true
                cell.CheckAndDateStackView.isHidden = false
                
                self.activityTableView.reloadData()
            }
            
            else {
                cell.doneBtn.isHidden = false
                cell.yetToStartLbl.isHidden = true
                cell.CheckAndDateStackView.isHidden = true
                
                cell.callbackForDoneButton = {
                    cell.doneBtn.isHidden = true
                    cell.CheckAndDateStackView.isHidden = false
                    cell.yetToStartLbl.isHidden = true
                    let dateTime = self.getDateTime()
                    cell.dateTimeLbl.text = self.getDateTime()
                    self.dataForActivity[indexPath.row].endDateTime = dateTime
                    self.dataForActivity[indexPath.row + 1].startDateTime = dateTime
                    
                    self.activityTableView.reloadData()
                }
            }
            
        } else {
            cell.doneBtn.isHidden = true
            cell.yetToStartLbl.isHidden = false
            cell.CheckAndDateStackView.isHidden = true
        }
        
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

