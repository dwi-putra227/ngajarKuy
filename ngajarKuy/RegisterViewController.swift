//
//  RegisterViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 14/12/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTxtFild: UITextField!
    @IBOutlet weak var emailTxtFild: UITextField!
    @IBOutlet weak var pwTxtFild: UITextField!
    @IBOutlet weak var codeGuruTxtFild: UITextField!
    @IBOutlet weak var regBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        codeGuruTxtFild.isEnabled = false
    }
    
    
    @IBAction func regBtnToLogin(_ sender: Any) {
        guard let name = nameTxtFild.text, !name.isEmpty,
              let email = emailTxtFild.text, isValidEmail(email),
              let password = pwTxtFild.text, !password.isEmpty,
              let code = codeGuruTxtFild.text, !code.isEmpty else {
            showAlert(message: "Semua field harus diisi dengan benar.")
                    return
                }
        saveTeacherToCoreData(name: name, email: email, password: password, code: code)
        showAlert(message: "Registrasi berhasil!")
    }
    
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    
    @IBAction func generateCodeBtn(_ sender: Any) {
        let generatedCode = generateUniqueCode()
        codeGuruTxtFild.text = generatedCode
    }
    
    private func generateUniqueCode() -> String {
            return UUID().uuidString.prefix(8).uppercased() // Code unik 8 karakter
        }
    
    private func saveTeacherToCoreData(name: String, email: String, password: String, code: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext

            // Buat objek Teacher baru
        let guru = Guru(context: context)
            guru.name = name
            guru.email = email
            guru.password = password
        guru.code = code

            // Simpan data ke Core Data
            do {
                try context.save()
                print("Data berhasil disimpan.")
            } catch {
                print("Gagal menyimpan data: \(error)")
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
