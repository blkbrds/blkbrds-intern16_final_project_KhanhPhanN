//
//  GenreCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class GenreCell: UITableViewCell {
    
    var viewModel: GenreCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        trackNameLabel.text = viewModel?.trackName
        artistNameLabel.text = viewModel?.artistName
        trackCountLabel.text = "\(viewModel?.trackCount ?? 0) Episodes"
        guard let url = URL(string: viewModel?.artworkUrl600 ?? "") else { return }
        thumbImageView.sd_setImage(with: url)
    }
}
