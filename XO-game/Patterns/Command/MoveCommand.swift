//
//  MoveCommand.swift
//  XO-game
//
//  Created by Андрей Закусов on 12.03.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol MoveCommand {
    var position: GameboardPosition? { get }
    var player: Player? { get }
    func execute()
}

class MoveAddMark: MoveCommand {
    
    var position: GameboardPosition?
    var player: Player?
    
    init(position: GameboardPosition, player: Player) {
        self.position = position
        self.player = player
    }
    
    func execute() {
        //guard let gameState = gameState, let position = position else {return}
        //gameState.addMark(at: position)
    }
}


