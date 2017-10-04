//
//  ViewController.swift
//  CalendarDemo
//
//  Created by Prashant Prajapati on 29/09/17.
//  Copyright © 2017 Prashant Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrWeekdays = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    var weekStartinMonth = NSString()
    var findday = Int()
    var PrevTotal = Int()
    var TotalDays = Int()
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        
        print(Date())
        getFirstdayofWeek(Date())
        numberofdayinMonth(Date())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFirstdayofWeek(_ date: Date) {
        let today: Date? = date
        let gregorian = Calendar(identifier: .gregorian)
        var components: DateComponents? = gregorian.dateComponents(([.era, .year, .month]), from: today!)
        components?.day = 1
        let firstDayOfMonth: Date? = gregorian.date(from: components!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        //    NSLog(@"Day ----- > %@", [dateFormatter stringFromDate:firstDayOfMonth]);
        weekStartinMonth = dateFormatter.string(from: firstDayOfMonth!) as NSString
        weekStartinMonth = weekStartinMonth.lowercased as NSString
    }
    
    func numberofdayinMonth(_ date: Date) {
        let calendar = Calendar.current
        let date = Date()
        
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date)!
        
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        print(days)
        TotalDays = days
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return arrWeekdays.count
        }else{
            return 45
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        if indexPath.section == 0{
            cell.lblInfo.text = arrWeekdays[indexPath.row]
            if arrWeekdays[indexPath.row].lowercased() == weekStartinMonth as String{
                findday = indexPath.row
            }
        }else{
            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.red
            }else{
                cell.backgroundColor = UIColor.brown
            }
            
            // cell.lblInfo.text = "\(indexPath.row)"
            
            if(((indexPath.row - findday) + 1) <= 0) {
                cell.lblInfo.text = "\(indexPath.row+1)"
            }
            if (indexPath.row >= findday) {
                cell.lblInfo.text = "\(indexPath.row+1)"
            }
        }
        return cell
    }
}
