//
//  Game.swift
//  XO-game
//
//  Created by Андрей Закусов on 12.03.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

enum GameMode {
    case oneOnOne
    case vsComp
    case blindMovies
}

class Game {
    
    static let shared = Game()
    
    var gameMode: GameMode = .oneOnOne
    
    private init(){}
    
    
}
