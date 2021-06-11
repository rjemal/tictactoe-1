//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Rawuda Jemal on 06/01/2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var computerScoreLbl: UILabel!
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    var playerName: String!
    var lastValue = "o"
    
    var compAnswer: [Box] = []
    
    var playerAnswer: [Box] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerNameLbl.text = playerName + ":"
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
    }
    
    func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(from: sender.name ?? "")
        makeChoice(selectedBox)
        playerAnswer.append(Box(rawValue: sender.name!)!)
        checkIfWon()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.computerPlay()
        }
    }
    
    func computerPlay() {
        var openS = [UIImageView]()
        var openB = [Box]()
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                openS.append(box)
                openB.append(name)
            }
        }
        
        guard openB.count > 0 else { return }
        
        let randomPlace = Int.random(in: 0 ..< openS.count)
        makeChoice(openS[randomPlace])
        
        compAnswer.append(openB[randomPlace])
        checkIfWon()
    }
    
    func makeChoice(_ chosenB: UIImageView) {
        guard chosenB.image == nil else { return }
        
        if lastValue == "x" {
            chosenB.image = #imageLiteral(resourceName: "o")
            lastValue = "o"
        } else {
            chosenB.image = #imageLiteral(resourceName: "x")
            lastValue = "x"
        }
    }
    
    func checkIfWon() {
        var correct = [[Box]]()
        let h1: [Box] = [.one, .two, .three]
        let h2: [Box] = [.four, .five, .six]
        let h3: [Box] = [.seven, .eight, .nine]
        
        let v1: [Box] = [.one, .four, .seven]
        let v2: [Box] = [.two, .five, .six]
        let v3: [Box] = [.three, .six, .nine]
        
        let diag1: [Box] = [.one, .five, .nine]
        let diag2: [Box] = [.three, .five, .seven]
        
        correct.append(h1)
        correct.append(h2)
        correct.append(h3)
        correct.append(v1)
        correct.append(v2)
        correct.append(v3)
        correct.append(diag1)
        correct.append(diag2)
        
        for valid in correct {
            let userMatch = playerAnswer.filter { valid.contains($0) }.count
            let computerMatch = compAnswer.filter { valid.contains($0) }.count
            
            if userMatch == valid.count {
                playerScoreLbl.text = String((Int(playerScoreLbl.text ?? "0") ?? 0) + 1)
                resetGame()
                break
            } else if computerMatch == valid.count {
                computerScoreLbl.text = String((Int(computerScoreLbl.text ?? "0") ?? 0) + 1)
                resetGame()
                break
            } else if compAnswer.count + playerAnswer.count == 9 {
                resetGame()
                break
            }
        }
        
    }
    
    func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerAnswer = []
        compAnswer = []
 
       
    }
    
    func getBox(from name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

enum Box: String, CaseIterable {
    
    case one, two, three, four, five, six, seven, eight, nine
}
