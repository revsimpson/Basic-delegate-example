//
//  RandomModel.swift
//  ProtocolDelegation
//
//  Created by MacUser on 07/09/16.
//  Copyright © 2016 Richard Simpson. All rights reserved.
//

import UIKit

protocol RandomModelDelegate {
    func foundRandom()
    func currentRandom(_ randomNr : Int)
}

class RandomModel : NSObject {
    var randomNummer : Int = 0
    var delegate:RandomModelDelegate?
    
    func findRandom(_ random:Int, inRange:Int)
    {
        randomNummer = 0
        while   randomNummer != random {
            randomNummer =  Int(arc4random_uniform(UInt32(inRange)))
            if let actualDelegate = self.delegate {
                
                actualDelegate.currentRandom(randomNummer)
            }
            
        }
        
        if let actualDelegate = self.delegate {
           
            actualDelegate.foundRandom()
            
        }
    }
}

