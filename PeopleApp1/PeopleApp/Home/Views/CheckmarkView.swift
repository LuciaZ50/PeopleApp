//
//  CheckmarkView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 19.12.2022..
//

import SwiftUI

struct CheckmarkView: View {
    var body: some View {
        Image(systemName: "checkmark")
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView()
    }
}
