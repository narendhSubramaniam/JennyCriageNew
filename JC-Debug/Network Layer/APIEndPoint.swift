//  JCNetworkEndPoints.swift
//  Jenny Craig
//  Created by Mobileprogrammingllc on 6/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation

struct JCNetworkEndPoints {

    //209 server
    static func getDevBaseURL() -> String {

        return "https://0630p5qdph.execute-api.us-west-2.amazonaws.com/jc-npd-mbl-http/auth/"

       /* if boolIsConfirmSignup {
            boolIsConfirmSignup = false
            //return "https://0630p5qdph.execute-api.us-west-2.amazonaws.com/beta/admin/"
            return "https://0630p5qdph.execute-api.us-west-2.amazonaws.com/jc-npd-mbl-http/admin/"
        } else {
            //return "https://0630p5qdph.execute-api.us-west-2.amazonaws.com/beta/auth/"
            return "https://0630p5qdph.execute-api.us-west-2.amazonaws.com/jc-npd-mbl-http/auth/"
        } */
    }

    //AWS server
    static func getAwsBaseURL() -> String {

        return "https://frh8xa1jg4.execute-api.us-west-2.amazonaws.com/mp_npd/auth/"

       /* if boolIsConfirmSignup {
            boolIsConfirmSignup = false
            return "https://frh8xa1jg4.execute-api.us-west-2.amazonaws.com/mp_npd/admin/"
        } else {
            return "https://frh8xa1jg4.execute-api.us-west-2.amazonaws.com/mp_npd/auth/"
        } */
    }

    //Production server
    static func getProductionBaseURL() -> String {

        return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/auth/"
       /* if boolIsConfirmSignup {
            boolIsConfirmSignup = false
            return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/admin/"
        } else {
            return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/auth/"
        } */
    }

    //AppStore Release
    static func getAppStoreBaseURL() -> String {

        return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/auth/"

        /*if boolIsConfirmSignup {
            boolIsConfirmSignup = false
            return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/admin/"
        } else {
            return "https://954hgzwxqg.execute-api.us-west-2.amazonaws.com/jc_mbl_prd/auth/"
        } */
    }

    //*********************************************** DNA PDF Header ***********************************************
    static func getDevBaseDNAPdfHeader() -> String {
        return "api_key_npd_mbl_php_myI2AV5PpK7BckBGhiV5A1RVzFBrS6s43Lwur0lj"
    }
    static func getAwsBaseDNAPdfHeader() -> String {
        return "api_key_npd_mbl_php_myI2AV5PpK7BckBGhiV5A1RVzFBrS6s43Lwur0lj"
    }
    static func getProductionBaseDNAPdfHeader() -> String {
        return "4LJMV71A1BFhQVN2igbe8kgTvAreOTx1z7o1sWrd"
    }
    static func getAppStoreBaseDNAPdfHeader() -> String {
        return "4LJMV71A1BFhQVN2igbe8kgTvAreOTx1z7o1sWrd"
    }

    //*********************************************** DNA PDF Header ***********************************************

    //*********************************************** DNA Base URL ***********************************************

    static func getDevBaseURLDNA() -> String {
        return "https://nni115wdhk.execute-api.us-west-2.amazonaws.com/jc-npd-net/dna/auth/gd/Report"
    }
    static func getAwsBaseURLDNA() -> String {
        return "https://nni115wdhk.execute-api.us-west-2.amazonaws.com/jc-npd-net/dna/auth/gd/Report"
    }
    static func getProductionBaseURLDNA() -> String {
        return "https://riz69q3tzg.execute-api.us-west-2.amazonaws.com/jc-prd-net/dna/auth/gd/Report"
    }
    static func getAppStoreBaseURLDNA() -> String {
        return "https://riz69q3tzg.execute-api.us-west-2.amazonaws.com/jc-prd-net/dna/auth/gd/Report"
    }

    //*********************************************** DNA Base URL ***********************************************

    //*********************************************** Base Header ***********************************************

    static func getDevBaseHeader() -> String {
        return "hHsGH1LHbT20MZvZAM6d4XaXLJ7VBA5SUvuTLQ50"
    }
    static func getAwsBaseHeader() -> String {
        return "hHsGH1LHbT20MZvZAM6d4XaXLJ7VBA5SUvuTLQ50"
    }
    static func getProductionBaseHeader() -> String {
        return "sjlC7axsJEaD5CjwO4Tm45J3jt8H3wBu99QoET2K"
    }
    static func getAppStoreBaseHeader() -> String {
        return "sjlC7axsJEaD5CjwO4Tm45J3jt8H3wBu99QoET2K"
    }

    //*********************************************** Base Header ***********************************************

    //*********************************************** CognitoIdentityUserPoolAppClientId ***********************************************

