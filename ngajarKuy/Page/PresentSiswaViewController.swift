//
//  PresentSiswaViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class PresentSiswaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewSiswa: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var siswaList = [
            ("Ali", "S001"),
            ("Budi", "S002"),
            ("Citra", "S003"),
            ("Dewi", "S004")
        ]
    
    var kehadiranStatus = [String?](repeating: nil, count: 4)
        
        // Pilihan dropdown kehadiran
        let kehadiranOptions = ["Hadir", "Izin", "Alpa", "Sakit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewSiswa.delegate = self
        tableViewSiswa.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siswaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSiswaViewCell", for: indexPath) as! SiswaTableViewCell
                
                // Ambil data siswa
                let siswa = siswaList[indexPath.row]
                let namaSiswa = siswa.0
                let kodeSiswa = siswa.1
                
                // Status kehadiran saat ini
                let status = kehadiranStatus[indexPath.row]
                
                // Konfigurasi cell dengan data siswa
                cell.configure(nama: namaSiswa, kode: kodeSiswa, status: status)
                
                // Tambahkan aksi untuk dropdown button
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped(_:)))
            cell.dropdownKehadiranBtn.addGestureRecognizer(tapGesture)
            cell.dropdownKehadiranBtn.tag = indexPath.row
                
                return cell
    }
    
    @objc func dropdownTapped(_ sender: UITapGestureRecognizer) {
        // Dapatkan baris yang diklik
            guard let button = sender.view as? UIButton else { return }
            let row = button.tag
            
            // Panggil fungsi untuk menampilkan dropdown menu
            showDropdownMenu(for: row)
    }
    
    func showDropdownMenu(for index: Int) {
        let actionSheet = UIAlertController(title: "Pilih Status Kehadiran", message: nil, preferredStyle: .actionSheet)
            
            for status in kehadiranOptions {
                actionSheet.addAction(UIAlertAction(title: status, style: .default, handler: { _ in
                    // Simpan status yang dipilih
                    self.kehadiranStatus[index] = status
                    
                    // Reload cell untuk memperbarui tampilan
                    self.tableViewSiswa.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.none)
                }))
            }
            
            actionSheet.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
            DispatchQueue.main.async {
                self.present(actionSheet, animated: true, completion: nil)
            }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
            // Navigasi kembali ke halaman sebelumnya
            self.dismiss(animated: true, completion: nil)
        }
        
        // MARK: - Save Button Action
        @IBAction func saveButtonTapped(_ sender: UIButton) {
            // Simpan data ke server atau database
            for (index, siswa) in siswaList.enumerated() {
                let status = kehadiranStatus[index] ?? "Belum Dipilih"
                print("Siswa: \(siswa.0), Kode: \(siswa.1), Status: \(status)")
            }
            
            // Tampilkan alert sukses
            let alert = UIAlertController(title: "Berhasil", message: "Data kehadiran telah disimpan.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
