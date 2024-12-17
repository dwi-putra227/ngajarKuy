//
//  ScheduleTableViewCell.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleMapel: UILabel!
    @IBOutlet weak var roomLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with schedule: Schedule) {
        titleMapel.text = schedule.subject
        roomLbl.text = "\(schedule.room)"
        timeLbl.text = "\(schedule.time)"
        }

}
