//
//  PictureDetailViewCell.swift
//  GS_challenge
//
//  Created by kaushik on 21/03/22.
//

import Foundation

import UIKit

// MARK: - PictureDetailViewCell class

/**
 *  The cell displayed on the pictureDetailTableView screen. Each cell represents an `NASA Picture Detail` and displays list of the picture detail for the searched date.
 */
class PictureDetailViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// 'picOfTheDay' is a label for PictureDetailViewCell
    @IBOutlet weak var picOfTheDay: UIImageView!
    
    /// 'dateLabel' is a label for PictureDetailViewCell
    @IBOutlet weak var dateLabel: UILabel!
    
    /// 'imageTitle' is a label for PictureDetailViewCell
    @IBOutlet weak var imageTitle: UILabel!
    
    /// 'imageExplanation' is a label for PictureDetailViewCell
    @IBOutlet weak var imageExplanation: UILabel!
}

