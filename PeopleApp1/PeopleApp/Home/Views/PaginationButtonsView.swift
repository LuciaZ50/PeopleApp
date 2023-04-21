//
//  PaginationButtonsView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 21.12.2022..
//

import Foundation
import SwiftUI

struct PaginationButtons<T: HomeViewModel>: View {
    
    @ObservedObject private var viewModel: T

    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            Button {
                Task {
                    try await viewModel.getPeople(atPage: "1")
                }
            } label: {
                Text("1")
                    .foregroundColor(.blue)
            }
            Button {
                Task {
                    try await viewModel.getPeople(atPage: "2")
                }
            } label: {
                Text("2")
                    .foregroundColor(.blue)
            }
        }
    }
}
