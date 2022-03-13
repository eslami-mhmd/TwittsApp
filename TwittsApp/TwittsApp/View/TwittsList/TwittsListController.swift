//
//  File.swift
//  
//
//  Created by Mohammad Eslami on 3/9/22.
//

import Combine
import UIKit

class TwittsListController: UIViewController {
    // MARK: Properties
    var viewModel = TwittsListViewModel(twittsRepository: TwittsRepository(remoteAPI: RemoteAPI()))
    var dataSource: UITableViewDiffableDataSource<TwittsListSection, TwittResponse>!
    var anyCancel: Set<AnyCancellable> = []
    enum TwittsListSection: CaseIterable {
        case main
    }

    let searchController = UISearchController(searchResultsController: nil)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.separatorInset = .zero
        tableView.register(TwittsListCell.self, forCellReuseIdentifier: TwittsListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        return tableView
    }()
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDataSource()
        bind()
        viewModel.fetchTwitts()
    }
}

// MARK: Private methods
private extension TwittsListController {
    func setupViews() {
        setupSearchController()
        navigationItem.title = Constants.StringLabels.twittsListLabel
        view.backgroundColor = .systemGray6
        // add tableview
        view.addSubview(tableView)
        tableView.snp.makeConstraints { snp in
            snp.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            snp.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            snp.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            snp.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }

    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.StringLabels.twittSearchLabel
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func bind() {
        viewModel.$twitts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] twitts in
                self?.updateTwitts(animated: false, twitts: twitts)
            }.store(in: &anyCancel)
    }

    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, twitt -> UITableViewCell? in
            if let cell = tableView.dequeueReusableCell(withIdentifier: TwittsListCell.reuseIdentifier, for: indexPath) as? TwittsListCell {
                cell.resetCell()
                cell.setCellData(twitt: twitt)
                return cell
            }
            return TwittsListCell()
        })
    }

    func updateTwitts(animated: Bool, twitts: [TwittResponse]) {
        var snapshot = NSDiffableDataSourceSnapshot<TwittsListSection, TwittResponse>()
        snapshot.appendSections([.main])
        snapshot.appendItems(twitts, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: UISearchResultsUpdating
extension TwittsListController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      viewModel.updateSearchValue(value: searchController.searchBar.text)
  }
}

// MARK: TableView Delegates
extension TwittsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel.twitts[safe: indexPath.item] {
            let controller = TwittDetailsController(viewModel: TwittDetailsViewModel(twitt: model))
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
