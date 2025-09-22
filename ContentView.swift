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

import UIKit

import SwiftUI
import UIKit

// 既存の UIKit ViewController
class ViewController: UIViewController {

    let greetingLabel = UILabel()
    let changeLangButton = UIButton(type: .system)
    var currentLang = "ja" {
        didSet { updateGreeting() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // ラベル設定
        greetingLabel.font = .systemFont(ofSize: 24)
        greetingLabel.textColor = .black // ← 文字を黒に
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingLabel)

        // ボタン設定
        changeLangButton.setTitle("言語設定", for: .normal)
        changeLangButton.setTitleColor(.black, for: .normal) // ← ボタン文字も黒に
        changeLangButton.translatesAutoresizingMaskIntoConstraints = false
        changeLangButton.addTarget(self, action: #selector(showLanguageSheet), for: .touchUpInside)
        view.addSubview(changeLangButton)

        // レイアウト
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            changeLangButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20),
            changeLangButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        updateGreeting()
    }
    
    

    func updateGreeting() {
        if let path = Bundle.main.path(forResource: currentLang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            greetingLabel.text = NSLocalizedString("hello", bundle: bundle, comment: "")
        } else {
            greetingLabel.text = "hello"
        }
    }

    @objc func showLanguageSheet() {
        let alert = UIAlertController(title: "言語を選択", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "日本語", style: .default) { _ in
            self.currentLang = "ja"
            self.updateGreeting() // ← 明示的に更新
        })
        
        alert.addAction(UIAlertAction(title: "English", style: .default) { _ in
            self.currentLang = "en"
            self.updateGreeting() // ← 明示的に更新
        })
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        
        present(alert, animated: true)
    }

    
}

// SwiftUI 用のラッパー
struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // ここで必要に応じて UIKit VC を更新できる
    }
}

// SwiftUI の ContentView
struct ContentView: View {
    var body: some View {
        ViewControllerWrapper()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white) // 白背景を確実に
    }
}
