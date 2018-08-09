//
//  ViewController.swift
//  iOSTimePrey
//
//  Created by TempEugene on 8/9/18.
//  Copyright © 2018 TempEugene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var arrayOfPreysLabel: UILabel!
    @IBOutlet weak var chunkedUsersLabel: UILabel!
    @IBOutlet weak var secondUsersLabel: UILabel!
    @IBOutlet weak var thirdUsersLabel: UILabel!
    @IBOutlet weak var fourUsersLabel: UILabel!
    @IBOutlet weak var preyLabel: UILabel!
    
    var users = ["Svala", "Sasha A",
                 "Sasha B", "Nikita",
                 "Lena", "Andry",
                 "Igor","Eugene",
                 "Sergey", "Yura"]
    
    @IBAction func searchOfPreyPressed(_ sender: UIButton) {
        if users.count == 1 {
            arrayOfPreysLabel.isHidden = true
            chunkedUsersLabel.isHidden = true
            secondUsersLabel.isHidden = true
            thirdUsersLabel.isHidden = true
            fourUsersLabel.isHidden = true
            preyLabel.isHidden = true
            users = ["Svala", "Sasha A",
                     "Sasha B", "Nikita",
                     "Lena", "Andry",
                     "Igor","Eugene",
                     "Sergey", "Yura"]
        }
        users.shuffle()
        arrayOfPreysLabel.text = users.joined(separator: " | ")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.arrayOfPreysLabel.isHidden = false
        })
        
        while users.count != 1 {
            let chunkedUserArray = users.chunked(into: 2)
            users.removeAll()
            
            if chunkedUserArray.count == 5 {
                chunkedUsersLabel.text = "\(chunkedUserArray)"
                for array in chunkedUserArray {
                    let randomPrey = array[Int(arc4random_uniform(UInt32(array.count)))]
                    users.append(randomPrey)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.chunkedUsersLabel.isHidden = false
            })
            
            if chunkedUserArray.count == 3 {
                secondUsersLabel.text = "\(chunkedUserArray)"
                for array in chunkedUserArray {
                    let randomPrey = array[Int(arc4random_uniform(UInt32(array.count)))]
                    users.append(randomPrey)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.secondUsersLabel.isHidden = false
            })
            
            if chunkedUserArray.count == 2 {
                thirdUsersLabel.text = "\(chunkedUserArray)"
                for array in chunkedUserArray {
                    let randomPrey = array[Int(arc4random_uniform(UInt32(array.count)))]
                    users.append(randomPrey)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.thirdUsersLabel.isHidden = false
            })
            if chunkedUserArray.count == 1 {
                fourUsersLabel.text = "\(chunkedUserArray)"
                for array in chunkedUserArray {
                    let randomPrey = array[Int(arc4random_uniform(UInt32(array.count)))]
                    preyLabel.text = randomPrey
                    users.append(randomPrey)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.fourUsersLabel.isHidden = false
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.preyLabel.isHidden = false
            })
        }
        
        
    }
}





extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Array {
    func split() -> [[Element]] {
        let ct = self.count
        let half = ct / 5
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return [Array(leftSplit), Array(rightSplit)]
    }
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
}
