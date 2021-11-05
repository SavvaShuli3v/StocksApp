//
//  StockViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 10.10.2021.
//

import UIKit

final class StockViewController: UIViewController {
    
    var presenter: StockViewPresenterProtocol!
    var preparedStock: PreparedStock?
    
    private lazy var stockNavBar = UIStockBar()
    private let collectionView: UICollectionView
    
    // MARK: - Init
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        }
        
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setStock()
        
        setupUI()
        setupBackButton()
    }

    // MARK: - Private Methods
    
    private func setupBackButton() {
        self.stockNavBar.backButton.setAction { [weak self] in
            self?.presenter.tapToBack()
        }
    }

}

// MARK: - Presenter Binding

extension StockViewController: StockViewProtocol {
    
    func setStock(_ stock: PreparedStock?) {
        self.preparedStock = stock
        
        self.stockNavBar.ticker.text = stock?.symbol
        self.stockNavBar.companyName.text = stock?.companyName
    }
}

// MARK: - UICollectionViewDataSource

extension StockViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellID.chart, for: indexPath) as! ChartStockCell
            cell.setStock(price: preparedStock?.preparedPrice, changePrice: preparedStock?.preparedChangePrice, isUp: preparedStock?.isUp)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellID.summary, for: indexPath) as! SummaryStockCell
            cell.setSummary(preparedStock?.description)
            cell.setInfo(country: preparedStock?.country, branch: preparedStock?.sector, industry: preparedStock?.industry, div: presenter.setDivAnswer())
            return cell
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    
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
        setupCollectionView()
        setupNavBar()
    }
    
    func setupNavBar() {
        self.view.addSubview(stockNavBar)
        self.stockNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.stockNavBar.top(0, to: view.safeAreaLayoutGuide.topAnchor)
        self.stockNavBar.leading()
        self.stockNavBar.trailing()
        self.stockNavBar.height(120)
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.top(120, to: view.safeAreaLayoutGuide.topAnchor)
        self.collectionView.leading()
        self.collectionView.trailing()
        self.collectionView.bottom()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ChartStockCell.self, forCellWithReuseIdentifier: CollectionCellID.chart)
        self.collectionView.register(SummaryStockCell.self, forCellWithReuseIdentifier: CollectionCellID.summary)
        self.collectionView.backgroundColor = Styles.Colors.white
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}

private enum CollectionCellID {
    static let chart = "Chart"
    static let summary = "Summary"
    static let news = "News"
    static let forecasts = "Forecasts"
    static let idea = "Ideas"
}
