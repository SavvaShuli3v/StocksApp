//
//  StockViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 10.10.2021.
//

import UIKit

final class StockViewController: UIViewController {
    
    private lazy var stockNavBar = UIStockBar()
    private let collectionView: UICollectionView
    
    // MARK: - Init
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        textBack()
    }
    
    // MARK: - Private Methods
    
    private func textBack() {
        self.stockNavBar.backButton.setAction {
            self.dismiss(animated: false, completion: nil)
        }
    }

}

// MARK: - UICollectionViewDataSource

extension StockViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PriceStockCell
        cell.setForColor(ind: indexPath.row)
        return cell
    }
    

}

// MARK: - UICollectionViewDelegateFlowLayout

extension StockViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - setupCollectionView

private extension StockViewController {
    func setupUI() {
        self.view.backgroundColor = Styles.Colors.white
        setupNavBar()
        setupCollectionView()
    }
    
    func setupNavBar() {
        self.view.addSubview(stockNavBar)
        self.stockNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.stockNavBar.top(0, to: self.view.safeAreaLayoutGuide.topAnchor)
        self.stockNavBar.leading()
        self.stockNavBar.trailing()
        self.stockNavBar.height(120)
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.top(0, to: self.stockNavBar.bottomAnchor)
        self.collectionView.leading()
        self.collectionView.trailing()
        self.collectionView.bottom()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PriceStockCell.self, forCellWithReuseIdentifier: "collectionCell")
        self.collectionView.backgroundColor = Styles.Colors.white
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}
