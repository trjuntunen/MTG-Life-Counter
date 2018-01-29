//
//  Interface.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/10/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

import UIKit

class DiceModalInterface: UIViewController {
    
    let diceVC = Dice()
    
   
    @IBOutlet weak var diceModal: UIView!
    
    @IBOutlet weak var diceRollResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setModalResult()
        setModalDesign()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setModalResult() {
        // try to get this to happen immediately and then have modal go up after screen is dark
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        diceRollResult.text = String(diceVC.roll())
    }
    
    private func setModalDesign() {
        diceModal.layer.cornerRadius = 20
        diceModal.layer.masksToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

