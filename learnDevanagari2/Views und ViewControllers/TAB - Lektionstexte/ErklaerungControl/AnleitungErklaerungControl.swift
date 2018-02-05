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
    //MARK: MutableProperties
    fileprivate var lektionsText : MutableProperty<LektionsText>
    fileprivate var currentPage                 = MutableProperty(0)
    fileprivate var numberOfVisibleViews        = MutableProperty(0)
    fileprivate var buttonsAreHidden            = MutableProperty(true)
    fileprivate var rightButtonIsEnabled        = MutableProperty(true)
    fileprivate var leftButtonIsEnabled         = MutableProperty(true)
    
    //MARK: - init
    init(lektionsText:MutableProperty<LektionsText>){
        self.lektionsText = lektionsText
        numberOfVisibleViews    <~ lektionsText.producer.map            {$0.anzahlErklaerungsSeiten}
        currentPage             <~ lektionsText.producer.map            {_ in 0}
        buttonsAreHidden        <~ numberOfVisibleViews.producer.map    {$0 == 1}
        leftButtonIsEnabled     <~ currentPage.producer.map             {$0 != 0}
        rightButtonIsEnabled    <~ currentPage.producer.map             {[weak self] current in (self?.numberOfVisibleViews.value ?? 0) - 1 != current }
    }
    
    //MARK: - Methode
    fileprivate func setCurrentPage(dif:Int)    { currentPage.value += dif }
    
    //MARK: - ViewModels
    fileprivate func getViewModelForAnleitungErklaerungContent() -> AnleitungErklaerungContentViewModel { return AnleitungErklaerungContentViewModel(lektionsText: lektionsText) }
}
class AnleitungErklaerungControl: NibLoadingView,UIScrollViewDelegate {
    var contentView = AnleitungErklaerungContentView()
    var viewModel:AnleitungErklaerungControlViewModel!{
        didSet{
            contentView.viewModel = viewModel.getViewModelForAnleitungErklaerungContent()
            scrollView.addSubview(contentView)
            
            //Signals
            leftButton.reactive.isEnabled       <~ viewModel.leftButtonIsEnabled
            rightButton.reactive.isEnabled      <~ viewModel.rightButtonIsEnabled
            leftButton.reactive.controlEvents(.touchUpInside).producer.start()      { [weak self] _ in self?.viewModel.setCurrentPage(dif: -1 ) }
            rightButton.reactive.controlEvents(.touchUpInside).producer.start()     { [weak self] _ in self?.viewModel.setCurrentPage(dif: +1 ) }
            viewModel.currentPage.producer.startWithValues                          { [weak self] page in  self?.setPage(page: page) }
            viewModel.numberOfVisibleViews.producer.startWithValues                 { [weak self] numberOfViews in self?.set(numberOfViews: numberOfViews) }
            viewModel.buttonsAreHidden.producer.startWithValues                     { [weak self] isHidden in self?.setButtons(isHidden: isHidden) }
        }
    }
    
    //MARK: - ScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth               = scrollView.contentOffset.x * CGFloat(viewModel.numberOfVisibleViews.value) / contentView.frame.size.width
        viewModel.currentPage.value = Int(pageWidth)
    }
    
    //MARK: - IBOutlets
    @IBOutlet private weak var pageControl: UIPageControl!  {didSet{pageControl.isEnabled = false}}
    @IBOutlet private weak var scrollView: UIScrollView!    {didSet{scrollView.delegate = self}}
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    //MARK: - layoutSubviews
    var lastScrollviewViewSize:CGSize?
    override func layoutSubviews() {
        if lastScrollviewViewSize != scrollView.bounds.size { setScrollViewSize(numberOfVisibleViews: viewModel.numberOfVisibleViews.value) }
        lastScrollviewViewSize = scrollView.bounds.size
    }
    
    //MARK - helper
    private func setButtons(isHidden:Bool){
        leftButton.isHidden         = isHidden
        rightButton.isHidden        = isHidden
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        setScrollViewSize(numberOfVisibleViews: viewModel.currentPage.value)
    }
    private func set(numberOfViews:Int){
        pageControl.numberOfPages = numberOfViews
        pageControl.isHidden      = numberOfViews == 1
        setScrollViewSize(numberOfVisibleViews: numberOfViews)
    }
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
    private func setPage(page:Int){
        scrollView.contentOffset.x = contentView.frame.size.width / CGFloat(viewModel.numberOfVisibleViews.value) * CGFloat(page)
        pageControl.currentPage = page
    }
}
