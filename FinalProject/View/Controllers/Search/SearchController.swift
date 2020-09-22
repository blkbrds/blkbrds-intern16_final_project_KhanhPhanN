//
//  SearchController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class SearchController: UITableViewController {
    
    // MARK: - Private Properties
    private var viewModel = SeachViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let searchCellId: String = "SearchCell"
    private let heightForCell: CGFloat = 92
        
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearchBar()
        setupTableView()
    }
    
    // MARK: - Private functions
    private func setupNavigation() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .systemOrange
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: searchCellId, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: searchCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getAPI(searchText: String) {
        viewModel.getData(key: searchText) { (result) in
            if result {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableView
extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.podcast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchCellId, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = viewModel.podcast[indexPath.row]
        let episodesViewModel = EpisodesViewModel(podcast: podcast)
        let episodesController = EpisodesController(viewModel: episodesViewModel)
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDownloadContextualAction(forRowAt: indexPath)
        ])
    }
    
    private func makeDownloadContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Download") { (_, _, completion) in
            print("DOWNLOADED CELL \(indexPath.row)")
            completion(true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.podcast = []
        getAPI(searchText: searchText)
    }
}
