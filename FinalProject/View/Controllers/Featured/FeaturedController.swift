//
//  FeaturedController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class FeaturedController: UITableViewController {
    
    private var viewModel = FeaturedViewModel()
    
    private let headerTableCellId: String = "HeaderTableCell"
    private let itemsTableCellId: String = "ItemsTableCell"
    private let heightForHeader: CGFloat = 300
    private let heightForCell: CGFloat = 250
       
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
    
    // MARK: - Private functions
    private func setupNavigation() {
        title = "Explore"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        let headerNib = UINib(nibName: headerTableCellId, bundle: .main)
        tableView.register(headerNib, forCellReuseIdentifier: headerTableCellId)
        let cellNib = UINib(nibName: itemsTableCellId, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: itemsTableCellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableView
extension FeaturedController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeaturedViewModel.Genres.allCases.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: headerTableCellId, for: indexPath) as? HeaderTableCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: itemsTableCellId, for: indexPath) as? ItemsTableCell else { return UITableViewCell() }
            cell.delegate = self
            cell.viewModel = viewModel.viewModelForItem(at: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return heightForHeader
        default:
            return heightForCell
        }
    }
}

// MARK: - ItemsTableCellDelegateDelegate
extension FeaturedController: ItemsTableCellDelegate {
    
    func cell(_ cell: ItemsCollectionCell, needsPerform action: ItemsTableCell.Action) {
        switch action {
        case .didSelectCell(let value):
            let episodesViewModel = EpisodesViewModel(podcast: value)
            let episodesController = EpisodesController(viewModel: episodesViewModel)
            navigationController?.pushViewController(episodesController, animated: true)
        }
    }
}

// MARK: - HeaderTableCellDelegate
extension FeaturedController: HeaderTableCellDelegate {
    
    func cell(_ cell: HeaderTableCell, needsPerform action: HeaderTableCell.Action) {
        switch action {
        case .didSelectCell(let value):
            let episodesViewModel = EpisodesViewModel(podcast: value)
            let episodesController = EpisodesController(viewModel: episodesViewModel)
            navigationController?.pushViewController(episodesController, animated: true)
        }
    }
}
