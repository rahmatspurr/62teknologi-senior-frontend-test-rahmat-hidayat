//
//  ListBusinessViewController.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import UIKit
import SkeletonView

class ListBusinessViewController: BaseUIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let vm = ListBusinessViewModel()
    private var searchTask: DispatchWorkItem?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObserver()
        self.vm.fetchData()
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationItem.title = "Business"
        self.searchBar.delegate = self
        self.setupTableView()
        self.setupFilter()
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = 99
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(resource: R.nib.businessTableViewCell),
                                forCellReuseIdentifier: R.reuseIdentifier.businessTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }
    
    private func setupFilter() {
        let filterBarButtonItem = UIBarButtonItem(title: "Filter",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(self.didTapFilterBarButton))
        self.navigationItem.rightBarButtonItem  = filterBarButtonItem
    }
    
    @objc private func didTapFilterBarButton() {
        let alert = UIAlertController(title: "Filter",
                                      message: "Please Select an Option",
                                      preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Open Now",
                                      style: .default,
                                      handler:{ (UIAlertAction)in
            self.vm.filter(open: true)
        }))
        alert.addAction(UIAlertAction(title: "Closed",
                                      style: .default,
                                      handler:{ (UIAlertAction)in
            self.vm.filter(open: false)
        }))
        alert.addAction(UIAlertAction(title: "Clear Filter",
                                      style: .default,
                                      handler:{ (UIAlertAction)in
            self.vm.filter(open: nil)
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true)
    }
    
    private func setupObserver() {
        self.vm.isLoading.bind { [weak self] loading in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                if loading {
                    ws.view.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.5))
                }else{
                    ws.refreshControl.endRefreshing()
                    ws.view.hideSkeleton()
                }
            }
        }
        
        self.vm.error.bind { [weak self] errorType in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                ToastView.shared.showToast(errorType)
                ws.view.hideSkeleton()
            }
        }
        
        self.vm.businessesList.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                ws.tableView.reloadData()
            }
        }
    }
    
    @objc private func refreshData() {
        self.vm.refreshData()
    }
}

//MARK: -UITableViewDelegate
extension ListBusinessViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.businessesList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.businessTableViewCell, for: indexPath) {
            
            let business = self.vm.businessesList.value[indexPath.row]
            cell.setupCell(business)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.vm.businessesList.value.count - 1) {
            self.vm.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailBusinessVM = self.vm.detailBusiness(at: indexPath)
        let vc = DetailBusinessViewController(vm: detailBusinessVM)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -UISearchBarDelegate
extension ListBusinessViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            guard let ws = self else {return}
            ws.vm.searchTerm(searchText)
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = nil
        self.vm.searchTerm(nil)
        self.view.endEditing(true)
    }
}

//MARK: -Loading Skeleton
extension ListBusinessViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return R.nib.businessTableViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.isLoading.value ? 8 : self.vm.businessesList.value.count
    }
}
