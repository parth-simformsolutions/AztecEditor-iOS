import Foundation
import UIKit

/// Formatter to apply simple value (NSNumber, UIColor) attributes to an attributed string.
class CodeFormatter: AttributeFormatter {

    var placeholderAttributes: [NSAttributedString.Key: Any]?

    let monospaceFont: UIFont
    let backgroundColor: UIColor
    let htmlRepresentationKey: NSAttributedString.Key

    // MARK: - Init

    init(monospaceFont: UIFont = FontProvider.shared.monospaceFont, backgroundColor: UIColor = ColorProvider.shared.codeBackgroungColor) {
        self.monospaceFont = monospaceFont
        self.backgroundColor = backgroundColor
        self.htmlRepresentationKey = .codeHtmlRepresentation
    }

    func applicationRange(for range: NSRange, in text: NSAttributedString) -> NSRange {
        return range
    }

    func apply(to attributes: [NSAttributedString.Key: Any], andStore representation: HTMLRepresentation?) -> [NSAttributedString.Key: Any] {
        var resultingAttributes = attributes

        resultingAttributes[.backgroundColor] = backgroundColor
        var representationToUse = HTMLRepresentation(for: .element(HTMLElementRepresentation.init(name: "strong", attributes: [])))
        if let requestedRepresentation = representation {
            representationToUse = requestedRepresentation
        }
        resultingAttributes[htmlRepresentationKey] = representationToUse

        return resultingAttributes
    }

    func remove(from attributes: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
        var resultingAttributes = attributes

        resultingAttributes.removeValue(forKey: .backgroundColor)
        resultingAttributes.removeValue(forKey: htmlRepresentationKey)

        if let placeholderAttributes = self.placeholderAttributes {
            resultingAttributes[.backgroundColor] = placeholderAttributes[.backgroundColor]
        }

        return resultingAttributes
    }

    func present(in attributes: [NSAttributedString.Key: Any]) -> Bool {
        return attributes[NSAttributedString.Key.codeHtmlRepresentation] != nil            
    }
}


