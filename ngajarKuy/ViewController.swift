//
//  ViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 09/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTxtFild: UITextField!
    @IBOutlet weak var pwTxtFild: UITextField!
    @IBOutlet weak var forgetPwTxtFild: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let loggedInEmail = UserDefaults.standard.string(forKey: "loggedInEmail") {
                    print("Pengguna sudah login: \(loggedInEmail)")
                    navigateToHomePage()
                }
    }
    
    
    @IBAction func loginBtnToHome(_ sender: Any) {
        guard let email = emailTxtFild.text, !email.isEmpty,
                      let password = pwTxtFild.text, !password.isEmpty else {
                    showAlert(message: "Email dan Password tidak boleh kosong.")
                    return
                }

                // Validasi data login
        if validateLogin(email: email, password: password) {
            UserDefaults.standard.set(email, forKey: "loggedInEmail")
                    navigateToHomePage() // Pindah ke TabBarController
                } else {
                    showAlert(message: "Email atau Password salah.")
                }
    }
    
    private func validateLogin(email: String, password: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
                let context = appDelegate.persistentContainer.viewContext

                let fetchRequest: NSFetchRequest<Guru> = Guru.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

                do {
                    let teachers = try context.fetch(fetchRequest)
                    if let teacher = teachers.first {
                        // Simpan data ke UserDefaults setelah login berhasil
                        UserDefaults.standard.set(teacher.email, forKey: "loggedInEmail")
                        UserDefaults.standard.set(teacher.name, forKey: "namaGuru")
                        UserDefaults.standard.set(teacher.code, forKey: "codeGuru")
                        UserDefaults.standard.synchronize()
                        return true
                    }
                    return false
                } catch {
                    print("Gagal mengambil data: \(error)")
                    return false
                }
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    private func navigateToHomePage() {
            // Lakukan navigasi ke halaman berikutnya setelah login berhasil
            // Contoh: gunakan segue atau pindah ke ViewController tertentu
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                    tabBarVC.selectedIndex = 0 // Pilih tab pertama, misalnya Home
                    tabBarVC.modalPresentationStyle = .fullScreen // Pastikan tampil layar penuh
                    present(tabBarVC, animated: true, completion: nil)
                } else {
                    print("Gagal menemukan TabBarController di Storyboard.")
                }
    
        }
    
    
    @IBAction func regBtnToReg(_ sender: Any) {
        
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    

}

