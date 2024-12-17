//
//  HomeViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 14/12/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    
    let data = [
            (status: "Ongoing", className: "X MIPA 1 - Teach", course: "IKN History", timeLeft: "Now"),
            (status: "Upcoming", className: "X MIPA 2 - Teach", course: "Math Wajib", timeLeft: "20 more minutes"),
            (status: "Completed", className: "XII MIPA 1 - Teach", course: "World War 3", timeLeft: " - ")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let namaGuru = UserDefaults.standard.string(forKey: "namaGuru") {
            welcomeLbl.text = "\(namaGuru)!" // Tampilkan di label
                } else {
                    welcomeLbl.text = "Welcome!"
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CustomCollectionViewCell else {
                    return UICollectionViewCell()
                }

                // Ambil data untuk cell
                let item = data[indexPath.row]
                cell.statusTimeLbl.text = item.status
                cell.classLbl.text = item.className
                cell.courseLbl.text = item.course
                cell.timeLeftLbl.text = item.timeLeft

                return cell
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
