//
//  Concentration.swift
//  04_Concentration
//
//  Created by yhp on 2019/3/25.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    
    /// 选择卡片
    /// - Parameter index: 下标
    func chooseCard(at index:Int)  {
        if !cards[index].isMatched {
            //  寻找需要匹配的卡片
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched  = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else {
                // 有或者有两张翻开
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        var unShuffeldCards: [Card] = []
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            unShuffeldCards += [card,card]
        }
        //  TODO: Shuffle the cards
        //  使用额外的存储空间来洗牌
        while !unShuffeldCards.isEmpty {
            let randomIndex = unShuffeldCards.count.arc4Random
            let card = unShuffeldCards.remove(at: randomIndex)
            cards.append(card)
        }
    }
}
