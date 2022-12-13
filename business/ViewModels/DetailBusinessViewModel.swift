//
//  DetailBusinessViewModel.swift
//  business
//
//  Created by Rahmat Hidayat on 12/12/22.
//

import Foundation

class DetailBusinessViewModel: BaseViewModel {
    var isLoading = Observer<Bool>(false)
    var error = Observer<ErrorType>(.noConnection)
    var businessDetails = Observer<Businesses>(Businesses())
    var reviewsList = Observer<[Review]>([Review]())
    
    private var businessId: String?
    private let limit = 10
    private var offset = 0
    private var totalData = 0
    private let dispatchGroup = DispatchGroup()
    
    init(businessId: String?) {
        self.businessId = businessId
    }
    
    func fetchData() {
        self.fetchBusinessDetail()
        self.fetchListReviews()
        
        self.isLoading.value = true
        self.dispatchGroup.notify(queue: .main) { [unowned self] in
            self.isLoading.value = false
        }
    }
    
    private func fetchBusinessDetail() {
        guard let businessId = self.businessId else {return}
        self.dispatchGroup.enter()
        
        AppNetworking.request(of: Businesses.self, endpoint: .businessDetail(id: businessId)) { result in
            switch result {
            case .success(let data):
                self.businessDetails.value = data
            case .failure(let error):
                self.error.value = error
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func fetchListReviews() {
        guard let businessId = self.businessId else {return}
        self.dispatchGroup.enter()
        
        //Notes: API always return 3 datas, limit & offset doesn't effected.
        //Please check at https://docs.developer.yelp.com/reference/v3_business_reviews
        let params: [String:Any] = [
            "limit": self.limit,
            "offset": self.offset
        ]
        
        AppNetworking.request(of: PaginationReviews.self, endpoint: .reviews(id: businessId, params: params)) { result in
            switch result {
            case .success(let data):
                self.totalData = data.total
                if self.offset > 0 {
                    var reviews = self.reviewsList.value
                    reviews.append(contentsOf: data.reviews)
                    self.reviewsList.value = reviews
                }else{
                    self.reviewsList.value = data.reviews
                }
            case .failure(let error):
                self.error.value = error
            }
            self.dispatchGroup.leave()
        }
    }
    
    func loadMoreReviews() {
        if self.offset < self.totalData {
            self.offset += self.limit
            self.fetchListReviews()
        }
    }
    
}
