//
//  ViewController.swift
//  Wang
//
//  Created by 王宾宾 on 2017/7/14.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var targetLabel: UILabel!

    @IBOutlet var slider: UISlider!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var roundLabel: UILabel!
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        let title: String
        let message = "Your score: \(points)"
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.startNewRound()
            self.updateLabels()
        }
        alert.addAction(action)
        present(alert, animated: true) { 
            
        }
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = Int(sender.value)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
        updateLabels()
        // Create a Core Animation transition. This will crossfade from what is
        // currently on the screen to the changes that you're making below.
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // This makes the animation go.
        view.layer.add(transition, forKey: nil)
    }
    
    var targetValue = 0
    var score = 0
    var round = 0
    var currentValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        let thumbImageHighlight = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlight, for: .highlighted)
        let inset = UIEdgeInsetsMake(0, 14, 0, 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        trackLeftImage.resizableImage(withCapInsets: inset, resizingMode: .tile)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: inset)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
    }
}

