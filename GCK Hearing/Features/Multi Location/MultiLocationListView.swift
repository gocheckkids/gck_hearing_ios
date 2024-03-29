//
//  MultiLocationListView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/8/24.
//

import SwiftUI

struct MultiLocationListView: View {
    @ObservedObject var locationVM: MultiLocationViewModel
    var body: some View {
        NavigationView {
            VStack {
                //                SearchBarView(searchText: $vm.searchText, placeholderText: "Search for a patient ...")
                //                Spacer()
                //                .padding(.bottom, 20)
                List {
                    switch locationVM.loadState {
                    case .loading:
                        LocationListLoadingView()
                    case .success:
                        LocationListLoadedView(locationList: locationVM.allLocaions) {
                            locationVM.locationTappedAction?()
                        }
                        
                    case .failed:
                        LocationListErrorView()
                    }
                }
                .listStyle(.plain)
            }
            
            .navigationTitle("Select Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Menu", color: Color.deepBlueTheme.accent, action: {})
                }
            }
        }
        .onAppear {
            Task {
                await locationVM.loadLocations()
            }
        }
        .searchable(text: $locationVM.searchText, prompt: "Find location by name")
    }
}

extension MultiLocationListView {
    struct LocationListLoadingView: View {
        var body: some View {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct LocationListLoadedView: View {
        let locationList: [String]
        var tapAction: (() -> ())? = {}
     
        var body: some View {
            Section {
                ForEach(locationList, id: \.self) { location in
                    HStack {
                        Text(location)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color.blueTheme.accentDark)
                    }
                    .padding()
                    .onTapGesture {
                        // Coordinate to patientView for that clinic
                        tapAction?()
                        
                }
                        
                }
                
                .listRowInsets(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
//                .listRowSeparator(.hidden, edges: .all)
            }
        }
    }
    
    struct LocationListErrorView: View {
        var body: some View {
            Text("Error fetching data!")
        }
    }
}

struct LocationListPreview: PreviewProvider {

     static var previews: some View {
         MultiLocationListView(locationVM: MultiLocationViewModel(loader: LocalLocationListLoader()))
            .previewLayout(.sizeThatFits)
    }
}
