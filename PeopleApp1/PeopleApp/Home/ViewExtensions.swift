//
//  HomeExtensions.swift
//  PeopleApp
//
//  Created by LuciaDecode on 20.12.2022..
//

import Foundation
import SwiftUI

extension HomeView {
    var background: some View {
            Theme.background
        }
}


extension AddPersonView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
    
}
