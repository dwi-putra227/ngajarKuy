//
//  MaterialTableViewCell.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class MaterialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapelLbl: UILabel!
    @IBOutlet weak var kelasLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(mapel: String, kelas: String) {
        mapelLbl.text = mapel
        kelasLbl.text = kelas
        }

}
