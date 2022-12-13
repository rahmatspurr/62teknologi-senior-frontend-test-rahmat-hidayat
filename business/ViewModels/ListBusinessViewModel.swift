//
//  ListBusinessViewModel.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import Foundation

class ListBusinessViewModel: BaseViewModel {
    
    var isLoading = Observer<Bool>(false)
    var error = Observer<ErrorType>(.noConnection)
    var businessesList = Observer<[Businesses]>([Businesses]())
    
    private let limit = 10
    private var offset = 0
    private var totalData = 0
    private var searchTerm: String?
    private var openNow: Bool?
    
    func fetchData() {
        if self.offset == 0 {
            self.isLoading.value = true
        }
        
        var params: [String:Any] = [
            "location": "NYC", ///Since API only have data around New York, so hardcoded than.
            "limit": self.limit,
            "offset": self.offset
        ]
        if let term = self.searchTerm {
            params["term"] = term
        }
        if let openNow = self.openNow {
            params["open_now"] = openNow
        }
        
        AppNetworking.request(of: PaginationBusinesses.self, endpoint: .search(params: params)) { result in
            switch result {
            case .success(let data):
                self.totalData = data.total
                if self.offset > 0 {
                    var businesses = self.businessesList.value
                    businesses.append(contentsOf: data.businesses)
                    self.businessesList.value = businesses
                }else{
                    self.businessesList.value = data.businesses
                }
            case .failure(let error):
                self.error.value = error
            }
            
            if self.offset == 0 {
                self.isLoading.value = false
            }
        }
    }
    
    func refreshData() {
        self.offset = 0
        self.fetchData()
    }
    
    func loadMore() {
        if self.offset < self.totalData {
            self.offset += self.limit
            self.fetchData()
        }
    }
    
    func searchTerm(_ value: String?) {
        self.searchTerm = value
        self.refreshData()
    }
    
    func filter(open: Bool?) {
        self.openNow = open
        self.refreshData()
    }
    
    func detailBusiness(at index: IndexPath) -> DetailBusinessViewModel {
        let businessId = self.businessesList.value[index.row].id
        return DetailBusinessViewModel(businessId: businessId)
    }
}
