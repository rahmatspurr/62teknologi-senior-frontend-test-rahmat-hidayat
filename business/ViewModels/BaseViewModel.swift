//
//  BaseViewModel.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import Foundation

protocol BaseViewModel {
    var isLoading: Observer<Bool> { get set }
    var error: Observer<ErrorType> { get set }
    
    func fetchData()
}
