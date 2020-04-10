//
//  ViewController.swift
//  InstaGrid
//
//  Created by Nda Kwadzo Olivier on 13/02/2020.
//  Copyright © 2020 nksolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gridView: UIView!
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var gridButtons: [UIButton]!
    @IBOutlet weak var topLeftgridButton: UIButton!
    @IBOutlet weak var bottomLeftGridButton: UIButton!
    
    let imagePickerConroler = UIImagePickerController()
    var tag = 0
    var swipeGestureRecognizer : UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        
        gridView.addGestureRecognizer(swipeGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        imagePickerConroler.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @objc func setupSwipeDirection() {
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
            
        }
    }
    
    
    @objc func handleSwipe(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .up {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform (translationX: 0, y: -self.view.frame.height)
            })
            
        } else {
        UIView.animate(withDuration: 0.5, animations: {
            self.gridView.transform = CGAffineTransform (translationX: -self.view.frame.width, y: 0)
        })
            
    }

        let activityViewController = UIActivityViewController(activityItems: [gridView.image], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
            activityViewController.completionWithItemsHandler = { _, _, _, _ in
                UIView.animate(withDuration: 0.5) {
                    self.gridView.transform = .identity
     }
   }
}
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        layoutButtons.forEach { $0.isSelected = false}
       
        
        sender.isSelected = true
        
        switch sender.tag {
        case 0:
            topLeftgridButton.isHidden = true
            bottomLeftGridButton.isHidden = false
        case 1:
            topLeftgridButton.isHidden = false
            bottomLeftGridButton.isHidden = true
        case 2 :
            topLeftgridButton.isHidden = false
            bottomLeftGridButton.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func imagePikerAction(_ sender: UIButton) {
        tag = sender.tag
        present(imagePickerConroler, animated: true)
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageSelected = info [.originalImage] as? UIImage else
        { return }
        gridButtons [tag].setImage(imageSelected, for: .normal)
        gridButtons [tag].layoutIfNeeded()
        gridButtons [tag].subviews.first?.contentMode = .scaleAspectFill
        print (imageSelected)
        picker.dismiss(animated: true)
    }
    
}

//extension UIImage {
//    convenience init(_ view: UIView) {
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.init(cgImage: (image?.cgImage)!)
//    }
//}
//


