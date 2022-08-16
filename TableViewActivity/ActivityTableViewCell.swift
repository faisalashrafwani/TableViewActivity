//
//  ActivityTableViewCell.swift
//  TableViewActivity
//
//  Created by admin on 16/08/22.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityNameLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var yetToStartLbl: UILabel!
    @IBOutlet weak var CheckAndDateStackView: UIStackView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    var callbackForDoneButton: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    @IBAction func doneBtnAction(_ sender: Any) {
        self.callbackForDoneButton?()
    }
}
