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
    
    var timer: Timer = Timer()
    var count: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity1 = ActivityModel(id: 0, title: "Activity One", startDateTime: nil, endDateTime: nil, readyToStartNext: false)
        dataForActivity.append(activity1)
        let activity2 = ActivityModel(id: 1, title: "Activity Two", startDateTime: nil, endDateTime: nil, readyToStartNext: false)
        dataForActivity.append(activity2)
        let activity3 = ActivityModel(id: 2, title: "Activity Three", startDateTime: nil, endDateTime: nil, readyToStartNext: false)
        dataForActivity.append(activity3)
        let activity4 = ActivityModel(id: 3, title: "Activity Four", startDateTime: nil, endDateTime: nil, readyToStartNext: false)
        dataForActivity.append(activity4)
        let activity5 = ActivityModel(id: 4, title: "Activity Five", startDateTime: nil, endDateTime: nil, readyToStartNext: false)
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
//            self.dataForActivity[0].readyToStartNext = true
            self.activityTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
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
        let height = ((activityTableView.frame.size.height)/8 + 50)
        return CGFloat(height)
        //        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityTableViewCell
        
        cell.activityNameLbl.text = dataForActivity[indexPath.row].title
        cell.startStopButton.setTitle("START", for: .normal)
        cell.timerStartButtonStack.isHidden = false
        cell.completedDateTimeStack.isHidden = true
        
        if (indexPath.row == 0) {
            if (dataForActivity[indexPath.row].readyToStartNext != true) {
                cell.contentView.alpha = 1
                cell.selectionStyle = .default
                cell.startStopButton.isEnabled = true
                
            } else {
                cell.contentView.alpha = 1
                cell.selectionStyle = .default
                cell.timerStartButtonStack.isHidden = true
                
                cell.dateTimeLbl.text = self.dataForActivity[indexPath.row].endDateTime
                
                cell.completedDateTimeStack.isHidden = false
            }
            
        }
        
        else if (indexPath.row != 0 && dataForActivity[indexPath.row].readyToStartNext == true) {
            if (dataForActivity[indexPath.row].endDateTime == nil) {
                cell.startStopButton.isHidden = false
                cell.startStopButton.isEnabled = true
                cell.contentView.alpha = 1
                cell.selectionStyle = .default
            } else {
                cell.contentView.alpha = 1
                cell.selectionStyle = .default
                
                cell.timerStartButtonStack.isHidden = true
                
                cell.dateTimeLbl.text = self.dataForActivity[indexPath.row].endDateTime
                
                cell.completedDateTimeStack.isHidden = false
                
            }
            
        }
        
        else {
            cell.contentView.alpha = 0.5
            cell.selectionStyle = .none
            cell.startStopButton.isEnabled = false
            cell.startStopButton.isHidden = false
            cell.timerLbl.text = "00 : 00 : 00"
        }
        
        cell.callbackForStartStopButton = {
            if cell.startStopButton.titleLabel?.text == "START" {
                self.dataForActivity[indexPath.row].readyToStartNext = true
                self.dataForActivity[indexPath.row].startDateTime = self.getDateTime()
                cell.startStopButton.setTitle("STOP", for: .normal)
                
                //TODO: TIMER FUNCTION HERE
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    cell.timerLbl.text = self.timerCounter()
                })
                
                
                
            } else {
                
                if (indexPath.row < (self.dataForActivity.count - 1)) {
                    self.dataForActivity[indexPath.row + 1].readyToStartNext = true
                }
                
                //TODO: TIMER FUNCTION HERE
                self.timer.invalidate()
                self.count = 0
                
                self.dataForActivity[indexPath.row].endDateTime = self.getDateTime()
                self.activityTableView.reloadData()
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //TODO: TIMER FUNCTION
    func timerCounter() -> String {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        return timeString
    }
    
    func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString (hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    
}

