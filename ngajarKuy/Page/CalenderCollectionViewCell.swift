//
//  CalenderCollectionViewCell.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class CalenderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Styling background bulat
        //            backgroundViewForDate.layer.cornerRadius = self.bounds.width / 2
        //            backgroundViewForDate.backgroundColor = .clear
        
        // Styling default untuk
        dateLbl.textAlignment = .center
        dateLbl.font = UIFont.systemFont(ofSize: 14)
        
        
    }
    
    func configure(day: String, isSelected: Bool, isPlaceholder: Bool) {
            dateLbl.text = day
            if isPlaceholder {
                dateLbl.textColor = .clear // Atau gunakan warna abu-abu
                backgroundColor = .clear
            } else {
                dateLbl.textColor = isSelected ? .white : .black
                backgroundColor = isSelected ? .blue : .clear
            }
        layer.cornerRadius = frame.width / 1.5 // Membuat label tanggal bulat jika dipilih
        }
    
}
