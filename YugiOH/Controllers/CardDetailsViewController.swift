//
//  CardDetailsViewController.swift
//  YugiOH
//
//  Created by Bryan A Bolivar M on 11/26/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import SDWebImage

class CardDetailsViewController: UIViewController {
    var card:Carta! = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    @IBOutlet weak var starsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        attack.text = "\(card.ataque)"
        defense.text = "\(card.defensa)"
        image.sd_setImage(with: NSURL(string:card.imagen) as! URL , placeholderImage: UIImage())
        
        let fBreed = NSMutableAttributedString()
        let fDetails = NSMutableAttributedString()
        let fType = NSMutableAttributedString()
        
        
        breed.attributedText = fBreed.bold(text: "Raza: ").normal(text: card.raza)
        details.attributedText = fDetails.bold(text: "Descripción: ").normal(text: card.descripcion)
        type.attributedText = fType.bold(text: "Tipo: ").normal(text: card.tipo)
        
        
        self.title = card.nombre
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadImage()
        drawStars()
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Animations
    
    func loadImage() {
        self.heightContraint.constant = UIScreen.main.bounds.size.width
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func drawStars() {
        for starCount in 0...(card.nivel-1) {
            let estrella = UIImageView(image: UIImage(named: "star"))
            
            estrella.frame = CGRect(x: (25 * starCount) + 10, y: 10, width: 20, height: 20)
            
            starsContainer.addSubview(estrella)
        }
       
    }

    
}

extension NSMutableAttributedString {
    func bold(text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 17)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
