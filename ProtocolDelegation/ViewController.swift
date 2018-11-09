//
//  ViewController.swift
//  ProtocolDelegation
//
//  Created by MacUser on 07/09/16.
//  Copyright © 2016 Richard Simpson. All rights reserved.
//

import UIKit

class ViewController: UIViewController , RandomModelDelegate {
    
    @IBOutlet weak var lblRndGetal: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var rndModel = RandomModel()
    var numberOfTry = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rndModel.delegate = self
        let rndColor = UIColor.black
        lblRndGetal.textColor = rndColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func foundRandom() {
        DispatchQueue.main.async { [unowned self] in
            
            self.lblRndGetal.text = "Gevonden : \(self.rndModel.randomNummer)"
        }
    }
    func currentRandom(_ randomNr: Int) {
 
        numberOfTry += 1
        
    }
    
    @IBAction func searchInForgroundClicked(_ sender: AnyObject) {
        self.textField.text = "Functie wordt uigevoerd op de voorgrond"
        self.rndModel.findRandom(188, inRange: 3000)
        self.textField.text = "Klaar met voorgrond task met \(self.numberOfTry) tries"
        self.numberOfTry = 0
    }
    
    @IBAction func searchClicked(_ sender: AnyObject) {
        // let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        let mediumPriority = DispatchQoS.QoSClass.userInitiated
        //  let highestPriority = QOS_CLASS_USER_INTERACTIVE
        DispatchQueue.global(qos: mediumPriority).async {[unowned self] in
            self.rndModel.findRandom(576, inRange: 3000)
            DispatchQueue.main.async { [unowned self] in
                // altijd UI handelingen op de main que uitvoeren
                self.textField.text = "Klaar met achtergrond task met \(self.numberOfTry) tries"
                self.numberOfTry = 0
            }
        }
    }
    
    
}


