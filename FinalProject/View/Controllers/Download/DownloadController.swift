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
    private let viewModel = DownloadViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupObserver()
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
        print("Something")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("Deleted")
    }
}

// MARK: - Notification Center
extension DownloadController {
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadProgress(notification:)), name: .downloadProgress, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadCompletion(notification:)), name: .downloadComplete, object: nil)
    }
    
    @objc private func handleDownloadProgress(notification: Notification) {
        guard let userInfo = notification.userInfo as? DownloadProgressInfo else { return }
        guard let progress = userInfo["progress"] as? Float else { return }
        guard let episodeTitle = userInfo["title"] as? String else { return }
        
        print(progress)
        print(episodeTitle)
    }
    
    @objc private func handleDownloadCompletion(notification: Notification) {
        tableView.reloadData()
    }
}
