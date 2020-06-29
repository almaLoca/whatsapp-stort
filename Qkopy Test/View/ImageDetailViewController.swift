//
//  ImageDetailViewController.swift
//  Qkopy Test
//
//  Created by user on 25/06/20.
//  Copyright © 2020 user. All rights reserved.
//


import UIKit


class ImageDetailViewController: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTag: UILabel!
    @IBOutlet weak var imageDetails: UIImageView!
    
    var link : String = String()
    var name : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = name
        labelTitle.text = title
        imageDetails.contentMode = .scaleAspectFill
        imageDetails.layer.masksToBounds = true
        imageDetails.downloaded(from: link)
    }
    
    
    
}

