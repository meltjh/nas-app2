//
//  ViewController.swift
//  melissatjhia-pset2
//
//  Created by Melissa Tjhia on 07-11-16.
//  Copyright © 2016 Melissa Tjhia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var storyPicker: UIPickerView!
    
    // Story ids that match the names in the options.
    let storyNamesIds = ["Simple": "madlib0_simple", "Tarzan": "madlib1_tarzan", "University": "madlib2_university", "Clothes": "madlib3_clothes", "Dance": "madlib4_dance"]
    
    let storyNames = ["Simple", "Tarzan", "University", "Clothes", "Dance"]
    
    var storyName = ""
    var storyId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // For the Picker View.
        self.storyPicker.delegate = self
        self.storyPicker.dataSource = self
        
        // Default settings.
        storyName = storyNames[0]
        storyId = storyNamesIds[storyName]!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picker View mostly from: http://codewithchris.com/uipickerview-example/
    
    // The number of columns of data.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Return the strings of the enumerator values in the pickerData.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storyNames[row]
    }
    
    // The number of rows of data.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storyNames.count
    }
    
    // Whenever selection is changed, change selected story.
    func pickerView(_: UIPickerView, didSelectRow: Int, inComponent: Int){
        storyName = storyNames[didSelectRow]
        storyId = storyNamesIds[storyName]!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InputViewController {
            vc.storyId = storyId
            vc.storyName = storyName
        }
    }

}

