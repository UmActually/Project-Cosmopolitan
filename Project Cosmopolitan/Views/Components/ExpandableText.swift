//
//  ExpandableText.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 15/11/24.
//

import SwiftUI

struct ExpandableText: View {
    private let text: String
    private let lineLimit: Int
    private let moreButtonText: String
     
    init(_ text: String, lineLimit: Int = 2, moreButtonText: String = "more") {
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lineLimit = lineLimit
        self.moreButtonText = moreButtonText
    }
    
    @State private var isExpanded: Bool = false
    @State private var isTruncated: Bool = false
    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero
    @State private var moreTextSize: CGSize = .zero
     
    var body: some View {
        Text(.init(!isExpanded && isTruncated ? textTrimmingDoubleNewlines : text))
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(isExpanded ? nil : lineLimit)
            .readSize { size in
                truncatedSize = size
                isTruncated = truncatedSize != intrinsicSize
            }
            .background(
                Text(.init(text))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncated = truncatedSize != intrinsicSize
                    }
            )
            .overlay(alignment: .trailingLastTextBaseline) {
                if !isExpanded, isTruncated {
                    Button {
                        withAnimation { isExpanded.toggle() }
                    } label: {
                        Text("more")
                            .foregroundStyle(.customBlue)
                    }
                }
            }
            .applyingTruncationMask(size: moreTextSize, enabled: !isExpanded && isTruncated)
            .background(
                Text(moreButtonText)
                    .hidden()
                    .readSize { moreTextSize = $0 }
            )
    }
    
    private var textTrimmingDoubleNewlines: String {
        text.replacingOccurrences(of: #"\n\s*\n"#, with: "\n", options: .regularExpression)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
 
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct TruncationTextMask: ViewModifier {
    let size: CGSize
    let enabled: Bool
    
    @Environment(\.layoutDirection) private var layoutDirection
 
    func body(content: Content) -> some View {
        if enabled {
            content
                .mask(
                    VStack(spacing: 0) {
                        Rectangle()
                        HStack(spacing: 0) {
                            Rectangle()
                            HStack(spacing: 0) {
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        Gradient.Stop(color: .black, location: 0),
                                        Gradient.Stop(color: .clear, location: 0.9)
                                    ]),
                                    startPoint: layoutDirection == .rightToLeft ? .trailing : .leading,
                                    endPoint: layoutDirection == .rightToLeft ? .leading : .trailing
                                )
                                .frame(width: size.width, height: size.height)
 
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: size.width)
                            }
                        }.frame(height: size.height)
                    }
                )
        } else {
            content
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
 
extension View {
    func applyingTruncationMask(size: CGSize, enabled: Bool) -> some View {
        modifier(TruncationTextMask(size: size, enabled: enabled))
    }
}

#Preview {
    VStack {
        ExpandableText("No sé porqué se complicaron con el operador =, agregando == no solicitado, y la coma (,) utilizando un delimitador. Como consecuencia la entrada = # lo marca como error, cuando el = debió haberlo aceptado, y == lo marca como operador relacional en lugar de 2 operadores =. También, equivocadamente acepta mayúsculas en los identificadores.")
    }
    .padding()
}
