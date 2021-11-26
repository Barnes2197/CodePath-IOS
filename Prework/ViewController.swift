//
//  ViewController.swift
//  Prework
//
//  Created by Maurice Barnes on 11/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tip Calculator"
        let bill = UserDefaults.standard.double(forKey: "bill")
        billAmountTextField.text = String(bill)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        tipSegment.removeAllSegments()
        
        
        if defaults.array(forKey: "tipArray") == nil {
            defaults.set([0.15, 0.18, 0.2], forKey: "tipArray")
        }
        
        let tipArray = defaults.array(forKey: "tipArray") as? [Double]
        
        for (index, tip) in tipArray!.enumerated() {
            tipSegment.insertSegment(withTitle:  "\(Int(tip * 100)) %", at: index, animated: false)
        }
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "index")
        billAmountTextField.becomeFirstResponder()
    }

    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from texxt field input
        let bill = Double(billAmountTextField.text!) ?? 0
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "bill")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "index")
        // Get Total tip by multiplying tip * tipPercentage
        let tipPercentages = defaults.array(forKey: "tipArray") as? [Double]
        let tip = bill * (tipPercentages?[tipControl.selectedSegmentIndex])!
        let total = bill + tip
        
        //Formatter for local currency conversion
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        //Update Tip Amount Label
        tipAmountLabel.text = String(formatter.string(from: NSNumber(value: tip)) ?? "n/a")
        
        //Update Total Amount
        totalLabel.text =  String(formatter.string(from: NSNumber(value: total)) ?? "n/a")
    }
    
}

