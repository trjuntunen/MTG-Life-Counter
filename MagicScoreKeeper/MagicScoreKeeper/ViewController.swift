//
//  ViewController.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/9/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let diceVC = Dice()
    let diceInterface = DiceModalInterface()
    
    let player1 = Player()
    let player2 = Player()
    
    public func getPlayer1() -> Player {
        return self.player1
    }
    
    public func getPlayer2() -> Player {
        return self.player2
    }
    
    let scoreKeeping = ScoreKeeping()

    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    
    @IBOutlet weak var player1name: UILabel!
    @IBOutlet weak var player2name: UILabel!
    
    @IBOutlet weak var topDraggableCounter: UILabel!
    @IBOutlet weak var middleDraggableCounter: UILabel!
    @IBOutlet weak var bottomDraggableCounter: UILabel!

    @IBOutlet weak var dice: UIButton!
    @IBOutlet weak var settings: UIButton!
    
    @IBOutlet weak var player1topZone: UIView!
    @IBOutlet weak var player1bottomZone: UIView!
    @IBOutlet weak var player2topZone: UIView!
    @IBOutlet weak var player2bottomZone: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPlayerScores()
        
        roundDraggableCounters(label: topDraggableCounter)
        roundDraggableCounters(label: middleDraggableCounter)
        roundDraggableCounters(label: bottomDraggableCounter)
        
        let topLabelGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.topCounterDragged(_:)))
        let middleLabelGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.middleCounterDragged(_:)))
        let bottomLabelGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.bottomCounterDragged(_:)))
        
        let player1NameChangeGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.player1nameTapped(_:)))
        let player2NameChangeGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.player2nameTapped(_:)))
        
        player1name.addGestureRecognizer(player1NameChangeGesture)
        player1name.isUserInteractionEnabled = true
        player1name.text = "Player"
        player2name.text = "Player"
        player2name.addGestureRecognizer(player2NameChangeGesture)
        player2name.isUserInteractionEnabled = true
        
        topDraggableCounter.addGestureRecognizer(topLabelGesture)
        topDraggableCounter.isUserInteractionEnabled = true
        
        middleDraggableCounter.addGestureRecognizer(middleLabelGesture)
        middleDraggableCounter.isUserInteractionEnabled = true
        
        bottomDraggableCounter.addGestureRecognizer(bottomLabelGesture)
        bottomDraggableCounter.isUserInteractionEnabled = true
        
        let player1ScoreGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.player1scoreTapped(_:)))
        
        let player2ScoreGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.player2scoreTapped(_:)))
        player1score.addGestureRecognizer(player1ScoreGesture)
        player2score.addGestureRecognizer(player2ScoreGesture)
        player1score.isUserInteractionEnabled = true
        player2score.isUserInteractionEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func roundDraggableCounters(label: UILabel) {
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
    }
    
    func showView() {
        performSegue(withIdentifier: "winSegue", sender: self)
    }
    
    private func showAlertForPlayer1NameChange() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            textField.autocapitalizationType = UITextAutocapitalizationType.words
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if((textField?.text != nil) && (textField?.text) != "") {
                self.player1.setName(newName: (textField?.text)!)
                self.player1name.text = self.player1.getName()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertForPlayer2NameChange() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if((textField?.text != nil) && (textField?.text) != "") {
                textField?.autocapitalizationType = UITextAutocapitalizationType.words
                self.player2.setName(newName: (textField?.text)!)
                self.player2name.text = self.player2.getName()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func player1nameTapped(_ gesture: UITapGestureRecognizer) {
        showAlertForPlayer1NameChange()
    }
    
    @objc private func player1scoreTapped(_ gesture: UITapGestureRecognizer) {
        player1.setScore(score: (player1.getScore() - 1))
        player1score.text = String(player1.getScore())
        if(player1.getScore() <= 0) {
            player1.setScore(score: 0)
            player1score.text = "0"
            showView()
        }
    }
    
    @objc private func player2scoreTapped(_ gesture: UITapGestureRecognizer) {
        player2.setScore(score: (player2.getScore() - 1))
        player2score.text = String(player2.getScore())
        if(player2.getScore() <= 0) {
            player2.setScore(score: 0)
            player2score.text = "0"
            showView()
        }
    }
    
    
    
    @objc private func player2nameTapped(_ gesture: UITapGestureRecognizer) {
        showAlertForPlayer2NameChange()
    }
    
    @objc private func topCounterDragged(_ gesture: UIPanGestureRecognizer) {
        draggableCounters(gesture: gesture, draggableCounter: topDraggableCounter, offsetAmount: 100)
    }
    
    @objc private func middleCounterDragged(_ gesture: UIPanGestureRecognizer) {
        draggableCounters(gesture: gesture, draggableCounter: middleDraggableCounter, offsetAmount: 0)
    }
    
    @objc private func bottomCounterDragged(_ gesture: UIPanGestureRecognizer) {
        draggableCounters(gesture: gesture, draggableCounter: bottomDraggableCounter, offsetAmount: -100)
    }
    
    private func draggableCounters(gesture: UIPanGestureRecognizer, draggableCounter: UILabel, offsetAmount: CGFloat) {
        let originalCenter = CGPoint(x: ((self.view.bounds.width / 2)), y: (self.view.bounds.height / 2 - offsetAmount))
        let translation = gesture.translation(in: self.view)
        let label = gesture.view!
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if draggableCounter.frame.intersects(player1topZone.frame) {
                let amount: Int = Int(draggableCounter.text!)!
                scoreKeeping.increaseScore(player: player1, amount: amount)
                player1score.text = String(player1.getScore())
            }
            if draggableCounter.frame.intersects(player1bottomZone.frame) {
                let amount: Int = Int(draggableCounter.text!)!
                scoreKeeping.decreaseScore(player: player1, amount: amount)
                player1score.text = String(player1.getScore())
                if(player1.getScore() <= 0) {
                    player1score.text = "0"
                    player1.setScore(score: 0)
                    saveCoreData()
                    showView()
                } else {
                    player1score.text = String(player1.getScore())
                }
            }
            if draggableCounter.frame.intersects(player2topZone.frame) {
                let amount: Int = Int(draggableCounter.text!)!
                scoreKeeping.increaseScore(player: player2, amount: amount)
                player2score.text = String(player2.getScore())
            }
            if draggableCounter.frame.intersects(player2bottomZone.frame) {
                let amount: Int = Int(draggableCounter.text!)!
                scoreKeeping.decreaseScore(player: player2, amount: amount)
                player2score.text = String(player2.getScore())
                if(player2.getScore() <= 0) {
                    player2score.text = "0"
                    player2.setScore(score: 0)
                    saveCoreData()
                    showView()
                } else {
                    player2score.text = String(player2.getScore())
                }
            }
            label.center = originalCenter
        }
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        // show drop down menu. for now just restart game
        resetPlayerScores()
    }
    func resetPlayerScores() {
        player1.setScore(score: 20)
        player2.setScore(score: 20)
        player1score.text = "20"
        player2score.text = "20"
    }
    
    public func saveCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Score", in: context)
        let newScore = NSManagedObject(entity: entity!, insertInto: context)
        newScore.setValue(player1name.text, forKey: "player1name")
        newScore.setValue(player2name.text, forKey: "player2name")
        newScore.setValue(player1.getScore(), forKey: "player1score")
        newScore.setValue(player2.getScore(), forKey: "player2score")
        newScore.setValue(getTimestamp(), forKey: "date")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getTimestamp() -> String {
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        return timestamp
    }
    
}
