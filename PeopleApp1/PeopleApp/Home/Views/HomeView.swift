//
//  ContentView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import SwiftUI

struct HomeView<T: HomeViewModel>: View {
    @ObservedObject private var viewModel: T
    @State private var createSheet = false
    @State private var shouldShowSuccess = false
    @State private var hasAppeared = false
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var column = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: column) {
                            ForEach(viewModel.people ?? [], id: \.id) {
                                person in
                                NavigationLink(destination: DetailsView(person: person), label: {
                                    PersonView(imgName: person.avatar, personName: person.first_name, id: person.id)
                                        .padding(.top, 10)
                                })
                            }
                        }
                        PaginationButtons(viewModel: viewModel)

                    }
                    .navigationTitle("People")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                createSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(.headline, design: .rounded)
                                        .bold()
                                    )
                            }
                            .disabled(viewModel.isLoading)
                            
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                Task {
                                    try await viewModel.getPeople(atPage: "1")
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(.headline, design: .rounded)
                                        .bold()
                            )}
                                .disabled(viewModel.isLoading)
                        }
                    }
                    .sheet(isPresented: $createSheet) {
                        AddPersonView(viewModel: viewModel) {
                            haptic(.success)
                            withAnimation(.spring().delay(0.5)) {
                                self.shouldShowSuccess.toggle()
                            }
                        }
                    }
                    .alert(isPresented: $viewModel.isError, error: viewModel.error) {
                        Button("Retry") {
                            Task {
                                try await viewModel.getPeople(atPage: "1")
                            }
                        }
                    }
                    .overlay {
                        if shouldShowSuccess {
                            CheckmarkView()
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation(.spring()) {
                                            self.shouldShowSuccess.toggle()
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
            .task {
                if !hasAppeared {
                    try? await viewModel.getPeople(atPage: "1")
                    hasAppeared = true
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(service: Service()))
    }
}



enum Theme {
    static let background = Color(.white)
    static let detailBackground = Color(.white)
    static let text = Color(.systemGray)
    static let pill = Color("pill")
}
