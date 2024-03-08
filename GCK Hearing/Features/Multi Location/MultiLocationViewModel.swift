//
//  MultiLocationViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/8/24.
//

import Foundation

class MultiLocationViewModel: ObservableObject {
    
    enum LocationListLoadingState {
        case loading, success, failed
    }
    
    @Published var loadState = LocationListLoadingState.loading
    @Published var allLocaions: [String] = []
    @Published var searchText = ""
    
    var locationListLoader: LocationListLoader
    
    init(loader: LocationListLoader) {
        self.locationListLoader = loader

    }
    
    func loadLocations() async {
        loadState = .loading
        await allLocaions = locationListLoader.getLocations()
        loadState = .success
    }
}
