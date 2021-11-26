//
//  SettingsViewController.swift
//  Prework
//
//  Created by Maurice Barnes on 11/25/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip3Value: UITextField!
    @IBOutlet weak var tip2Value: UITextField!
    @IBOutlet weak var tip1Value: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let tipArray = defaults.array(forKey: "tipArray") as? [Double]
        
        tip1Value.text = "\(Int(tipArray![0] * 100))"
        tip2Value.text = "\(Int(tipArray![1] * 100))"
        tip3Value.text = "\(Int(tipArray![2] * 100))"
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        let defaults = UserDefaults.standard
        var tipArray = defaults.array(forKey: "tipArray") as? [Double]
        //Using Number Formatter to grab values and default if value isn't valid
        let nf = NumberFormatter()
        tipArray?[0] = (nf.number(from: tip1Value.text ?? "15")?.doubleValue ?? 15) / 100
        tipArray?[1] = (nf.number(from: tip2Value.text ?? "18")?.doubleValue ?? 18) / 100
        tipArray?[2] = (nf.number(from: tip3Value.text ?? "20")?.doubleValue ?? 20) / 100
        defaults.set(tipArray, forKey: "tipArray")
    }
}
