//
//  ContentView.swift
//  TranslateView
//
//  Created by Yuki Sasaki on 2025/09/22.
//

import SwiftUI
import CoreData

import SwiftUI
import UIKit

import SwiftUI
import UIKit

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedLanguage = "ja" // デフォルト日本語
    @State private var greeting = ""

    var body: some View {
        VStack(spacing: 20) {
            Text(greeting)
                .font(.title)

            Button("言語設定") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                LanguageSheet(selectedLanguage: $selectedLanguage, greeting: $greeting)
            }
        }
        .onAppear {
            updateGreeting()
        }
        .onChange(of: selectedLanguage) { _ in
            updateGreeting()
        }
        .padding()
    }

    func updateGreeting() {
        let bundlePath = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj") ?? ""
        let bundle = Bundle(path: bundlePath) ?? .main
        greeting = NSLocalizedString("hello", bundle: bundle, comment: "")
    }
}

struct LanguageSheet: View {
    @Binding var selectedLanguage: String
    @Binding var greeting: String

    let languages = [("日本語", "ja"), ("English", "en")]

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List(languages, id: \.1) { name, code in
                HStack {
                    Text(name)
                    Spacer()
                    if selectedLanguage == code {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedLanguage = code
                    // 選択したら即反映
                    let bundlePath = Bundle.main.path(forResource: code, ofType: "lproj") ?? ""
                    let bundle = Bundle(path: bundlePath) ?? .main
                    greeting = NSLocalizedString("hello", bundle: bundle, comment: "")
                    dismiss() // Sheet を閉じる
                }
            }
            .navigationTitle("言語を選択")
        }
    }
}



struct LocalizeView: UIViewRepresentable {

    @Binding var key: String
    @Binding var localizedText: String

    func makeUIView(context: Context) -> UIView {
        let container = UIView()

        let textField = UITextField()
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.placeholder = "キーを入力"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged(_:)), for: .editingChanged)
        container.addSubview(textField)

        let label = UILabel()
        label.tag = 2
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: container.topAnchor),
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),

            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let textField = uiView.viewWithTag(1) as? UITextField {
            textField.text = key
        }
        if let label = uiView.viewWithTag(2) as? UILabel {
            label.text = localizedText
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LocalizeView

        init(_ parent: LocalizeView) {
            self.parent = parent
        }

        @objc func textChanged(_ sender: UITextField) {
            guard let key = sender.text else { return }
            parent.key = key
            parent.localizedText = NSLocalizedString(key, comment: "")
        }
    }
}
