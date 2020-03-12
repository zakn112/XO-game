//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Андрей Закусов on 12.03.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OneOnOneButtonPress(_ sender: Any) {
        Game.shared.gameMode = .oneOnOne
        performSegue(withIdentifier: "mainMenuGameSegue", sender: self)
    }
    
    @IBAction func VsCompButtonPress(_ sender: Any) {
        Game.shared.gameMode = .vsComp
        performSegue(withIdentifier: "mainMenuGameSegue", sender: self)
    }
    
    @IBAction func blindMoviesButtonPress(_ sender: Any) {
        Game.shared.gameMode = .blindMovies
        performSegue(withIdentifier: "mainMenuGameSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
