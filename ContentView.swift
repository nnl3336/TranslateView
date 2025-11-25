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

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    let button = UIButton(type: .system)
    
    // 言語リスト
    let languages = ["ja", "en", "zh-Hans", "zh-Hant"]
    var currentIndex = 0 {
        didSet {
            updateTexts()
        }
    }
    
    private var languageBundle: Bundle = .main

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // ---- Label ----
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // ---- Button ----
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapTranslate), for: .touchUpInside)
        view.addSubview(button)

        // ---- Layout ----
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32)
        ])
        
        updateTexts()
    }

    func updateTexts() {
        let currentLang = languages[currentIndex]
        if let path = Bundle.main.path(forResource: currentLang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            languageBundle = bundle
        } else {
            languageBundle = .main
        }

        label.text = NSLocalizedString("greeting", bundle: languageBundle, comment: "")
        button.setTitle(NSLocalizedString("translate", bundle: languageBundle, comment: ""), for: .normal)
    }

    @objc func tapTranslate() {
        // 次の言語に切替（ループ）
        currentIndex = (currentIndex + 1) % languages.count
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
            .ignoresSafeArea()   // ← これ重要！
            .background(Color.white)
    }
}
