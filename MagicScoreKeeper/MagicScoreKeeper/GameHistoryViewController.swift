//
//  GameHistoryViewController.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 1/25/18.
//  Copyright © 2018 Teddy Juntunen. All rights reserved.
//

import UIKit
import CoreData

class GameHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dateArray: [String] = []
    var scoreArray: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = scoreArray[indexPath.row]
        cell.detailTextLabel?.text = dateArray[indexPath.row]
        return cell
    }
    
    public func fetchCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let player1name = data.value(forKey: "player1name") as! String
                let player2name = data.value(forKey: "player2name") as! String
                let player1score = data.value(forKey: "player1score") as! Int
                let player2score = data.value(forKey: "player2score") as! Int
                let date = data.value(forKey: "date") as! String
                if(String(player1score) == "0") {
                    scoreArray.append(player2name + ": " + String(player2score) + " " + player1name + ": " + String(player1score))
                    dateArray.append(date)
                } else {
                    scoreArray.append(player1name + ": " + String(player1score) + " " + player2name + ": " + String(player2score))
                    dateArray.append(date)
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.scoreArray.remove(at: indexPath.row)
            self.dateArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            deleteAllRecords()
        }
    }
    
    @IBAction func previousScreen(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
