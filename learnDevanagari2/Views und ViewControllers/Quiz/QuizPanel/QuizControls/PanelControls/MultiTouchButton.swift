//
//  MultiTouchButton.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 23.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: Multitouchbutton
// ein Control mit einer bestimmten Anzahl von Reihen
// m darin enthaltener Anzahl von Buttons
class MultiTouchButtonViewModel:PanelControlViewModel{
    var titleArray: [[String]]
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        self.titleArray         =  controlSetting.titleArray
        super.init(controlSetting: controlSetting, quizModel: quizModel)
    }
    //MARK: helper
    // liefert Hintergrundfarbe für einen Button im MultitouchButton
    func backgroundColor(forTag tag:Int?) -> UIColor{
        let correctTag  = getTag(for: correctAnswer.value, in: titleArray)
        let selectedTag = getTag(for: userEingabe.value, in: titleArray)
        if controlCurrentModus.value == .ShowsPruefergebnis {
            if tag == correctTag                            { return colorForCorrect }
            if tag == selectedTag && tag != correctTag      { return colorForWrong }
        }
        if controlCurrentModus.value == .Anzeige {
            if tag == correctTag                            { return colorForSelected }
            if tag == selectedTag && tag != correctTag      { return colorForDefault }
        }
        if tag == selectedTag                               { return colorForSelected }
        return colorForDefault
    }
}

class MultiTouchButton: UIStackView,PanelControlProtocol {
    var viewModel:PanelControlViewModel!{
        didSet{
            axis               = .vertical
            alignment          = .fill
            distribution       = .fillEqually
            resetButtons()
            //Signal
            reactive.isHidden       <~ viewModel.isHidden
        }
    }
    private var buttons:[[ButtonInMultiTouchButton]]!
    
    //MARK: helper
    private func button(withTitle title:String,andTag tag:Int?) -> UIButton     { return ButtonInMultiTouchButton(viewModel: viewModel, title: title, andTag: tag) }
    private func createButtons(for titleArray:[[String]]) -> [[UIButton]]       { return titleArray.map { $0.map{ button(withTitle: $0, andTag: getTag(for: $0, in: titleArray)) } } }
    private func resetButtons()                                                 { addToStackView(buttons: createButtons(for: (viewModel as! MultiTouchButtonViewModel).titleArray)) }
    //stackView clean and (re)fill
    private func cleanStack(){
        for subview in self.arrangedSubviews {
            for view in subview.subviews    { view.removeFromSuperview() }
            self.removeArrangedSubview(subview)
        }
    }
    private func addToStackView(buttons:[[UIButton]]) {
        cleanStack()
        for row in buttons{
            let newStack            = UIStackView.horizontalEquallyFilled()
            addArrangedSubview(newStack)
            for button in row       { newStack.addArrangedSubview(button) }
        }
    }
}


//MARK: ButtonInMultiTouchButton
// ein einzelner Knopf in einem Multitouchbutton
private class ButtonInMultiTouchButton:UIButton{
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: 50)
    init(viewModel:PanelControlViewModel, title:String, andTag tag:Int?){
        super.init(frame: CGRect.zero)
        initWith(title: title, and: tag)
        
        anchorHeight.reactive.constant  <~ viewModel.zeilenHoehe.producer
        reactive.isEnabled              <~ viewModel.isEnabled.producer
        viewModel.userEingabe           <~ reactive.controlEvents(.touchUpInside).map           { getTitle(forTag: $0.tag, inArray:(viewModel as! MultiTouchButtonViewModel).titleArray )}
        reactive.backgroundColor        <~ viewModel.controlCurrentModus.map                    { _ in (viewModel as! MultiTouchButtonViewModel).backgroundColor(forTag: tag) }
        reactive.backgroundColor        <~ viewModel.userEingabe.producer.filter{$0 != nil}.map { _ in (viewModel as! MultiTouchButtonViewModel).backgroundColor(forTag: tag) }
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: helper
    private func initWith(title:String, and tag:Int?){
        self.tag  = tag ?? -1
        setTitle(title, for: .normal)
        anchorHeight.isActive = true
    }
}