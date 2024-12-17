//
//  MaterialViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class MaterialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControle: UISegmentedControl!
    @IBOutlet weak var materialTableView: UITableView!
    
    let segment1Data = [
            ("Mathematics Optional", "Classes: X MIPA 1, X IPS 1"),
            ("IKN History", "Classes: X MIPA 1, X IPS 2"),
            ("Real Mathematics", "Classes: X MIPA 1, X MIPA 2"),
            ("Economy of Executive", "Classes: X MIPA 1, X MIPA 2, X IPS 1")
        ]
        let segment2Data = [
            ("Philosophy of Noodles", "Classes: X MIPA 2, X IPS 1"),
            ("Economics of Free Wi-Fi", "Classes: X IPS 1, X MIPA 1, X IPS 2"),
            ("Advanced Sleepology: How to Nap Efficiently", "Classes: X MIPA 1, X MIPA 2")
        ]
        let segment3Data = [
            ("The Art of Overthinking Exam Questions", "Classes: X IPS 2, X IPS 1"),
            ("Philosophy of Missing Pens", "Classes: X MIPA 1, X MIPA 2"),
            ("Cryptography of Teacher's Handwriting", "Classes: X IPS 1, X MIPA 2")
        ]

        var currentData: [(title: String, subtitle: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set delegate dan data source untuk TableView
        materialTableView.delegate = self
        materialTableView.dataSource = self

                // Set data awal untuk segmen pertama
                currentData = segment1Data

                // Tambahkan aksi pada UISegmentedControl
        segmentedControle.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
            // Ganti data berdasarkan segmen yang dipilih
            switch sender.selectedSegmentIndex {
            case 0:
                currentData = segment1Data
            case 1:
                currentData = segment2Data
            case 2:
                currentData = segment3Data
            default:
                currentData = []
            }
            // Refresh TableView
        materialTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTableViewCell", for: indexPath) as? MaterialTableViewCell else {
                    return UITableViewCell()
                }
                
                let data = currentData[indexPath.row]
        cell.configure(mapel: data.title, kelas: data.subtitle)

                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedData = currentData[indexPath.row]
            print("Selected: \(selectedData.title) - \(selectedData.subtitle)")
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
