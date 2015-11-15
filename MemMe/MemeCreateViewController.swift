//
//  MemeCreateViewController.swift
//  MemMe
//
//  Created by Mark Vicuna on 11/14/15.
//  Copyright © 2015 Mark Vicuna. All rights reserved.
//

import UIKit
import MobileCoreServices

class MemeCreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    {
    // MARK: Properties
    
    @IBOutlet weak var TopText: UITextView!
    @IBOutlet weak var BottomText: UITextView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded memcreateview")
        
        // Do any additional setup after loading the view.
        self.picker.delegate = self
        self.CameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        let testAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSStrokeWidthAttributeName : NSNumber(float: -1.5),
            NSFontAttributeName : UIFont.systemFontOfSize(30.0)
            ]
        
        self.TopText.attributedText = NSAttributedString(string: self.TopText.text!, attributes: testAttributes)
        self.BottomText.attributedText = NSAttributedString(string: self.BottomText.text!, attributes: testAttributes)
        
        self.TopText.typingAttributes = testAttributes
        self.BottomText.typingAttributes = testAttributes

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnCancel(sender: AnyObject) {
        print("cancel")
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func onAction(sender: AnyObject) {
        let meme = self.Image.image!
        let objectsToShare = [meme]
        let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)

    }
    @IBAction func onCamera(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(picker, animated: true, completion: nil)
    }
 
    @IBAction func onAlbum(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker, animated: true, completion: {print("completed")})
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("picked image")
        let type = info[UIImagePickerControllerMediaType] as! NSString
        if ( type == kUTTypeImage)
        {
            self.Image.image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.picker.dismissViewControllerAnimated(true, completion: {})
        }
        else {
            let alert = UIAlertController()
            alert.message = "Media selected not an image. Please Try again"
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
