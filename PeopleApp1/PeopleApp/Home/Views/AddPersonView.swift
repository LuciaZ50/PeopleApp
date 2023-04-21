//
//  AddPersonView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 19.12.2022..
//

import SwiftUI

struct AddPersonView<T: HomeViewModel>: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @ObservedObject private var viewModel: T
    let successfulAction: () -> Void
    
    init(viewModel: T, successfulAction: @escaping () -> Void) {
        self.viewModel = viewModel
        self.successfulAction = successfulAction
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    firstName
                    lastName
                    job
                } footer: {
                    if case .validation(let error) = viewModel.error,
                       let errorDescription = error.errorDescription {
                        Text(errorDescription)
                            .foregroundColor(.red)
                    }
                }
                Section {
                    submit
                }
            }
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .overlay {
                if viewModel.state == .submitting {
                    ProgressView()
                }
            }
            .onChange(of: viewModel.state, perform: { state in
                if state == .successful {
                    dismiss()
                    successfulAction()
                }
            })
            .alert(isPresented: $viewModel.isError, error: viewModel.error) {
                Button("OK") { }
            }
        }
    }
}


extension AddPersonView {
    
    var firstName: some View {
        TextField("First name", text: $viewModel.newPerson.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastName: some View {
        TextField("Last name", text: $viewModel.newPerson.lastname)
            .focused($focusedField, equals: .lastName)
    }
    
    var job: some View {
        TextField("Job", text: $viewModel.newPerson.job)
            .focused($focusedField, equals: .job)
    }
    var submit: some View {
        Button("Submit") {
            Task {
                focusedField = nil
                try await viewModel.post(newPerson: viewModel.newPerson)
            }
        }
    }
    var done: some View {
        Button {
            dismiss()
        } label: {
            Text("Done")
        }
        .disabled(viewModel.state == .submitting)
    }
    
}

//struct AddPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonView(viewModel: HomeViewModel(service: Service()))
//    }
//}
