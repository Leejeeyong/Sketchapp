//
//  ViewController.swift
//  sketch001
//
//  Created by JeeYong LEE on 2021/04/16.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sketchArea: UIImageView!
    var image_aa: UIImage!
    
    @IBOutlet weak var save_button: UIButton!
    @IBOutlet weak var load_button: UIButton!
    @IBOutlet weak var pen_button: UIButton!
    @IBOutlet weak var eraser_button: UIButton!
    
    var pickerController = UIImagePickerController()
    
    var lastPoint: CGPoint!
    var lineSize:CGFloat = 2.0
    var lineESize:CGFloat = 5.0
    var lineColor = UIColor.black.cgColor
    var lineEColor = UIColor.white.cgColor
    
    var mode: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerController.delegate = self
    }
    
    @IBAction func penModeAction(_ sender: Any) {
        lineSize = 2.0
        lineColor = UIColor.black.cgColor
        
    }
    
    @IBAction func eraseModeAction(_ sender: Any) {
        lineSize = 5.0
        lineColor = UIColor.white.cgColor
    }
    
    @IBAction func skecthSave_Action(_ sender: Any) {
        
        UIImageWriteToSavedPhotosAlbum(sketchArea.image!, self, nil, nil)
    }
    
    @IBAction func sketchLoad_Action(_ sender: Any) {
        
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        sketchArea.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        sketchArea.backgroundColor = UIColor.clear
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first! as UITouch
            lastPoint = touch.location(in: sketchArea)
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            UIGraphicsBeginImageContext(sketchArea.frame.size)
            UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
            
            let touch = touches.first! as UITouch
            let currPoint = touch.location(in: sketchArea)
            
            sketchArea.image?.draw(in: CGRect(x: 0, y: 0, width: sketchArea.frame.size.width, height:sketchArea.frame.size.height))
            
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            
            sketchArea.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            lastPoint = currPoint
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            UIGraphicsBeginImageContext(sketchArea.frame.size)
            UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
            
            let touch = touches.first! as UITouch
            let currPoint = touch.location(in: sketchArea)
            
            sketchArea.image?.draw(in: CGRect(x: 0, y: 0, width: sketchArea.frame.size.width, height: sketchArea.frame.size.height))
            
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            
            sketchArea.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

    
}

