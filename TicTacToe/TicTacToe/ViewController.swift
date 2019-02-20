//
//  ViewController.swift
//  TicTacToe
//
//  Created by Gladston Joseph on 2/19/19.
//  Copyright © 2019 Gladston Joseph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    @IBOutlet var messageView: UIView!
    
    
    @IBAction func restartButton(_ sender: Any) {
        newGame()
        backToMainView()
    }
    
    @IBOutlet weak var winningLabel: UILabel!
    
    var effect: UIVisualEffect!
    
    var activeGame = true
    
    var activePlayer = 1
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]  // 0: Empty, 1: Noughts, 2: Crosses
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        let activePosition = (sender as AnyObject).tag - 1
        
        if gameState[activePosition] == 0 && activeGame {
            gameState[activePosition] = activePlayer
            if activePlayer == 1 {
                (sender as AnyObject).setTitle("⭕️", for: UIControl.State.normal)
                activePlayer = 2
            } else {
                (sender as AnyObject).setTitle("❌", for: UIControl.State.normal)
                activePlayer = 1
            }
            checkCombinations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //effect = blurEffectView.effect
        //blurEffectView.effect = nil
    }

    
    func checkCombinations() {
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                // We have a winner
                activeGame = false
                print(gameState[combination[0]])
                if gameState[combination[0]] == 1 {
                    winningLabel.text = "⭕️"
                    winningLabel.font = UIFont(name: winningLabel.font.fontName, size: 100)
                } else if gameState[combination[0]] == 2 {
                    winningLabel.text = "❌"
                    winningLabel.font = UIFont(name: winningLabel.font.fontName, size: 100)
                }
                activateMessageView()
            }
            if gameState.contains(0) == false && gameState[combination[0]] != 0 && gameState[combination[0]] != gameState[combination[1]] && gameState[combination[1]] != gameState[combination[2]] {
                winningLabel.text = "Game Draw"
                winningLabel.font = UIFont(name: winningLabel.font.fontName, size: 47)

                activateMessageView()
            }
        }
    }
    
    func activateMessageView() {
        self.view.addSubview(messageView)
        winningLabel.center = self.view.center
        winningLabel.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        messageView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.winningLabel.alpha = 1
            self.winningLabel.transform = CGAffineTransform.identity
        }
        messageView.center = self.view.center
        messageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        messageView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            //self.blurEffectView.effect = self.effect
            self.messageView.alpha = 1
            self.messageView.transform = CGAffineTransform.identity
        }
        
    }
    
    func backToMainView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.winningLabel.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            //self.blurEffectView.effect = nil
        }) { (success: Bool) in
            // self.winningLabel.removeFromSuperview()
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.messageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            //self.blurEffectView.effect = nil
        }) { (success: Bool) in
            self.messageView.removeFromSuperview()
        }
    }
    
    func newGame() {
        activeGame = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        var button: UIButton
        for i in 1..<10 {
            button = view.viewWithTag(i) as! UIButton
            button.setTitle("", for: UIControl.State.normal)
        }
    }
    
}

