//
//  TermsConditionsViewController.swift
//  JennyCraig
//
//  Created by mobileprogrammingllc on 11/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import WebKit
import SafariServices

class JCTermsConditionsViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var wkWebView: WKWebView!
    var popupWebView: WKWebView?
    var webview: WKWebView!
    weak var containerDelegate: UpdateContainerViewDelegate?
    var height: CGFloat?
    var shouldHideButtons = false
    @IBOutlet weak var backBtn: UIButton!
    var viewModel = SignUpViewModel()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        UIViewController.displaySpinner()
        height = 140
        loadWebView()
        setupWebView()
    }

    func setupWebView() {
         self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.webview.topAnchor.constraint(equalTo: view.topAnchor, constant: height!).isActive = true
        self.webview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.webview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
    }

    func setuppopViewContraints() {

        self.popupWebView?.translatesAutoresizingMaskIntoConstraints = false
               self.popupWebView?.topAnchor.constraint(equalTo: view.topAnchor, constant: height!).isActive = true
               self.popupWebView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
               self.popupWebView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
    }

    func loadWebView() {

        do {
            guard let filePath = Bundle.main.path(forResource: "privacy", ofType: "html")
                else {
                    // File Error
                    jcPrint("File reading error")
                    return
            }

            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)

            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            preferences.javaScriptCanOpenWindowsAutomatically = true
            let configuration = WKWebViewConfiguration()
            configuration.preferences = preferences
            self.webview = WKWebView(frame: view.bounds, configuration: configuration)
            self.webview.loadHTMLString(contents as String, baseURL: baseUrl)
            self.webview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.webview.uiDelegate = self
            self.webview.navigationDelegate = self
            view.addSubview(self.webview)
        } catch {
            jcPrint("File HTML error")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is JCCreateProfileController {
            if let controller = segue.destination as? JCCreateProfileController {
                controller.viewModel = self.viewModel
                controller.containerDelegate = containerDelegate
            }

        }
    }
 // MARK: - IBAction

    @IBAction func btnCrossTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            UIViewController.removeSpinner()
        })
     }
}

// MARK: - wkWebViewDelegate
extension JCTermsConditionsViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        popupWebView = WKWebView(frame: self.webview.bounds, configuration: configuration)

        popupWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupWebView!.navigationDelegate = self
        popupWebView!.uiDelegate = self
        view.addSubview(popupWebView!)
         setuppopViewContraints()
        return popupWebView!
    }

    func webViewDidClose(_ webView: WKWebView) {
        webView.removeFromSuperview()
        popupWebView = nil
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        jcPrint("Start to load")
        UIViewController.displaySpinner()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        jcPrint("finish to load")
        UIViewController.removeSpinner()
    }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        jcPrint(error.localizedDescription)
    }
}
