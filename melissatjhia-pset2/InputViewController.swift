//
//  InputViewController.swift
//  melissatjhia-pset2
//
//  Created by Melissa Tjhia on 07-11-16.
//  Copyright © 2016 Melissa Tjhia. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    // The labels
    @IBOutlet weak var labelExplanation: UILabel!
    @IBOutlet weak var labelPlaceholdersLeft: UILabel!
    @IBOutlet weak var labelPlaceholderType: UILabel!
    
    // Text field
    @IBOutlet weak var textInputPlaceholder: UITextField!
    
    // Button to go to next page
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
    
    // Mostly from: http://stackoverflow.com/questions/36580542/i-cant-read-my-text-files-from-my-applications-bundle
    func pickStory() -> Story? {
        if let asset = NSDataAsset(name: storyId) ,
            let string = String(data:asset.data, encoding: String.Encoding.utf8){
            
            let story = Story(stream: string)
            return story
        }
        else {
            print("Story not found")
            return nil
        }
    }
    
    /// Updates the labels for the next placeholder.
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

    /// Fills in the placeholder and update labels
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
