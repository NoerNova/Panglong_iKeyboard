//
//  KeyboardViewController.swift
//  Panglong
//
//  Created by NorHsangPha BoonHse on 18/9/2567 BE.
//

import KeyboardKit
import ISEmojiView
import SwiftUI

class KeyboardViewController: KeyboardInputViewController {
    
    override func viewDidLoad() {
        setupServices(extraKey: .emojiIfNeeded)
        setupState()
        setUpISEmojiView()
        
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        setup { controller in KeyboardView(
            state: controller.state,
            services: controller.services,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { params in params.view }
        )}
    }
}

extension KeyboardViewController {
    
    func setupServices(extraKey: LayoutServiceProvider.ExtraKey) {
        
        services.autocompleteService = AutocompleteServiceProvider(context: state.autocompleteContext)
        
        services.layoutService = LayoutServiceProvider(extraKey: extraKey)
        services.styleProvider = StyleProvider(keyboardContext: state.keyboardContext)
        services.calloutService = CalloutProvider()
    }
    
    func setupState() {
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        
        state.keyboardContext.localePresentationLocale = .current
        state.keyboardContext.locale = KeyboardLocale.english.locale
    }
    
    func setUpISEmojiView() {
        let keyboardSettings = KeyboardSettings(bottomType: .categories)
        keyboardSettings.isShowPopPreview = true
        keyboardSettings.needToShowAbcButton = true
        keyboardSettings.needToShowDeleteButton = true
        keyboardSettings.updateRecentEmojiImmediately = true
        
        let emojiView = EmojiView(keyboardSettings: keyboardSettings)
        let bottomView = emojiView.subviews.last?.subviews.last
        let collecitonViewToSuperViewTrailingConstraint = bottomView?.value(forKey: "collecitonViewToSuperViewTrailingConstraint") as? NSLayoutConstraint
        collecitonViewToSuperViewTrailingConstraint?.priority = .defaultLow
    }
}
