//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    lazy var referee = Referee(gameboard: self.gameboard)
    private var moveInvoker: MoveInvoker?
    
    let gameboard = Gameboard()
    var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            switch Game.shared.gameMode {
            case .oneOnOne, .vsComp:
                
                if let winner = self.referee.determineWinner() {
                    self.currentState = GameEndedState(winner: winner, gameViewController: self)
                    return
                }
                self.currentState.addMark(at: position)
                if self.currentState.isCompleted {
                    self.goToNextState()
                }
                
            case .blindMovies:
                self.currentState.addMark(at: position)
                if self.currentState.isCompleted {
                    if  self.currentState.player == .first{
                        self.goToNextState()
                        self.gameboardView.clear()
                        self.gameboard.clear()
                    } else{
                        if let moveInvoker = self.moveInvoker {
                            self.gameboardView.clear()
                            self.gameboard.clear()
                            moveInvoker.work()
                        }
                    }
                }
            }
            
        }
    }
    
    private func goToFirstState() {
        switch Game.shared.gameMode {
        case .oneOnOne, .vsComp:
            let player = Player.first
            self.currentState = PlayerInputState(player: player,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView,
                                                 markViewPrototype: player.markViewPrototype)
            
        case .blindMovies:
            moveInvoker = MoveInvoker()
            moveInvoker?.gameViewController = self
            let player = Player.first
            self.currentState = BlindeMoviesPlayerInputState(player: player,
                                                             gameViewController: self,
                                                             gameboard: gameboard,
                                                             gameboardView: gameboardView,
                                                             markViewPrototype: player.markViewPrototype,
                                                             moveInvoker: moveInvoker!)
        }
        
        
    }
    
    private func goToNextState() {
        
        
        switch Game.shared.gameMode {
        case .oneOnOne:
            let player = currentState.player.next
            self.currentState = PlayerInputState(player: player,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView,
                                                 markViewPrototype: player.markViewPrototype)
        case .vsComp:
            let player = currentState.player.next
            if player == .first {
                self.currentState = PlayerInputState(player: player,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView,
                                                     markViewPrototype: player.markViewPrototype)}
            else {
                self.currentState = CompInputState(player: player,
                                                   gameViewController: self,
                                                   gameboard: gameboard,
                                                   gameboardView: gameboardView,
                                                   markViewPrototype: player.markViewPrototype)
                gameboardView.onSelectPosition!(GameboardPosition(column: 1, row: 1))
            }
        case .blindMovies:
            let player = currentState.player.next
            self.currentState = BlindeMoviesPlayerInputState(player: player,
                                                             gameViewController: self,
                                                             gameboard: gameboard,
                                                             gameboardView: gameboardView,
                                                             markViewPrototype: player.markViewPrototype,
                                                             moveInvoker: moveInvoker!)
        }
        
        
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboardView.clear()
        self.gameboard.clear()
        self.goToFirstState()
        
        LogAction.log(.restartGame)
    }
    
    @IBAction func BackButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "GameMainMenuSegue", sender: self)
        
    }
}

