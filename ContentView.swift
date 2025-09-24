//
//  ContentView.swift
//  TranslateView_Base
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
import UIKit

import UIKit

import UIKit

class ViewController: UIViewController {

    let greetingLabel = UILabel()
    let changeLangButton = UIButton(type: .system)
    
    // 現在の言語コード
    var currentLang = "ja" {
        didSet {
            updateTexts()
        }
    }
    
    // 選択中のバンドル
    private var languageBundle: Bundle = .main

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // ラベル
        greetingLabel.font = .systemFont(ofSize: 24)
        greetingLabel.textColor = .black
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingLabel)
        
        // ボタン
        changeLangButton.setTitleColor(.black, for: .normal)
        changeLangButton.translatesAutoresizingMaskIntoConstraints = false
        changeLangButton.addTarget(self, action: #selector(showLanguageSheet), for: .touchUpInside)
        view.addSubview(changeLangButton)
        
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            changeLangButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20),
            changeLangButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        updateTexts()
    }
    
    func updateTexts() {
        // 言語用バンドルを切替
        if let path = Bundle.main.path(forResource: currentLang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            languageBundle = bundle
        } else {
            languageBundle = .main
        }
        
        // 文字列を再取得して更新
        greetingLabel.text = NSLocalizedString("greeting", bundle: languageBundle, comment: "")
        changeLangButton.setTitle(NSLocalizedString("changeLang", bundle: languageBundle, comment: ""), for: .normal)
        navigationItem.title = NSLocalizedString("editMemo", bundle: languageBundle, comment: "")
    }
    
    @objc func showLanguageSheet() {
        let alert = UIAlertController(title: NSLocalizedString("selectLanguage", bundle: languageBundle, comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let languages: [(String, String)] = [
            ("ja", "日本語"),
            ("en", "English"),
            ("zh-Hans", "中文（简体）"),
            ("zh-Hant", "中文（繁體）")
        ]
        
        for (code, name) in languages {
            alert.addAction(UIAlertAction(title: name, style: .default) { _ in
                self.currentLang = code
            })
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancelButton", bundle: languageBundle, comment: ""), style: .cancel))
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
