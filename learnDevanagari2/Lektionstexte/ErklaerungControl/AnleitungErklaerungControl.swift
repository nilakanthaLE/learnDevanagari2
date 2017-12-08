//
//  AnleitungErklaerungControl.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 28.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift


class AnleitungErklaerungControlViewModel{
    var currentPage = MutableProperty(0)
    fileprivate var lektionsText : MutableProperty<LektionsText>
    fileprivate var numberOfVisibleViews        = MutableProperty(0)
    fileprivate var buttonsAreHidden            = MutableProperty(true)
    fileprivate var rightButtonIsEnabled        = MutableProperty(true)
    fileprivate var leftButtonIsEnabled         = MutableProperty(true)
    
    init(lektionsText:MutableProperty<LektionsText>){
        self.lektionsText = lektionsText
        numberOfVisibleViews <~ lektionsText.producer.map{$0.anzahlErklaerungsSeiten}
        
        buttonsAreHidden        <~ numberOfVisibleViews.producer.map{$0 == 1}
        leftButtonIsEnabled     <~ currentPage.producer.map{$0 != 0}
        rightButtonIsEnabled    <~ currentPage.producer.map{[weak self] current in (self?.numberOfVisibleViews.value ?? 0) - 1 != current }
        currentPage             <~ lektionsText.producer.map{_ in 0}
        
    }
    fileprivate func getViewModelForAnleitungErklaerungContent() -> AnleitungErklaerungContentViewModel { return AnleitungErklaerungContentViewModel(lektionsText: lektionsText) }
    
    //helper
    fileprivate func setCurrentPage(dif:Int)                                                            { currentPage.value += dif }
}
class AnleitungErklaerungControl: NibLoadingView,UIScrollViewDelegate {
    var contentView = AnleitungErklaerungContentView()
    var viewModel:AnleitungErklaerungControlViewModel!{
        didSet{
            contentView.viewModel = viewModel.getViewModelForAnleitungErklaerungContent()
            scrollView.addSubview(contentView)
            
            viewModel.numberOfVisibleViews.producer.startWithValues{ [weak self] numberOfViews in
                self?.setScrollViewSize(numberOfVisibleViews: numberOfViews)
                self?.pageControl.numberOfPages = numberOfViews
                self?.pageControl.isHidden      = numberOfViews == 1
            }
            
            viewModel.buttonsAreHidden.producer.startWithValues { [weak self] isHidden in
                self?.leftButton.isHidden       = isHidden
                self?.rightButton.isHidden      = isHidden
                self?.setNeedsLayout()
                self?.layoutIfNeeded()
                self?.setScrollViewSize(numberOfVisibleViews: self?.viewModel.currentPage.value ?? 0)
            }
            leftButton.reactive.isEnabled       <~ viewModel.leftButtonIsEnabled
            rightButton.reactive.isEnabled      <~ viewModel.rightButtonIsEnabled
            
            leftButton.reactive.controlEvents(.touchUpInside).producer.start(){[weak self] _ in self?.viewModel.setCurrentPage(dif: -1 ) }
            rightButton.reactive.controlEvents(.touchUpInside).producer.start(){[weak self] _ in self?.viewModel.setCurrentPage(dif: +1 ) }
            
            viewModel.currentPage.producer.startWithValues {[weak self] page in
                self?.setPage(page: page)
                self?.pageControl.currentPage = page
            }
            
            
        }
    }
    
    @IBOutlet private weak var pageControl: UIPageControl!  {didSet{pageControl.isEnabled = false}}
    @IBOutlet private weak var scrollView: UIScrollView!    {didSet{scrollView.delegate = self}}
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    private func setScrollViewSize(numberOfVisibleViews: Int){
        func getSize(numberOfVisibleViews:Int) -> CGSize{
            let width   = CGFloat(numberOfVisibleViews) * scrollView.bounds.size.width
            let height  = scrollView.bounds.size.height
            return CGSize(width: width, height: height)
        }
        contentView.frame       = CGRect(origin: CGPoint.zero,size: getSize(numberOfVisibleViews: numberOfVisibleViews))
        scrollView.contentSize  = contentView.frame.size
        setPage(page: viewModel.currentPage.value)
    }
    
    private func setPage(page:Int){ scrollView.contentOffset.x = contentView.frame.size.width / CGFloat(viewModel.numberOfVisibleViews.value) * CGFloat(page) }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x * CGFloat(viewModel.numberOfVisibleViews.value) / contentView.frame.size.width
        viewModel.currentPage.value = Int(page)
    }
    
    var lastScrollviewViewSize:CGSize?
    override func layoutSubviews() {
        if lastScrollviewViewSize != scrollView.bounds.size { setScrollViewSize(numberOfVisibleViews: viewModel.numberOfVisibleViews.value) }
        lastScrollviewViewSize = scrollView.bounds.size
    }
}
