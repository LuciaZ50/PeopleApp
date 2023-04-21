//
//  DetailImage.swift
//  PeopleApp
//
//  Created by LuciaDecode on 23.12.2022..
//

import Foundation
import SwiftUI

struct DetailImage: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 200)
        } placeholder: {
            Color.gray
                .frame(width: 350, height: 200)
        }

    }
}
