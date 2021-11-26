//
//  JCLoginSignUpContainerController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import AVKit
import AVFoundation

protocol UpdateContainerViewDelegate: class {

     func moveBackToMainContainer()
}

class JCLoginSignUpContainerController: UIViewController {

    // MARK: - Outlets
    //contain sign in navigation controller.
    
    @IBOutlet var signInContainerView: UIView!

     //contain sign up navigation controller
    
    @IBOutlet var signUpContainerView: UIView!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet weak var videoView: UIView!
    var username = ""
    var videoPlayer: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var currentTime = CMTime.zero
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboard()
        self.loadvideo()
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController!.isMovingFromParent {
            let signInVC = UIStoryboard.signInViewController()
            self.navigationController?.pushViewController(signInVC!, animated: true)
        }
        self.hideKeyboard()
         self.continuePlay()

        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name:
            NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        // background event
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPlayerTime), name: UIApplication.didEnterBackgroundNotification, object: nil)

        // foreground event
        NotificationCenter.default.addObserver(self, selector: #selector(continuePlay), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         currentTime = (videoPlayer?.currentTime())!
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)

        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layer = playerLayer {
            layer.frame = self.videoView.layer.bounds
        }
    }

     // MARK: - Functions
    @objc func videoDidEnd(notification: NSNotification) {
        jcPrint("video ended")
        currentTime = CMTime.zero
        self.continuePlay()
    }

    func loadvideo() {

        let filepath: String? = Bundle.main.path(forResource: "JC_App_TitleBG_V5_1080", ofType: "mp4")
        if let videoPath = filepath {
            let url = URL.init(fileURLWithPath: videoPath)
            videoPlayer = AVPlayer(url: url)
            if #available(iOS 12.0, *) {
                videoPlayer?.preventsDisplaySleepDuringVideoPlayback =  false
            } else {
                // Fallback on earlier versions
            }

            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)

            playerLayer = AVPlayerLayer(player: videoPlayer)
            self.videoView.layer.addSublayer(playerLayer!)
            playerLayer?.frame = self.videoView.layer.bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPlayer?.seek(to: currentTime)
            videoPlayer?.play()
        }

    }

    @objc func continuePlay() {
        videoPlayer?.seek(to: currentTime)
        videoPlayer?.play()
    }

    // background event
    @objc func setCurrentPlayerTime() {
        // first pause the player before setting the playerLayer to nil. The pause works similar to a stop button
       currentTime = (videoPlayer?.currentTime())!
    }

    //Accessibility Support
    func accessibility() {
        self.signInContainerView.isAccessibilityElement = true
        self.signUpContainerView.isAccessibilityElement = true
        self.signInContainerView.accessibilityLabel = "SignInView"
        self.signUpContainerView.accessibilityLabel = "SignUpView" //3
    }

    func updateViewState(tag: Int) {

        if tag == 0 {

            signInContainerView.isHidden = true
            signUpContainerView.isHidden = false

            signInButton.isSelected = true
            signUpButton.isSelected = false
            signUpButton.isUserInteractionEnabled = true
            signInButton.isUserInteractionEnabled = false

        } else {

            signInContainerView.isHidden = false
            signUpContainerView.isHidden = true
            iswebUser = false

            signInButton.isSelected = false
            signUpButton.isSelected = true
            signUpButton.isUserInteractionEnabled = false
            signInButton.isUserInteractionEnabled = true

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getEmailAddress"), object: nil)
        }

    }

    func resetController() {

        for subController in self.children {

            if let navController = subController as? UINavigationController {
            navController.viewControllers[0].view.endEditing(true)

                navController.popToRootViewController(animated: false)
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - IBAction
    @IBAction func segmentButtonClicked(sender: UIButton) {

     //if clicked on login button
        self.updateViewState(tag: sender.tag)
        self.resetController()
    }

    @IBAction func unWindToRootViewController(_ sender: UIStoryboardSegue) {
         }
}

extension JCLoginSignUpContainerController: UpdateContainerViewDelegate {

    func moveBackToMainContainer() {
        self.resetController()
       self.updateViewState(tag: 0)
    }

}

extension JCLoginSignUpContainerController: AWSCognitoIdentityPasswordAuthentication {

    func signInUserInCognito(username: String) {

        let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: username, password: passwordLocalSignup )
        self.passwordAuthenticationCompletion?.set(result: authDetails)
    }

    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource

        if let nav =  self.children.last as? UINavigationController {

            if let accountInfoController =  (nav.children.last as? JCAccountInfoController) {
                self.username  = (accountInfoController.viewModel.userInfo.username)!

                self.signInUserInCognito(username: self.username.lowercased())

                jcPrint("getDetailscalled2")
            }

        }
    }

    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {

                self.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Retry"], actions: [ {action1 in
                    }, nil])

            } else {

                do {
                    let emailText = (self.username).trimmingTrailingSpaces
                    jcPrint(emailText)
                    try AuthController.setPassword(username: (emailText.lowercased()), password: passwordLocalSignup)
                } catch {
                    jcPrint("Error signing in: \(error.localizedDescription)")
                }
                countHomeScreenDisplayed = 0
                jcPrint(Settings.currentUser?.accessToken ?? "token")
                Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.dashboardStoryboard().instantiateInitialViewController()

                globalTimer?.invalidate()
                globalTimer = nil
            }
        }
    }
}
