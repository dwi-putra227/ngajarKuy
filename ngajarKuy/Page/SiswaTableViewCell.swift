//
//  SiswaTableViewCell.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class SiswaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var namaSiswaLbl: UILabel!
    @IBOutlet weak var kodeLbl: UILabel!
    @IBOutlet weak var dropdownKehadiranBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                dropdownKehadiranBtn.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
            // Aksi yang diinginkan ketika tombol diklik
            print("Dropdown button tapped")
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(nama: String, kode: String, status: String?) {
        namaSiswaLbl.text = nama
        kodeLbl.text = kode
            
            // Set judul dropdown sesuai status jika ada
        dropdownKehadiranBtn.setTitle(status ?? "Pilih Kehadiran", for: .normal)
        }

}
