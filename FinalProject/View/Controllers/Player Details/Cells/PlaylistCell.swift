//
//  PlaylistCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PlaylistCell: UITableViewCell {
    
    var viewModel: PlaylistCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        titleLabel.text = viewModel?.title
        authorNameLabel.text = viewModel?.author
        guard let url = URL(string: viewModel?.imageUrl ?? "") else { return }
        thumbImageView.sd_setImage(with: url)
    }
}
