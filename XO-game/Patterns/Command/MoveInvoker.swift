//
//  MoveInvoker.swift
//  XO-game
//
//  Created by Андрей Закусов on 12.03.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class MoveInvoker {
    
    var commands: [MoveCommand] = []
    var gameViewController:GameViewController?
    
    func addCommand(position: GameboardPosition, player: Player) {
        commands.append(MoveAddMark(position: position, player: player))
    }
    
    func work() {
        guard let gameViewController = gameViewController else { return }
        
        let moveInvokerQueue = DispatchQueue(label: "moveInvokerQueue")
        
        for i in [0,5,1,6,2,7,3,8,4,9] {
            let command = commands[i]
            moveInvokerQueue.async {
                DispatchQueue.main.async {
                    
                    if let _ = gameViewController.currentState as? GameEndedState { return }
                        
                    gameViewController.currentState = BlindeMoviesMoveState(player: command.player!,
                                                                            gameViewController: gameViewController,
                                                                            gameboard: gameViewController.gameboard,
                                                                            gameboardView: gameViewController.gameboardView,
                                                                            markViewPrototype: command.player!.markViewPrototype)
                    
                    gameViewController.currentState.addMark(at: command.position!)
                    
                    if let winner = gameViewController.referee.determineWinner() {
                        gameViewController.currentState = GameEndedState(winner: winner, gameViewController: gameViewController)
                    }
                }
                sleep(1)
                
            }
            
        }
        
    }
}

