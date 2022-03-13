//
//  TwittDetailsViewModel.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Foundation
import Combine

class TwittDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var twitt: TwittResponse
    // MARK: - Methods
    init(twitt: TwittResponse) {
        self.twitt = twitt
    }
}
