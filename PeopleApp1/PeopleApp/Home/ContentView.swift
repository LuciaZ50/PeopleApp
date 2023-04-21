//
//  ContentView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import SwiftUI

struct HomeView<T: HomeViewModel>: View {
    @ObservedObject private var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var column = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(viewModel.people ?? [], id: \.id) {
                        person in
                        NavigationLink(destination: DetailsView(person: person), label: {
                            PersonView(imgName: person.avatar, personName: person.first_name, id: person.id)
                        })
                    }
                    
                    .navigationTitle("People")
                }
            }
        }
        .task {
            await viewModel.getPeople()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(service: Service()))
    }
}

struct PersonView: View {
    
    var imgName: String
    var personName: String
    var id: Int
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imgName)) { image in
            image
                .resizable()
                .scaledToFit()
            } placeholder: {
            Color.gray
            }.frame(width: 100, height: 100)
            Text("#" + String(id))
                .foregroundColor(.white)
                .frame(width: 50, height: 20)
                .background(.purple)
                .cornerRadius(10)
            Text(personName)
                .padding(.bottom, 20)
        }
    }
}
    
