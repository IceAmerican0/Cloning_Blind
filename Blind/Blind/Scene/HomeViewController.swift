//
//  HomeViewController.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import FlexLayout
import PinLayout
import Then
import RxSwift
import RxGesture
import RxCocoa

private enum Tab: String, CaseIterable {
    case home = "홈"
    case trending = "인기"
    
    var viewController: UIViewController {
        switch self {
        case .home: return ViewPagerHomeViewController()
        case .trending: return ViewPagerTrendViewController()
        }
    }
}

final class HomeViewController: BaseViewController<EmptyViewModel> {
    
    private var mainView = UIView()
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 50)
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
    ).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(withType: TopViewPagerCollectionViewCell.self)
    }
    
    lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    ).then {
        $0.delegate = self
        $0.dataSource = self
    }
    
    var viewPagerTitle = Tab.allCases.map { $0.rawValue }
    var viewPagerVC = Tab.allCases.map { $0.viewController }
    
    var currentPage: Int = 0 {
        didSet {
            pageSetting(oldValue, currentPage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentPage = 0
    }

    override func layout() {
        super.layout()
        view.backgroundColor = .white
        addChild(pageViewController)
        container.flex.define {
            $0.addItem(collectionView).width(UIScreen.main.bounds.width).height(50)
            $0.addItem(pageViewController.view).grow(1)
        }
        pageViewController.didMove(toParent: self)
    }
    
    private func pageSetting(_ oldValue: Int, _ clicked: Int) {
        let direction: UIPageViewController.NavigationDirection = oldValue < clicked ? .forward : .reverse
        pageViewController.setViewControllers([viewPagerVC[currentPage]],
                                              direction: direction,
                                              animated: true)
        
        collectionView.selectItem(at: IndexPath(item: currentPage, section: 0),
                                  animated: true,
                                  scrollPosition: .centeredHorizontally)
    }
}

// MARK: UICollectionViewDelegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewPagerVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: TopViewPagerCollectionViewCell.self, for: indexPath)
        cell.titleLabel.text = viewPagerTitle[indexPath.item]
        
        cell.contentView.rx.tapGesture(configuration: .none)
            .when(.recognized)
            .asDriver { _ in .never() }
            .drive(
                with: self,
                onNext : { owner, _ in
                    owner.currentPage = indexPath.item
                }
            )
            .disposed(by: cell.bag)
        
        return cell
    }
}

// MARK: UIPageViewControllerDelegate & DataSource
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewPagerVC.firstIndex(of: viewController) else { return nil }
        let previous = index - 1
        if previous < 0 {
            return viewPagerVC[1]
        }
        return viewPagerVC[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewPagerVC.firstIndex(of: viewController) else { return nil }
        let next = index + 1
        if next == viewPagerVC.count {
            return viewPagerVC[0]
        }
        return viewPagerVC[next]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let current = pageViewController.viewControllers?.first,
              let index = viewPagerVC.firstIndex(of: current) else { return }
        currentPage = index
    }
    
}
