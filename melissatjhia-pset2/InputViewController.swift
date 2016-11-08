//
//  InputViewController.swift
//  melissatjhia-pset2
//
//  Created by Melissa Tjhia on 07-11-16.
//  Copyright © 2016 Melissa Tjhia. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var labelPlaceholdersLeft: UILabel!
    @IBOutlet weak var labelPlaceholderType: UILabel!
    @IBOutlet weak var textInputPlaceholder: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let story = pickStory()
        updateLabels(story: story!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // From: http://stackoverflow.com/questions/36580542/i-cant-read-my-text-files-from-my-applications-bundle
    func pickStory() -> Story? {
        var res = ""
        if let asset = NSDataAsset(name: "madlib0_simple") ,
            let string = String(data:asset.data, encoding: String.Encoding.utf8){
            res = string
            
            let story = Story(stream: res)
            return story
        }
        else {
            return nil
        }
    }
    
    func updateLabels(story: Story) {
        let placeholdersLeft = story.getPlaceholderRemainingCount()
        let placeHolderType = story.getNextPlaceholder()
        labelPlaceholdersLeft.text = String(placeholdersLeft) + " word(s) left"
        labelPlaceholderType.text = "Please type a/an " + placeHolderType
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
