//
//  ActivityTableViewCell.swift
//  TableViewActivity
//
//  Created by admin on 16/08/22.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityNameLbl: UILabel!
    @IBOutlet weak var timerStartButtonStack: UIStackView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var completedDateTimeStack: UIStackView!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    var callbackForStartStopButton: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        config()
        
    }
    

    @IBAction func startStopButtonAction(_ sender: Any) {
        self.callbackForStartStopButton?()
        
    }
    
    func config() {
        startStopButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startStopButton.titleLabel?.minimumScaleFactor = 0.2
        startStopButton.titleLabel?.numberOfLines = 1
        startStopButton.layer.cornerRadius = 5
        startStopButton.titleEdgeInsets.left = 4
        startStopButton.titleEdgeInsets.right = 4
        
    }
}
