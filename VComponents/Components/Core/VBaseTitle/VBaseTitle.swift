//
//  VBaseTitle.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 1/7/21.
//

import SwiftUI

// MARK:- V Base Title
/// Core component that is used throughout the framework as title
public struct VBaseTitle: View {
    // MARK: Properties
    private let title: String
    private let color: Color
    private let font: Font
    private let titleType: VBaseTitleType
    
    // MARK: Initializers
    /// Initializes component with title, color, font, and type
    /// - Parameters:
    ///   - title: Title
    ///   - color: Title font
    ///   - font: Title font
    ///   - titleType: Enum that describes layout, such as one-line or multi-line
    public init(
        title: String,
        color: Color,
        font: Font,
        type titleType: VBaseTitleType
    ) {
        self.title = title
        self.color = color
        self.font = font
        self.titleType = titleType
    }
}

// MARK:- Body
extension VBaseTitle {
    @ViewBuilder public var body: some View {
        switch titleType {
        case .oneLine:
            Text(title)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(color)
                .font(font)
            
        case .multiLine(let limit, let alignment):
            Text(title)
                .lineLimit(limit)
                .multilineTextAlignment(alignment)
                .truncationMode(.tail)
                .foregroundColor(color)
                .font(font)
        }
    }
}

// MARK:- Preview
struct VBaseTitle_Previews: PreviewProvider {
    static var previews: some View {
        VBaseTitle(title: "TITLE", color: ColorBook.primary, font: .body, type: .oneLine)
    }
}