//
//  ScheduleViewController.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import UIKit

class ScheduleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var calenderView: UICollectionView!
    @IBOutlet weak var tablePiuw: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var nexBtn: UIButton!
    
    
    var currentMonthDates: [Date?] = []
    var selectedDate: Date?
    var currentMonth: Date = Date()
    
    var schedules: [String: [Schedule]] = [
            "2024-12-16": [
                Schedule(subject: "Mathematics", room: "Room X-A", time: "07:00 - 8:30 GMT+7"),
                Schedule(subject: "IKN History", room: "Room XII-C", time: "08:30 - 10:00 GMT+7"),
                Schedule(subject: "Economics of Executive", room: "Room X-H", time: "10:30 - 12:00 GMT+7")
            ],
            "2024-12-17": [
                Schedule(subject: "World War History", room: "Room XI-B", time: "08:00 - 09:30 GMT+7"),
                Schedule(subject: "Economics of Free Wi-Fi", room: "Room X-C", time: "10:00 - 11:30 GMT+7")
            ]
        ]
        var filteredSchedules: [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Konfigurasi CollectionView dan TableView
                calenderView.delegate = self
                calenderView.dataSource = self
                tablePiuw.delegate = self
                tablePiuw.dataSource = self
                
                // Inisialisasi data kalender
                setupCalendarData()
                
                // Tampilkan jadwal berdasarkan hari ini
                selectedDate = Date()
                filterSchedules(for: selectedDate)
                
                // Atur bulan saat ini
                updateMonthLabel()
        
        if let layout = calenderView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0.5 // Horizontal spacing between items
            layout.minimumLineSpacing = 0.5    // Vertical spacing between rows
                }
    }
    
    func setupCalendarData() {
        currentMonthDates = generateDatesForCurrentMonth(currentMonth)
        }
        
        func generateDatesForCurrentMonth(_ date: Date) -> [Date?] {
            let calendar = Calendar.current
                let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
                let range = calendar.range(of: .day, in: .month, for: date)!
                
                var dates: [Date?] = []
                
                // Hitung hari pertama dalam minggu
                let firstWeekday = calendar.component(.weekday, from: startOfMonth)
                
                // Tambahkan placeholder sebelum tanggal pertama
                for _ in 1..<firstWeekday {
                    dates.append(nil)
                }
                
                // Tambahkan tanggal bulan ini
                for day in range {
                    if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                        dates.append(date)
                    }
                }
                
                // Tambahkan placeholder setelah tanggal terakhir
                while dates.count % 7 != 0 {
                    dates.append(nil)
                }
                
                return dates
        }
    
    func updateMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        monthLbl.text = formatter.string(from: currentMonth)
        }
    
    @IBAction func prevMonthBtn(_ sender: Any) {
        changeMonth(by: -1)
    }
    
    @IBAction func nextMonthBtn(_ sender: Any) {
        changeMonth(by: 1)
    }
    
    func changeMonth(by value: Int) {
            currentMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth)!
            setupCalendarData()
            updateMonthLabel()
            calenderView.reloadData()
        }
    
    
    
    func filterSchedules(for date: Date?) {
        guard let date = date else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateKey = formatter.string(from: date)
                filteredSchedules = schedules[dateKey] ?? []
                tablePiuw.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMonthDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as? CalenderCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                if let date = currentMonthDates[indexPath.row] {
                    let dayText = Calendar.current.component(.day, from: date)
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate ?? Date())
                    
                    cell.configure(day: "\(dayText)", isSelected: isSelected, isPlaceholder: false)
                } else {
                    // Placeholder untuk tanggal kosong
                    cell.configure(day: "", isSelected: false, isPlaceholder: true)
                }
                
                return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 24) / 7 // Divide by 7 days a week
            return CGSize(width: width, height: width)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let date = currentMonthDates[indexPath.row] else { return }
            selectedDate = date
            filterSchedules(for: selectedDate)
            collectionView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
                let schedule = filteredSchedules[indexPath.row]
                cell.configure(with: schedule)
                return cell
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
