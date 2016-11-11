//
//  ResultViewController.swift
//  melissatjhia-pset2
//
//  Created by Melissa Tjhia on 09-11-16.
//  Copyright © 2016 Melissa Tjhia. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var story : Story?
    
    @IBOutlet weak var storyText: UITextView!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyText.text = story?.toString()
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Source rendering: https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
     */
    
    /// Save an image of the story.
    @IBAction func saveImage(_ sender: Any) {
        // Render the view to an image that can be saved.
        let renderer = UIGraphicsImageRenderer(size: mainView.bounds.size)
        let image = renderer.image { ctx in
            mainView.drawHierarchy(in: mainView.bounds, afterScreenUpdates: true)
        }
        // Save image to cameraroll.
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(checkIfSaved(_:savingError:contextInfo:)), nil);
    }
    

     /* Source: https://www.hackingwithswift.com/example-code/media/uiimagewritetosavedphotosalbum-how-to-write-to-the-ios-photo-album
     */
    
    /// Checks if the saving of the image to cameraroll has succeeded or failed. Shows corresponding alert.
    func checkIfSaved(_ image: UIImage, savingError error: NSError?, contextInfo: UnsafeRawPointer) {
        // If saving failed to save.
        if let failed = error {
            let alertController = UIAlertController(title: "Failed to save image to cameraroll", message: failed.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default))
            present(alertController, animated: true)
        // If saving succeeded to save.
        } else {
            let alertController = UIAlertController(title: "Succeeded", message: "Image has been saved to cameraroll", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default))
            present(alertController, animated: true)
        }
    }
}
