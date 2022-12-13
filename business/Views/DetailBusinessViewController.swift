//
//  DetailBusinessViewController.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import UIKit
import SkeletonView

class DetailBusinessViewController: BaseUIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var vm: DetailBusinessViewModel
    private var timer:Timer?
    
    init(vm: DetailBusinessViewModel) {
        self.vm = vm
        super.init(nibName: R.nib.detailBusinessViewController.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObserver()
        self.vm.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer?.invalidate()
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationItem.title = "Detail Business"
        self.setupCollectionView()
        self.setupTableView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
        self.collectionView.register(R.nib.slideshowCollectionViewCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = 72
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(R.nib.reviewTableViewCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupObserver() {
        self.vm.isLoading.bind { [weak self] loading in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                if loading {
                    ws.view.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.5))
                }else{
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
        
        self.vm.businessDetails.bind { [weak self] business in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                
                ws.loadSlideShow()
                ws.nameLabel.text = business.name
                ws.ratingLabel.text = "\(business.rating ?? 0)"
                ws.reviewsLabel.text = "from \(business.reviewCount ?? 0) Reviews"
                
                let address = business.location?.displayAddress?.joined(separator: ", ")
                ws.addressLabel.text = address
            }
        }
        
        self.vm.reviewsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let ws = self else { return }
                ws.tableView.reloadData()
                ws.view.layoutIfNeeded()
            }
        }
    }
    
    private func loadSlideShow() {
        self.collectionView.reloadData()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(self.autoScrollSlideShow), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: .common)
        
        guard let photos = self.vm.businessDetails.value.photos else { return }
        self.pageControll.numberOfPages = photos.count
    }
    
    @objc func autoScrollSlideShow() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                guard let photos = self.vm.businessDetails.value.photos else { return }
                
                let firstIndex = 0
                let lastIndex = photos.count - 1

                let visibleIndices = self.collectionView.indexPathsForVisibleItems
                let nextIndex = visibleIndices[0].row + 1

                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)
                if nextIndex > lastIndex {
                    self.collectionView.scrollToItem(at: firstIndexPath,
                                                     at: .centeredHorizontally,
                                                     animated: true)
                }else{
                    self.collectionView.scrollToItem(at: nextIndexPath,
                                                     at: .centeredHorizontally,
                                                     animated: true)
                }
            }
        }
    }


    @IBAction func didTapSeeOnGMapsButton(_ sender: Any) {
        guard let latitude = self.vm.businessDetails.value.coordinates?.latitude,
              let longitude = self.vm.businessDetails.value.coordinates?.longitude else {
            return
        }
        
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
        }
    }
    
}

//MARK: -UICollectionViewDelegate
extension DetailBusinessViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.businessDetails.value.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.slideshowCollectionViewCell, for: indexPath) {
            
            let photo = self.vm.businessDetails.value.photos?[indexPath.row]
            cell.setupCell(photo)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = 160.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.pageControll.currentPage == indexPath.row {
            guard let visible = collectionView.visibleCells.first else { return }
            guard let index = collectionView.indexPath(for: visible)?.row else { return }
            self.pageControll.currentPage = index
        }
    }
}

//MARK: -UITableViewDelegate
extension DetailBusinessViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.reviewsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reviewTableViewCell, for: indexPath) {
            
            let review = self.vm.reviewsList.value[indexPath.row]
            cell.setupCell(review)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: -Loading Skeleton
extension DetailBusinessViewController: SkeletonCollectionViewDataSource, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return R.nib.slideshowCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.isLoading.value ? 1 : self.vm.businessDetails.value.photos?.count ?? 0
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return R.nib.reviewTableViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.isLoading.value ? 8 : self.vm.reviewsList.value.count
    }
}