    static func getDevCognitoIdentityUserPoolAppClientId() -> String {
        return "7m4bqpn5con7g4jt3o1egi6dpi"
    }
    static func getAwsCognitoIdentityUserPoolAppClientId() -> String {
        return "7m4bqpn5con7g4jt3o1egi6dpi"
    }
    static func getProductionCognitoIdentityUserPoolAppClientId() -> String {
        return "4mgqd3qm4oqd1gu4713o9o8l7o"
    }
    static func getAppStoreCognitoIdentityUserPoolAppClientId() -> String {
        return "4mgqd3qm4oqd1gu4713o9o8l7o"
    }

    //*********************************************** CognitoIdentityUserPoolAppClientId ***********************************************

    //*********************************************** CognitoIdentityUserPoolAppClientSecret ***********************************************

    static func getDevCognitoIdentityUserPoolAppClientSecret() -> String {
        return "1p8m65lnoop3imkfu8mfdnlpd182m2utb0qkgacogsc2kkkmduma"
    }
    static func getAwsCognitoIdentityUserPoolAppClientSecret() -> String {
        return "1p8m65lnoop3imkfu8mfdnlpd182m2utb0qkgacogsc2kkkmduma"
    }
    static func getProductionCognitoIdentityUserPoolAppClientSecret() -> String {
        return "6te9420gu9i9m7v24qs3a8se5g04sh5b95nlu6clu73opsh5hos"
    }
    static func getAppStoreCognitoIdentityUserPoolAppClientSecret() -> String {
        return "6te9420gu9i9m7v24qs3a8se5g04sh5b95nlu6clu73opsh5hos"
    }

    //*********************************************** CognitoIdentityUserPoolAppClientSecret ***********************************************

    //*********************************************** CognitoIdentityUserPoolId ***********************************************

    static func getDevCognitoIdentityUserPoolId() -> String {
        return "us-west-2_gb0MOmsHN"
    }
    static func getAwsCognitoIdentityUserPoolId() -> String {
        return "us-west-2_gb0MOmsHN"
    }
    static func getProductionCognitoIdentityUserPoolId() -> String {
        return "us-west-2_Y5nBQiUBF"
    }
    static func getAppStoreCognitoIdentityUserPoolId() -> String {
        return "us-west-2_Y5nBQiUBF"
    }

    //*********************************************** CognitoIdentityUserPoolId ***********************************************

    //*********************************************** GoogleInfoPlist ***********************************************

    static func getDevGoogleInfoPlist() -> String {
        return Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
    }

    static func getAwsGoogleInfoPlist() -> String {
        return Bundle.main.path(forResource: "GoogleService-InfoDevAWS", ofType: "plist")!
    }

    static func getProductionGoogleInfoPlist() -> String {
        return Bundle.main.path(forResource: "GoogleService-InfoProd", ofType: "plist")!
    }

    static func getAppStoreGoogleInfoPlist() -> String {
        return Bundle.main.path(forResource: "GoogleService-InfoAppStore", ofType: "plist")!
    }

    //*********************************************** GoogleInfoPlist ***********************************************

    //*********************************************** FitBitClientID ***********************************************

    static func getDevFitBitClientID() -> String {
        return "22BGW6"
    }

    static func getAwsFitBitClientID() -> String {
        return "22BGV8"
    }

    static func getProductionFitBitClientID() -> String {
        return "22BGV9"
    }

    static func getAppStoreFitBitClientID() -> String {
        return "22BPWF"
    }

    //*********************************************** FitBitClientID ***********************************************

    //*********************************************** FitBitClientSecret ***********************************************

    static func getDevFitBitClientSecret() -> String {
        return "6406659d2e4b4f47af3cc60d28703787"
    }

    static func getAwsFitBitClientSecret() -> String {
        return "c45772d43a03d5a23bd5d3ec9e924e83"
    }

    static func getProductionFitBitClientSecret() -> String {
        return "5e78af1074372f96b55b066b71169df9"
    }

    static func getAppStoreFitBitClientSecret() -> String {
        return "4683c4cbfef202b4273c2d1902d5e3f7"
    }

    //*********************************************** FitBitClientSecret ***********************************************

    //*********************************************** FitBitRedirectURI ***********************************************

    static func getDevFitBitRedirectURI() -> String {
        return "jennydev://fitness" //"JC-Dev://fitness"
    }

    static func getAwsFitBitRedirectURI() -> String {
        return "jennydevaws://fitness"
    }

    static func getProductionFitBitRedirectURI() -> String {
        return "jennyprod://fitness"
    }

    static func getAppStoreFitBitRedirectURI() -> String {
        return "jennyappstore://fitness"
    }

    //*********************************************** FitBitRedirectURI ***********************************************

}

/*
 This structure has member function to set the current build scheme. Current build scheme selected in XCode will be set into project info.plist key named as APP_ENV. This key is also mentioned under Build Setting
 where each schemes names are mentioned. All these name must be equal to the names as mentioned under the Enum of AppEnvMode.
 */

struct JCConfigEndPoints {

    internal enum AppEnvMode: String {

        case undefined = "Undefined"
        case debug = "Debug"
        case production = "Production"
        case aws = "Aws"
        case appStore = "AppStore"

