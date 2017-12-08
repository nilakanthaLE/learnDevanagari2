//
//  MultiTouchButton.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 23.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift


class MultiTouchButtonViewModel:PanelControlViewModel{
    var titleArray: [[String]]
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        self.titleArray         = controlSetting.titleArray ?? [[String]]()
        super.init(controlSetting: controlSetting, quizModel: quizModel)
        

    }
    func backgroundColor(forTag tag:Int?) -> UIColor{
        guard let tag = tag else {return .clear}
        let correctTag  = getTag(forSelected: getArray(forTitle: correctAnswer.value,inArray: titleArray)  )
        let selectedTag = getTag(forSelected: getArray(forTitle: userEingabe.value,inArray: titleArray)  )
        if controlCurrentModus.value == .ShowsPruefergebnis {
            if tag == correctTag                                                                {return colorForCorrect}
            if tag == selectedTag && tag != correctTag                                          {return colorForWrong}
        }
        if controlCurrentModus.value == .Anzeige {
            if tag == correctTag                                                                {return colorForSelected}
            if tag == selectedTag && tag != correctTag                                          {return colorForDefault}
        }
        if tag == selectedTag                                                                   {return colorForSelected}
        return colorForDefault
    }
}

class MultiTouchButton: UIStackView,PanelControlProtocol {
    var viewModel:PanelControlViewModel!{
        didSet{
            self.axis               = .vertical
            self.alignment          = .fill
            self.distribution       = .fillEqually
            addToStackView(buttons: createButtons(for: (viewModel as! MultiTouchButtonViewModel).titleArray))
            reactive.isHidden <~ viewModel.isHidden
        }
    }
    private var buttons:[[ButtonInMultiTouchButton]]!
    private func createButtons(for titleArray:[[String]]) -> [[UIButton]]{
        func button(withTitle title:String,andTag tag:Int?) -> UIButton{
            let button = ButtonInMultiTouchButton(zeilenHoehe: viewModel.zeilenHoehe.value, title: title, andTag: tag)
            viewModel.userEingabe           <~ button.reactive.controlEvents(.touchUpInside).map {[weak self] in getTitle(forTag: $0.tag, inArray:(self?.viewModel as! MultiTouchButtonViewModel).titleArray )}
            button.reactive.isEnabled       <~ viewModel.isEnabled
            button.zeilenHoehe              <~ viewModel.zeilenHoehe
            button.reactive.backgroundColor <~ viewModel.controlCurrentModus.map                    { [weak self]  _ in return (self?.viewModel as! MultiTouchButtonViewModel).backgroundColor(forTag: button.tag) }
            button.reactive.backgroundColor <~ viewModel.userEingabe.producer.filter{$0 != nil}.map { [weak self]  _ in return (self?.viewModel as! MultiTouchButtonViewModel).backgroundColor(forTag: button.tag) }
            
            return button
        }
        let buttonArray:[[UIButton]] = titleArray.enumerated().map   {
            let x           = $0.offset
            return $0.element.enumerated().map {
                let y           = $0.offset
                let tag         = getTag(for: (x: x, y: y), in: titleArray)
                return button(withTitle: $0.element, andTag: tag)
            }
        }
        return buttonArray
    }
    private func resetButtons()                         { addToStackView(buttons: createButtons(for: (viewModel as! MultiTouchButtonViewModel).titleArray)) }
    
    //map - only for sideeffects (???)
    private func addToStackView(buttons:[[UIButton]]) {
        for subview in self.arrangedSubviews {
            for view in subview.subviews {view.removeFromSuperview()}
            self.removeArrangedSubview(subview)
        }
        _ = buttons.map{buttonRow in
            let newStack    = UIStackView()
            newStack.axis   = .horizontal
            newStack.alignment      = .fill
            newStack.distribution   = .fillEqually
            self.addArrangedSubview(newStack)
            _ = buttonRow.map{button in newStack.addArrangedSubview(button)
            }
        }
    }
}


class ButtonInMultiTouchButton:UIButton{
    var zeilenHoehe:MutableProperty<CGFloat>
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: zeilenHoehe.value)
    init(zeilenHoehe:CGFloat, title:String, andTag tag:Int?){
        self.zeilenHoehe = MutableProperty<CGFloat>(zeilenHoehe)
        super.init(frame: CGRect.zero)
        self.tag  = tag ?? -1
        setTitle(title, for: .normal)
        anchorHeight.isActive = true
        anchorHeight.reactive.constant <~ self.zeilenHoehe.producer
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}




