//
//  CardListController.swift
//  YugiOH
//
//  Created by Bryan A Bolivar M on 11/26/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import SDWebImage

class CardListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cards: [Carta] = []
    var chosenCard:Carta!
    var refreshControl: UIRefreshControl!
    let kPullDownToRefreshText = "Pull to refresh"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up pull down to refresh
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString(kPullDownToRefreshText, comment: "pull down to refresh"))
        refreshControl.addTarget(self, action: #selector(self.reloadData), for
            : UIControlEvents.valueChanged)
        refreshControl.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        refreshControl.tintColor = UIColor.darkText
        tableView.addSubview(refreshControl)
        
        reloadData()
        
    }
    
    
    func reloadData(){
        Networking.listarCartas { (cartas) in
            self.refreshControl.endRefreshing()
            self.cards = cartas
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // in half a second...
                self.tableView.reloadData()
            }
                    }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "CardDetailsSegue") {
            let viewController:CardDetailsViewController = segue.destination as! CardDetailsViewController
            viewController.card = self.chosenCard
        }
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        
        let card = cards[indexPath.row]
        cell.name.text = card.nombre
        cell.breed.text = card.raza
        cell.logo.sd_setImage(with: NSURL(string:card.imagen) as! URL , placeholderImage: UIImage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.chosenCard = cards[indexPath.row]
        self.performSegue(withIdentifier: "CardDetailsSegue", sender: self)
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
}
