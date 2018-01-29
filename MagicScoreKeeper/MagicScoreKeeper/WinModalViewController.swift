//
//  WinModalViewController.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/12/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

import UIKit

class WinModalViewController: UIViewController {
    
    @IBOutlet weak var winModal: UIView!
    
    @IBOutlet weak var winningPlayerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setModalDesign()
        setModalResult()
    }
    
    private func setModalDesign() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        winModal.layer.cornerRadius = 5
        winModal.layer.masksToBounds = true
    }
    
    private func setModalResult() {
        winningPlayerLabel.text = "Game Over!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
