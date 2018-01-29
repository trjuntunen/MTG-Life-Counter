//
//  ScoreKeeping.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/10/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

import UIKit

class ScoreKeeping {
    
    public func increaseScore(player: Player, amount: Int) {
        let currentScore = player.getScore()
        player.setScore(score: currentScore + amount)
    }
    
    public func decreaseScore(player: Player, amount: Int) {
        let currentScore = player.getScore()
        player.setScore(score: currentScore - amount)
    }
    
    public func playerHasLost(player: Player) -> Bool {
        if(player.getScore() >= 0) {
            return true
        }
        return false
    }

}
