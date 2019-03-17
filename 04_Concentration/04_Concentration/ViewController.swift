//
//  ViewController.swift
//  04_Concentration
//
//  Created by yhp on 2019/3/17.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    /* ==================================================== */
    /*                          变量声明区                    */
    /* =====================================================*/
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    /* ====================================================*/
    /*                          函数声明区                  */
    /* ================================================== */
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardsButtons.index(of: sender){
            guard cardNumber >= cardsButtons.count else{
                return
            }
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String,on button:UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.626716435, blue: 0.3430028558, alpha: 1)
        }else{
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        }
    }

}

