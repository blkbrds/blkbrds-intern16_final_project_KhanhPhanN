//
//  EpisodesController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

final class EpisodesController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var headerNameLabel: UILabel!
    @IBOutlet private var headerArtistLabel: UILabel!
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel: EpisodesViewModel
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let episodesCellId: String = "EpisodesCell"
    private let thumbImageSize: CGSize = CGSize(width: 200, height: 200)
    private let heightForCell: CGFloat = 80
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generalSetting()
        getAPI()
    }
    
    // MARK: - Private get API function
    private func getAPI() {
        viewModel.getEpisodesData { (result) in
            if result {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Setup Views
extension EpisodesController {
    
    // MARK: - Private functions
    private func generalSetting() {
        setupTableView()
        setupHeaderView()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .systemOrange
        if viewModel.isLiked() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-sel"), style: .plain, target: self, action: #selector(favouriteAction))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite"), style: .plain, target: self, action: #selector(favouriteAction))
        }
    }
    
    @objc private func favouriteAction() {
        if viewModel.reaction() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-sel"), style: .plain, target: self, action: #selector(favouriteAction))
            showBadge()
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite"), style: .plain, target: self, action: #selector(favouriteAction))
        }
    }
    
    private func showBadge() {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.viewControllers?[2].tabBarItem.badgeValue = "New"
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: episodesCellId, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: episodesCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
    }
    
    private func setupHeaderView() {
        headerImageView.addBlurEffect()
        headerImageView.addBlackGradientLayerInForeground(frame: view.bounds, colors: [.clear, .black])
        
        viewModel.getEpisodesData { (result) in
            if result {
                self.headerNameLabel.text = self.viewModel.podcast.trackName
                self.headerArtistLabel.text = self.viewModel.podcast.artistName
                guard let url = URL(string: self.viewModel.podcast.artworkUrl600 ?? "") else { return }
                self.headerImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: self.thumbImageSize])
                self.avatarImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: self.thumbImageSize])
            }
        }
    }
}

// MARK: - UITableView
extension EpisodesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: episodesCellId, for: indexPath) as? EpisodesCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.musicPlayerView?.viewModel = viewModel.viewModelForItem(indexPath: indexPath)
        mainTabBarController?.maximizePlayerDetails()
    }
}
