//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Elena Gracheva on 09/11/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class PlayerInputState: GameState {
    
    public private(set) var isCompleted = false
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    public let markViewPrototype: MarkView
    
    init(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
        public func begin() {
            switch self.player {
            case .first:
                self.gameViewController?.firstPlayerTurnLabel.isHidden = false
                self.gameViewController?.secondPlayerTurnLabel.isHidden = true
            case .second:
                self.gameViewController?.firstPlayerTurnLabel.isHidden = true
                self.gameViewController?.secondPlayerTurnLabel.isHidden = false
            }
            self.gameViewController?.winnerLabel.isHidden = true
        }
        
        public func addMark(at position: GameboardPosition) {
            guard let gameboardView = self.gameboardView
                , gameboardView.canPlaceMarkView(at: position)
                else { return }
            
            let markView = self.player.markViewPrototype.makeCopy()
            
            self.gameboard?.setPlayer(self.player, at: position)
            self.gameboardView?.placeMarkView(markView, at: position)
            self.isCompleted = true

            LogAction.log(.playerInput(player: self.player, position: position))
        }
    
}
