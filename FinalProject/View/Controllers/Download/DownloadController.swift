//
//  DownloadController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class DownloadController: UITableViewController {
    
    private let downloadCellId = "DownloadCell"
    private let heightForRow: CGFloat = 92
    private var viewModel = DownloadViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = DownloadViewModel()
        setupObserver()
        viewModel.fetchDownloadedEpisode { (data) in
            if data {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private functions
    private func setupNavigation() {
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: downloadCellId, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: downloadCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
}

// MARK: - UITableView
extension DownloadController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: downloadCellId, for: indexPath) as? DownloadCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.musicPlayerView?.viewModel = viewModel.viewModelForItem(indexPath: indexPath)
        mainTabBarController?.maximizePlayerDetails()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deleteDownloadedEpisode(at: indexPath)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.bottom)
        tableView.reloadData()
    }
}

// MARK: - Notification Center
extension DownloadController {
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadProgress(notification:)), name: .downloadProgress, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadCompletion(notification:)), name: .downloadComplete, object: nil)
    }
    
    @objc private func handleDownloadProgress(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let progress = userInfo["progress"] as? Double else { return }
        guard let title = userInfo["title"] as? String else { return }
        
        guard let index = viewModel.episodes.firstIndex(where: { $0.title == title }) else { return }
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? DownloadCell else { return }
        cell.progressView.setProgress(Float(progress), animated: false)
        cell.progressView.isHidden = false
        
        while progress < 1 {
            cell.thumbImageView.alpha = 0.5
            cell.titleLabel.alpha = 0.5
            cell.authorLabel.alpha = 0.5
            break
        }
        
        if progress == 1 {
            cell.thumbImageView.alpha = 1
            cell.titleLabel.alpha = 1
            cell.authorLabel.alpha = 1
            cell.progressView.isHidden = true
        }
    }
    
    @objc private func handleDownloadCompletion(notification: Notification) {
        guard let episodeDownloadComplete = notification.object as? Api.Download.EpisodeDownloadCompletion else { return }
        guard let index = viewModel.episodes.firstIndex(where: { $0.title == episodeDownloadComplete.episodeTitle }) else { return }
        viewModel.episodes[index].fileUrl = episodeDownloadComplete.fileUrl
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
