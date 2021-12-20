//
//  ViewController.swift
//  TimeVisualizer(Charts)
//
//  Created by admin on 14/05/1443 AH.
//

import UIKit
import CoreData

class DailyToDoItems: UITableViewController, TableViewDelegate {
    
    var itemsList = [DailyItem]()
    var timeInterval: [String] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            getItems()
            makeTimeInterval(startTime:"4:00 AM" ,endTime:"8:00 PM")
        
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.view.addGestureRecognizer(swipeDown)
        
           tableView.rowHeight = 100
}
    
@objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

    if let swipeGesture = gesture as? UISwipeGestureRecognizer {

        switch swipeGesture.direction {
            
        case .right:
           
            let weeklyVC = self.storyboard!.instantiateViewController(withIdentifier: "WeeklyToDoItems")
            self.navigationController?.pushViewController(weeklyVC, animated: true)
            
        case .down:
            print("Swiped down")
        case .left:
            
            let keywordVC = self.storyboard!.instantiateViewController(withIdentifier: "KeywordsViewController")
            self.navigationController?.pushViewController(keywordVC, animated: true)
            
        case .up:
            print("Swiped up")
        default:
            break
        }
    }
}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCustomCell

       
       let item = itemsList[indexPath.row]
        
        cell.itemTextField.text = item.task
        cell.timeLabel.text = item.time
        return cell
    }
    
    @IBAction func addKeyword(_ sender: UIBarButtonItem) {
        showAlert()
    }
    func itemSaved(with task: String){
           
           let item = NSEntityDescription.insertNewObject(forEntityName: "DailyItem", into: getContext()) as! DailyItem
          
           item.task = task
           
           itemsList.append(item)
           print(item)
           
           saveItem()
           
           tableView.reloadData()
          
       }
    
    func showAlert() {
        let alert = UIAlertController.init(title: "Start New Weeks?", message: "Choose to start a new week and remove data feom\n the previous one", preferredStyle: .actionSheet)
        
        let addKeywordAction = UIAlertAction.init(title: "Add Keywords", style: .default) { action in
            print("addKeywordAction is clicked")
        }
        alert.addAction(addKeywordAction)
        
        let goBackAction = UIAlertAction.init(title: "Go Back", style: .default) { action in
            print("goBackAction is clicked")
        }
        alert.addAction(goBackAction)
        
        let addNewWeekAction = UIAlertAction.init(title: "Add New Week", style: .destructive) { action in
            print("addNewWeekAction is clicked")
        }
        alert.addAction(addNewWeekAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func makeTimeInterval(startTime:String ,endTime:String){
        
        var arr = startTime.components(separatedBy: " ")[0].components(separatedBy: ":")
        let str = arr[1] as String
        if (Int(str)! > 0 && Int(str)! < 30){
            arr[1] = "00"
        }
        else if(Int(str)! > 30){
            arr[1] = "30"
        }
        let startT:String = "\(arr.joined(separator: ":"))  \(startTime.components(separatedBy: " ")[1])"

        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "hh:mm a"
        var fromTime:NSDate  = (timeFormat.date(from:startT) as NSDate?)!
        let toTime:NSDate  = (timeFormat.date(from:endTime) as NSDate?)!

        var dateByAddingThirtyMinute : NSDate!
        let timeinterval : TimeInterval = toTime.timeIntervalSince(fromTime as Date)
        let numberOfIntervals : Double = timeinterval / 3600;
        var formattedDateString : String!


        for _ in stride(from: 0, to: Int(numberOfIntervals * 2), by: 1)
        {
            dateByAddingThirtyMinute = fromTime.addingTimeInterval(1800)
            fromTime = dateByAddingThirtyMinute
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            formattedDateString = dateFormatter.string(from: dateByAddingThirtyMinute! as Date) as String?
            print("Time after 30 min = \(String(describing: formattedDateString))")
            
            let item = NSEntityDescription.insertNewObject(forEntityName: "DailyItem", into: getContext()) as! DailyItem
           
            item.time = formattedDateString
            
            itemsList.append(item)
            print(item)
            
            saveItem()

        }
    }
    func getContext() -> NSManagedObjectContext {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           return appDelegate.persistentContainer.viewContext
       }
       
       func getItems() {
           let context = getContext()
           
           let request = NSFetchRequest<DailyItem>.init(entityName: "DailyItem")
           
           do {
               itemsList = try context.fetch(request)
               tableView.reloadData()
           } catch {
               print(error.localizedDescription)
           }
       }
       func saveItem() {
           
           let context = getContext()
           do {
               try context.save()
           } catch {
               print(error.localizedDescription)
           }
       }
}

