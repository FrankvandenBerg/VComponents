//
//  VAlert.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/26/20.
//

import SwiftUI

// MARK:- V Alert
/// Message component that presents dialog when condition is true
public struct VAlert<Content> where Content: View {
    // MARK: Properties
    public var model: VAlertModel = .init()
    public var dialogType: VAlertDialogType
    public var title: String?
    public var description: String?
    public var content: (() -> Content)?
    public var appearAction: (() -> Void)?
    public var disappearAction: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes component with dialog type, title, description, and content
    ///
    /// - Parameters:
    ///   - model: Model that describes UI
    ///   - dialogType: Enum that describes alert dialog, such as one button, two buttons, or many buttons
    ///   - title: Title that describes purpose of alert
    ///   - description: Description that describes purpose of alert
    ///   - content: Alert content
    ///   - appearAction: Callback for when component appears
    ///   - disappearAction: Callback for when component dissapears
    public init(
        model: VAlertModel = .init(),
        dialog dialogType: VAlertDialogType,
        title: String?,
        description: String?,
        @ViewBuilder content: @escaping () -> Content,
        onAppear appearAction: (() -> Void)? = nil,
        onDisappear disappearAction: (() -> Void)? = nil
    ) {
        self.model = model
        self.dialogType = dialogType
        self.title = title
        self.description = description
        self.content = content
        self.appearAction = appearAction
        self.disappearAction = disappearAction
    }
    
    /// Initializes component with dialog type, title and description
    ///
    /// - Parameters:
    ///   - model: Model that describes UI
    ///   - dialogType: Enum that describes alert dialog, such as one button, two buttons, or many buttons
    ///   - title: Title that describes purpose of alert
    ///   - description: Description that describes purpose of alert
    ///   - appearAction: Callback for when component appears
    ///   - disappearAction: Callback for when component dissapears
    public init(
        model: VAlertModel = .init(),
        dialog dialogType: VAlertDialogType,
        title: String?,
        description: String?,
        onAppear appearAction: (() -> Void)? = nil,
        onDisappear disappearAction: (() -> Void)? = nil
    )
        where Content == Never
    {
        self.model = model
        self.dialogType = dialogType
        self.title = title
        self.description = description
        self.content = nil
        self.appearAction = appearAction
        self.disappearAction = disappearAction
    }
}

// MARK:- Extension
public extension View {
    /// Presents alert
    /// - Parameters:
    ///   - isPresented: Binding to whether the alert is presented
    ///   - alert: Closure returning the alert to presenter
    /// - Returns: Presenter
    func vAlert<Content>(
        isPresented: Binding<Bool>,
        alert: @escaping () -> VAlert<Content>
    ) -> some View
        where Content: View
    {
        ZStack(content: {
            self
            
            if isPresented.wrappedValue {
                VModalVCRepresentable(
                    isPresented: isPresented,
                    content: _VAlert(isPresented: isPresented, alert: alert()),
                    blinding: alert().model.colors.blinding.edgesIgnoringSafeArea(.all)
                )
            }
        })
    }
}