        /*
         Set your project scheme base urls
         */
        func baseEndPoint() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevBaseURL()
            case .aws:
                return JCNetworkEndPoints.getAwsBaseURL()
            case .production:
                return JCNetworkEndPoints.getProductionBaseURL()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreBaseURL()
            default:
                return JCNetworkEndPoints.getDevBaseURL()
            }
        }

        func baseEndPointDNA() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevBaseURLDNA()
            case .aws:
                return JCNetworkEndPoints.getAwsBaseURLDNA()
            case .production:
                return JCNetworkEndPoints.getProductionBaseURLDNA()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreBaseURLDNA()
            default:
                return JCNetworkEndPoints.getDevBaseURLDNA()
            }
        }

        func baseHeaderDNAPdf() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevBaseDNAPdfHeader()
            case .aws:
                return JCNetworkEndPoints.getAwsBaseDNAPdfHeader()
            case .production:
                return JCNetworkEndPoints.getProductionBaseDNAPdfHeader()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreBaseDNAPdfHeader()
            default:
                return JCNetworkEndPoints.getDevBaseDNAPdfHeader()
            }
        }

        func baseHeader() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevBaseHeader()
            case .aws:
                return JCNetworkEndPoints.getAwsBaseHeader()
            case .production:
                return JCNetworkEndPoints.getProductionBaseHeader()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreBaseHeader()
            default:
                return JCNetworkEndPoints.getDevBaseHeader()
            }
        }

        func cognitoIdentityUserPoolAppClientId() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolAppClientId()
            case .aws:
                return JCNetworkEndPoints.getAwsCognitoIdentityUserPoolAppClientId()
            case .production:
                return JCNetworkEndPoints.getProductionCognitoIdentityUserPoolAppClientId()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreCognitoIdentityUserPoolAppClientId()
            default:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolAppClientId()
            }
        }

        func cognitoIdentityUserPoolAppSecret() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolAppClientSecret()
            case .aws:
                return JCNetworkEndPoints.getAwsCognitoIdentityUserPoolAppClientSecret()
            case .production:
                return JCNetworkEndPoints.getProductionCognitoIdentityUserPoolAppClientSecret()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreCognitoIdentityUserPoolAppClientSecret()
            default:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolAppClientSecret()
            }
        }

        func cognitoIdentityUserPoolID() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolId()
            case .aws:
                return JCNetworkEndPoints.getAwsCognitoIdentityUserPoolId()
            case .production:
                return JCNetworkEndPoints.getProductionCognitoIdentityUserPoolId()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreCognitoIdentityUserPoolId()
            default:
                return JCNetworkEndPoints.getDevCognitoIdentityUserPoolId()
            }
        }

        func googleInfoPlist() -> String? {

            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevGoogleInfoPlist()
            case .aws:
                return JCNetworkEndPoints.getAwsGoogleInfoPlist()
            case .production:
                return JCNetworkEndPoints.getProductionGoogleInfoPlist()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreGoogleInfoPlist()
            default:
                return JCNetworkEndPoints.getDevGoogleInfoPlist()
            }
        }

        func fitBitClientID() -> String? {
            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevFitBitClientID()
            case .aws:
                return JCNetworkEndPoints.getAwsFitBitClientID()
            case .production:
                return JCNetworkEndPoints.getProductionFitBitClientID()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreFitBitClientID()
            default:
                return JCNetworkEndPoints.getDevFitBitClientID()
            }

        }

        func fitBitClientSecret() -> String? {
            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevFitBitClientSecret()
            case .aws:
                return JCNetworkEndPoints.getAwsFitBitClientSecret()
            case .production:
                return JCNetworkEndPoints.getProductionFitBitClientSecret()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreFitBitClientSecret()
            default:
                return JCNetworkEndPoints.getDevFitBitClientSecret()
            }

        }

        func fitBitRedirectURI() -> String? {
            switch self {
            case .debug:
                return JCNetworkEndPoints.getDevFitBitRedirectURI()
            case .aws:
                return JCNetworkEndPoints.getAwsFitBitRedirectURI()
            case .production:
                return JCNetworkEndPoints.getProductionFitBitRedirectURI()
            case .appStore:
                return JCNetworkEndPoints.getAppStoreFitBitRedirectURI()
            default:
                return JCNetworkEndPoints.getDevFitBitRedirectURI()
            }

        }

    }

    private var mode: AppEnvMode = .undefined
    static var shared = JCConfigEndPoints()

    var appMode: AppEnvMode {
            return mode
    }

    /* This method need to be called when app launches. Ideal place to call this method at the very beginining of AppDelegate delegate method didFinishLaunching */
    mutating func initialize() {

        //self.mode = .Debug

        /* Value is captured from info.plist. Value in info.plist will come from User-Defined Variables APP_ENV */
        if let modeString = Bundle.main.infoDictionary?["APP_ENV"] as? String,
            let modeType = AppEnvMode(rawValue: modeString) {
            self.mode = modeType
            keychainService = "JennyCraigService" + Bundle.main.bundleIdentifier!
        }
    }
}
