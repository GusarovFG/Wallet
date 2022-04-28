//
//  InfoViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 29.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit lacus, aliquam tincidunt tempus quam malesuada nulla pharetra. Arcu facilisi molestie diam morbi ultrices sollicitudin egestas non. Tellus cursus lobortis sociis elementum. Euismod nunc, amet est neque, posuere eu mauris. Leo sit sed viverra amet. Ac consectetur in convallis velit tristique eget morbi tortor consectetur. Ac nunc tincidunt erat quam convallis mattis cras sollicitudin pellentesque. Urna vel pellentesque viverra mi. Nisl nunc, accumsan malesuada nisl, vestibulum, tempus vel. Enim felis arcu nulla malesuada quis in dignissim. Pretium magnis quis id pharetra vitae. Enim ut vitae ultrices laoreet urna facilisi quam laoreet. Mauris arcu arcu eget platea sodales. In feugiat odio egestas eget. Tellus libero, malesuada in egestas aliquam velit. Neque vel a, morbi mauris sed eros, faucibus. In pretium accumsan, sit nibh nunc sodales diam eget. Et, lorem odio velit id nisl egestas purus. Nec augue risus, vulputate diam amet, dui nunc ut nisl. Rutrum nulla nisl, in eu vivamus rhoncus sit egestas ultricies. Scelerisque pellentesque tellus, libero, fermentum tempor consequat sed. Aliquet consequat feugiat pharetra maecenas et tincidunt. Accumsan, amet mi hac massa vitae nulla turpis orci. Tempus, euismod proin a luctus. Eu aenean tristique est, quam tristique aliquet donec tincidunt. Phasellus porttitor fringilla adipiscing eros, ultrices odio. Maecenas lobortis vitae a aliquam scelerisque ut egestas adipiscing volutpat. At egestas duis aliquam integer augue."
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
