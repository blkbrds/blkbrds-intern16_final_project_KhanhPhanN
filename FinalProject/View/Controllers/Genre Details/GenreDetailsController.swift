//
//  GenreDetailsController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class GenreDetailsController: UITableViewController {
    
    // MARK: - Properties
    private let genreCellId = "GenreCell"
    private let heightForCell: CGFloat = 92
    var viewModel: GenreDetailsViewModel
    
    init(viewModel: GenreDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        getAPI()
    }
    
    // MARK: - Private functions
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .systemOrange
        title = viewModel.genre.title
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: genreCellId, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: genreCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getAPI() {
        viewModel.getData(completion: { (result) in
            if result {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.podcast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: genreCellId, for: indexPath) as? GenreCell else { return UITableViewCell() }
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
}
