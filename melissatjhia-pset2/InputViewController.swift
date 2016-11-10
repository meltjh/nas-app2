//
//  InputViewController.swift
//  melissatjhia-pset2
//
//  Created by Melissa Tjhia on 07-11-16.
//  Copyright © 2016 Melissa Tjhia. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var labelExplanation: UILabel!
    @IBOutlet weak var labelPlaceholdersLeft: UILabel!
    @IBOutlet weak var labelPlaceholderType: UILabel!
    @IBOutlet weak var textInputPlaceholder: UITextField!
    @IBOutlet weak var storySegue: UIBarButtonItem!
    
    var storyId = ""
    var storyName = ""
    var story : Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        story = pickStory()
        labelExplanation.text = "Fill in the words to complete '" + storyName + "'"
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From: http://stackoverflow.com/questions/36580542/i-cant-read-my-text-files-from-my-applications-bundle
    func pickStory() -> Story? {
        var res = ""
        if let asset = NSDataAsset(name: storyId) ,
            let string = String(data:asset.data, encoding: String.Encoding.utf8){
            res = string
            
            let story = Story(stream: res)
            return story
        }
        else {
            return nil
        }
    }
    
    func updateLabels() {
        textInputPlaceholder.text = ""
        let placeholdersLeft = story?.getPlaceholderRemainingCount()
        let placeHolderType = story?.getNextPlaceholder()
        if (placeholdersLeft! > 0) {
            labelPlaceholdersLeft.text = String(placeholdersLeft!) + " word(s) left"
            labelPlaceholderType.text = "Please type a/an " + placeHolderType!
            textInputPlaceholder.placeholder = placeHolderType
        }
        else {
            labelPlaceholdersLeft.text = "All words are filled in!"
            labelPlaceholderType.text = ""
            storySegue.isEnabled = true
            
            textInputPlaceholder.placeholder = ""
            textInputPlaceholder.isEnabled = false
        }
    }
    

    @IBAction func processInput(_ sender: UITextField) {
        if textInputPlaceholder.text?.isEmpty == false {
            story?.fillInPlaceholder(word: sender.text!)
        updateLabels()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultViewController {
            vc.story = story
        }
    }
}
