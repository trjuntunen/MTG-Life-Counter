//
//  DiceViewController.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/10/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

import UIKit

class Dice {
    
    func roll() -> Int {
        return Int(arc4random_uniform(20) + 1)
    }

}
