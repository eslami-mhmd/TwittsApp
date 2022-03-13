//
//  TwittsListViewModel.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
//

import Foundation
import Combine

class TwittsListViewModel: ObservableObject {
    // MARK: - Properties
    let twittsRepository: TwittsRepositoryProtocol
    @Published var twitts: [TwittResponse] = []
    @Published var searchedValue: String?
    var anyCancel: Set<AnyCancellable> = []
    // MARK: - Methods
    init(twittsRepository: TwittsRepositoryProtocol) {
        self.twittsRepository = twittsRepository
        bindSearchText()
    }

    func fetchTwitts() {
        twittsRepository.twittPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] twitt in
                guard let strongSelf = self else {
                    return
                }
                if let twitt = twitt {
                    var twitts = strongSelf.twitts
                    twitts.append(twitt)
                    twitts.sort(by: {
                        if let data0 = $0.data, let data1 = $1.data {
                            return data0.identifier > data1.identifier
                        } else {
                            return true
                        }
                    })
                    strongSelf.twitts = twitts
                }
            }.store(in: &anyCancel)

        Task {
            try await twittsRepository.fetchTwitts()
        }
    }

    func updateSearchValue(value: String?) {
        searchedValue = value
    }

    private func bindSearchText() {
        $searchedValue
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                guard let strongSelf = self, let text = value else { return }
                if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                    strongSelf.updateRule(ruleText: text)
                }
            })
            .store(in: &anyCancel)
    }

    private func updateRule(ruleText: String) {
        Task {
            try await twittsRepository.updateRule(ruleText: ruleText)
        }
    }
}
