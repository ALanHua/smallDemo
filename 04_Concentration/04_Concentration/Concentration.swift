//
//  Concentration.swift
//  04_Concentration
//
//  Created by yhp on 2019/3/25.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard : Int?{
        get{
            var foundIndex:Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    guard foundIndex == nil else{return nil}
                    foundIndex = index
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
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
            }else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        //  断言
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        
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
