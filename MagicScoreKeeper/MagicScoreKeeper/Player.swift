//
//  Player.swift
//  MagicScoreKeeper
//
//  Created by Teddy Juntunen on 12/10/17.
//  Copyright © 2017 Teddy Juntunen. All rights reserved.
//

class Player {
    
    private var score: Int
    private var name: String
    
    init() {
        score = 20
        name = "Player"
    }
    
    public func getScore() -> Int {
        return self.score
    }
    
    public func setScore(score: Int) {
        self.score = score
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func setName(newName: String) {
        self.name = newName
    }
    
}
