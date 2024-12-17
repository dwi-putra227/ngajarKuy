//
//  ProfileGuruViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 14/12/24.
//

import UIKit

class ProfileGuruViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var namaGuru: UILabel!
    @IBOutlet weak var codeGuru: UILabel!
    
    let menuItems = [
            ("Personal Information", "person.circle"),
            ("Help Center", "questionmark.circle"),
            ("Settings", "gear"),
            ("Resign", nil)
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nama = UserDefaults.standard.string(forKey: "namaGuru") ?? "Nama Tidak Ditemukan"
            let kode = UserDefaults.standard.string(forKey: "codeGuru") ?? "Kode Tidak Ditemukan"

            // Tampilkan di label
            namaGuru.text = nama
            codeGuru.text = kode

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
                
                // Atur isi cell
                let menuItem = menuItems[indexPath.row]
        cell.titleLbl.text = menuItem.0
                
                if let iconName = menuItem.1 {
                    // Jika cell memiliki ikon
                    cell.iconImageView.image = UIImage(systemName: iconName)
                    cell.iconImageView.isHidden = false
                    cell.titleLbl.textColor = .label
                    cell.titleLbl.textAlignment = .left
                } else {
                    // Jika cell tidak memiliki ikon (Logout)
                    cell.iconImageView.isHidden = true
                    cell.titleLbl.textColor = .red
                    cell.titleLbl.textAlignment = .center
                }

                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                navigateToPersonalInformation()
            case 1:
                navigateToHelpCenter()
            case 2:
                navigateToSettings()
            case 3:
                showLogoutConfirmation()
            default:
                break
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    private func navigateToPersonalInformation() {
            // Navigasi ke halaman Personal Information
            print("Navigasi ke halaman Personal Information")
        }
        
        private func navigateToHelpCenter() {
            // Navigasi ke halaman Help Center
            print("Navigasi ke halaman Help Center")
        }
        
        private func navigateToSettings() {
            // Navigasi ke halaman Settings
            print("Navigasi ke halaman Settings")
        }
    
    private func showLogoutConfirmation() {
            let alert = UIAlertController(title: "Logout", message: "Apakah Anda yakin ingin logout?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
                self.logoutUser()
            }))
            present(alert, animated: true, completion: nil)
        }
        
        private func logoutUser() {
            // Hapus status login dari UserDefaults
            UserDefaults.standard.removeObject(forKey: "loggedInEmail")
            
            // Navigasi kembali ke halaman login
            if let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? ViewController {
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true, completion: nil)
            }
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
