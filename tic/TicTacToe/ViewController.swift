//
//  ViewController.swift
//  TicTacToe
//
//  Created by Rawuda Jemal on 06/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        startBtn.layer.cornerRadius = 12
        
        cardView.layer.cornerRadius = 12
        
       
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        
        cardView.layer.shadowRadius = 12
        
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowOffset = .zero
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        guard !nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let gc = storyboard?.instantiateViewController(identifier: "gameScene") as! GameViewController
        gc.playerName = nameField.text
        
        gc.modalTransitionStyle = .flipHorizontal
        
        gc.modalPresentationStyle = .fullScreen
        self.present(gc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gc = segue.destination as? GameViewController {
           
            gc.playerName = nameField.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       
        if identifier == "goToGameVC" {
            if nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
            
        }
        
        return true
    }
}

