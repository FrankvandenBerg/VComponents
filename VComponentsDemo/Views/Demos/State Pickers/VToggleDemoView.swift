//
//  VToggleDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI
import VComponents

// MARK:- V Toggle Demo View
struct VToggleDemoView: View {
    // MARK: Properties
    static let navigationBarTitle: String = "Toggle"
    
    private let toggleTitle: String = "Lorem ipsum"
    
    private func toggleContent() -> some View { DemoIconContentView() }
    
    let nonClickableContentModel: VToggleModel = {
        var model: VToggleModel = .init()
        model.misc.contentIsClickable = false
        return model
    }()
    
    let noLoweredOpacityWhenPressedModel: VToggleModel = {
        var model: VToggleModel = .init()
        model.colors.content.pressedOpacity = 1
        return model
    }()
    
    let noLoweredOpacityWhenDisabledModel: VToggleModel = {
        var model: VToggleModel = .init()
        model.colors.content.disabledOpacity = 1
        return model
    }()
    
    @State private var toggle1State: VToggleState = .on
    @State private var toggle2State: VToggleState = .on
    @State private var toggle3State: VToggleState = .on
    @State private var toggle4State: VToggleState = .on
    @State private var toggle5State: VToggleState = .on
    @State private var toggle6State: VToggleState = .on
}

// MARK:- Body
extension VToggleDemoView {
    var body: some View {
        VBaseView(title: Self.navigationBarTitle, content: {
            DemoView(type: .rowed, controller: controller, content: {
                DemoRowView(type: .titled("No Content"), content: {
                    VToggle(state: $toggle1State)
                })
                
                DemoRowView(type: .titled("Text"), content: {
                    VToggle(state: $toggle2State, title: toggleTitle)
                })
                
                DemoRowView(type: .titled("Icon"), content: {
                    VToggle(state: $toggle3State, content: toggleContent)
                })
                
                DemoRowView(type: .titled("Non-clickable Content"), content: {
                    VToggle(model: nonClickableContentModel, state: $toggle4State, title: toggleTitle)
                })
                
                DemoRowView(type: .titled("No Lowered Opacity when Pressed"), content: {
                    VToggle(model: noLoweredOpacityWhenPressedModel, state: $toggle5State, title: toggleTitle)
                })
                
                DemoRowView(type: .titled("No Lowered Opacity when Disabled"), content: {
                    VToggle(model: noLoweredOpacityWhenDisabledModel, state: $toggle6State, title: toggleTitle)
                })
            })
        })
    }
    
    private var controller: some View {
        DemoRowView(type: .controller, content: {
            ControllerToggleView(
                state: .init(
                    get: {
                        [toggle1State, toggle2State, toggle3State, toggle4State, toggle5State, toggle6State]
                            .contains(.disabled)
                    },
                    set: {
                        toggle1State = $0 ? .disabled : .off
                        toggle2State = $0 ? .disabled : .off
                        toggle3State = $0 ? .disabled : .off
                        toggle4State = $0 ? .disabled : .off
                        toggle5State = $0 ? .disabled : .off
                        toggle6State = $0 ? .disabled : .off
                    }
                ),
                title: "Disabled"
            )
        })
    }
}

// MARK: Preview
struct VToggleDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VToggleDemoView()
    }
}
