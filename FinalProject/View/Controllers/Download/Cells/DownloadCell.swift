//
//  DownloadCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class DownloadCell: UITableViewCell {
    
    var viewModel: DownloadCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        titleLabel.text = viewModel?.title
        authorLabel.text = viewModel?.author
        guard let url = URL(string: viewModel?.imageUrl ?? "") else { return }
        thumbImageView.sd_setImage(with: url)
    }
}
