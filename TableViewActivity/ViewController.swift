//
//  ViewController.swift
//  TableViewActivity
//
//  Created by admin on 16/08/22.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var undoBtn: UIButton!
    
    var dataForActivity = [ActivityModel]()
    
    var timer: Timer = Timer()
    var count: Int = 0
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity1 = ActivityModel(id: 0, title: "Activity One", status: ActivityStatus.readyToStart)
        dataForActivity.append(activity1)
        let activity2 = ActivityModel(id: 1, title: "Activity Two", status: ActivityStatus.yetToReady)
        dataForActivity.append(activity2)
        let activity3 = ActivityModel(id: 2, title: "Activity Three", status: ActivityStatus.yetToReady)
        dataForActivity.append(activity3)
        let activity4 = ActivityModel(id: 3, title: "Activity Four", status: ActivityStatus.yetToReady)
        dataForActivity.append(activity4)
        let activity5 = ActivityModel(id: 4, title: "Activity Five", status: ActivityStatus.yetToReady)
        dataForActivity.append(activity5)
        
        activityTableView.isHidden = true
        undoBtn.isHidden = true
        
        
//        let dates = Date()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            print("Async after 5 seconds \n")
//            let time = dates.timeIntervalSinceNow
//            print(time)
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            self.undoBtn.isHidden = false
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
    
    @IBAction func undoButtonAction(_ sender: Any) {
        
        if let itemPosition = dataForActivity.firstIndex(where: { $0.status == .readyToStart || $0.status == .ongoing }) {
            if (dataForActivity[itemPosition].status == .ongoing) {
                timer.invalidate()
                dataForActivity[itemPosition].startDateTime = nil
                dataForActivity[itemPosition].status = .readyToStart
                dataForActivity[itemPosition].duration = 0
            }
            
            else if (dataForActivity[itemPosition].status == .readyToStart && itemPosition != 0) {
                dataForActivity[itemPosition].status = .yetToReady
                dataForActivity[itemPosition - 1].status = .ongoing
                dataForActivity[itemPosition - 1].endDateTime = nil
            }

            self.activityTableView.reloadData()
        }
   
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
        
        switch(dataForActivity[indexPath.row].status) {
            
        case ActivityStatus.yetToReady :
//            cell.backgroundColor = UIColor.red
            cell.activityNameLbl.text = dataForActivity[indexPath.row].title
            
            cell.contentView.alpha = 0.5
            cell.selectionStyle = .none
            cell.timerStartButtonStack.isHidden = false
            cell.completedDateTimeStack.isHidden = true
            cell.startStopButton.isEnabled = false
            cell.timerLbl.text = "00 : 00 : 00"
            cell.startStopButton.setTitle("START", for: .normal)
   
            break
            
            
        case ActivityStatus.readyToStart :
//            cell.backgroundColor = UIColor.orange
            cell.activityNameLbl.text = dataForActivity[indexPath.row].title
            
            cell.contentView.alpha = 1
            cell.selectionStyle = .default
            cell.timerStartButtonStack.isHidden = false
            cell.completedDateTimeStack.isHidden = true
            cell.startStopButton.isEnabled = true
            cell.timerLbl.text = "00 : 00 : 00"
            cell.startStopButton.setTitle("START", for: .normal)
            
            break
            
            
        case ActivityStatus.ongoing :
//            cell.backgroundColor = UIColor.green
            cell.activityNameLbl.text = dataForActivity[indexPath.row].title
            
            cell.contentView.alpha = 1
            cell.selectionStyle = .default
            cell.timerStartButtonStack.isHidden = false
            cell.completedDateTimeStack.isHidden = true
            cell.startStopButton.isEnabled = true
            cell.config()
            cell.startStopButton.setTitle("STOP", for: .normal)
//            cell.timerLbl.text = dataForActivity[indexPath.row].duration
            
            //TODO: TIMER FUNCTION HERE
            if let count = self.dataForActivity[indexPath.row].duration {
                self.count = count
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                cell.timerLbl.text = self.timerCounter()
            })
            
            break
            
            
        case ActivityStatus.completed :
//            cell.backgroundColor = UIColor.gray
            cell.activityNameLbl.text = dataForActivity[indexPath.row].title
            
            cell.contentView.alpha = 1
            cell.selectionStyle = .none
            cell.timerStartButtonStack.isHidden = true
            cell.completedDateTimeStack.isHidden = false
            cell.dateTimeLbl.text = dataForActivity[indexPath.row].endDateTime
            
            break
            
            
        default :
            break
            
        }
        
        cell.callbackForStartStopButton = {
            if (self.dataForActivity[indexPath.row].status == .readyToStart) {
                self.dataForActivity[indexPath.row].status = .ongoing
                self.dataForActivity[indexPath.row].startDateTime = self.getDateTime()
                
            }
            
            else if (self.dataForActivity[indexPath.row].status == .ongoing) {
                self.dataForActivity[indexPath.row].status = .completed
                self.dataForActivity[indexPath.row].endDateTime = self.getDateTime()
                self.dataForActivity[indexPath.row].duration = self.count
                
                if (indexPath.row < self.dataForActivity.count - 1) {
                    self.dataForActivity[indexPath.row + 1].status = .readyToStart
                    
                }
                self.timer.invalidate()
                self.count = 0
                
                
            }
            
            self.activityTableView.reloadData()
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
