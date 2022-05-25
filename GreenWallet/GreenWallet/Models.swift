//
//  Models.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import Foundation
import UIKit

struct System: Equatable {
    var name: String
    var token: String
    var image: UIImage
    var balance: Double
}

struct WalletModel: Equatable {
    
    var name: String
    var number: Int
    var image: UIImage
    var tokens: [System]
    var toket: String
}


struct Language: Codable {
    let success: Bool
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let version: String
    let list: [DefaultLanguage]
    let defaultLanguage: DefaultLanguage

    enum CodingKeys: String, CodingKey {
        case version, list
        case defaultLanguage
    }
}

// MARK: - DefaultLanguage
struct DefaultLanguage: Codable {
    let name, nameBtn, code: String

    enum CodingKeys: String, CodingKey {
        case name
        case nameBtn
        case code
    }
}

struct ListOfTranslate: Codable {
    let success: Bool
    let result: ResultTranslate
}

// MARK: - Result
struct ResultTranslate: Codable {
    let version: String
    let list: List
}

// MARK: - List
struct List: Codable {
    let all: All
    let termsOfUse: TermsOfUse
    let createAPasscode: CreateAPasscode
    let welcomeScreen: WelcomeScreen
    let passcodeEntryScreen: PasscodeEntryScreen
    let mainScreen: MainScreen
    let importTokens: ImportTokens
    let importMnemonics: ImportMnemonics
    let networkDescription: NetworkDescription
    let screenForCreatingANewWallet: ScreenForCreatingANewWallet
    let createAMnemonicPhrase: CreateAMnemonicPhrase
    let mnemonicPhraseVerification: MnemonicPhraseVerification
    let receiveAToken: ReceiveAToken
    let sendToken: SendToken
    let transactions: Transactions
    let addressBook: AddressBook
    let myWallets: MyWallets
    let menu: Menu
    let support: Support
    let askAQuestion: AskAQuestion
    let wallet: Wallet
    let notifications: Notifications
    let faq: FAQ
    let listingRequest: ListingRequest
    let noConnection: NoConnection
    let slowConnection: SlowConnection

    enum CodingKeys: String, CodingKey {
        case all
        case termsOfUse
        case createAPasscode
        case welcomeScreen
        case passcodeEntryScreen
        case mainScreen
        case importTokens
        case importMnemonics
        case networkDescription
        case screenForCreatingANewWallet
        case createAMnemonicPhrase
        case mnemonicPhraseVerification
        case receiveAToken
        case sendToken
        case transactions
        case addressBook
        case myWallets
        case menu, support
        case askAQuestion
        case wallet, notifications, faq
        case listingRequest
        case noConnection
        case slowConnection
    }
}

// MARK: - AddressBook
struct AddressBook: Codable {
    let addressBookAddAdress, addressBookAddContactAddBtn, addressBookAddContactAdress, addressBookAddContactDescription: String
    let addressBookAddContactName, addressBookAddContactTitle, addressBookEditContactDescription, addressBookEditContactName: String
    let addressBookEditContactTitle, addressBookPopUpDeleteDescription, addressBookPopUpDeleteTitle, addressBookTitle: String
    let addressBookWrongAdressError, adressBookEditContactPopUpChangedDescription, adressBookEditContactPopUpChangedTitle, adressBookLoadingRemoveDescription: String
    let adressBookLoadingRemoveTitle, adressBookPopUpRemovedDescription, adressBookPopUpRemovedTitle: String

    enum CodingKeys: String, CodingKey {
        case addressBookAddAdress
        case addressBookAddContactAddBtn
        case addressBookAddContactAdress
        case addressBookAddContactDescription
        case addressBookAddContactName
        case addressBookAddContactTitle
        case addressBookEditContactDescription
        case addressBookEditContactName
        case addressBookEditContactTitle
        case addressBookPopUpDeleteDescription
        case addressBookPopUpDeleteTitle
        case addressBookTitle
        case addressBookWrongAdressError
        case adressBookEditContactPopUpChangedDescription
        case adressBookEditContactPopUpChangedTitle
        case adressBookLoadingRemoveDescription
        case adressBookLoadingRemoveTitle
        case adressBookPopUpRemovedDescription
        case adressBookPopUpRemovedTitle
    }
}

// MARK: - All
struct All: Codable {
    let addWalletImport, addWalletNew, addWalletTitle, agreementWithTermsOfUseChekbox: String
    let backBtn, confirmBtn, deletWalletWarningCancelBtn, deletWalletWarningConfirmlBtn: String
    let deletWalletWarningDescription, deletWalletWarningTitle, lableCopied, loadingPopUpDescription: String
    let loadingPopUpTitle, nextBtn, nonExistentAdressError, passcodeConfirmationDescription: String
    let passcodeConfirmationTitle, personalDataAgreementChekbox, popUpFailedErrorDescription, popUpFailedErrorReturnBtn: String
    let popUpFailedErrorTitle, popUpSentTitle, popUpWalletRemovedDescription, popUpWalletRemovedTitle: String
    let readyBtn, reconnectBtn, returnBtn, search: String
    let selectNetwork, shareBtn, transactionPopUpInfoTitle: String

    enum CodingKeys: String, CodingKey {
        case addWalletImport
        case addWalletNew
        case addWalletTitle
        case agreementWithTermsOfUseChekbox
        case backBtn
        case confirmBtn
        case deletWalletWarningCancelBtn
        case deletWalletWarningConfirmlBtn
        case deletWalletWarningDescription
        case deletWalletWarningTitle
        case lableCopied
        case loadingPopUpDescription
        case loadingPopUpTitle
        case nextBtn
        case nonExistentAdressError
        case passcodeConfirmationDescription
        case passcodeConfirmationTitle
        case personalDataAgreementChekbox
        case popUpFailedErrorDescription
        case popUpFailedErrorReturnBtn
        case popUpFailedErrorTitle
        case popUpSentTitle
        case popUpWalletRemovedDescription
        case popUpWalletRemovedTitle
        case readyBtn
        case reconnectBtn
        case returnBtn
        case search
        case selectNetwork
        case shareBtn
        case transactionPopUpInfoTitle
    }
}

// MARK: - AskAQuestion
struct AskAQuestion: Codable {
    let askAQuestionEMail, askAQuestionName, askAQuestionQuestion, askAQuestionTitle: String
    let popUpSentAQuestionDescription: String

    enum CodingKeys: String, CodingKey {
        case askAQuestionEMail
        case askAQuestionName
        case askAQuestionQuestion
        case askAQuestionTitle
        case popUpSentAQuestionDescription
    }
}

// MARK: - CreateAMnemonicPhrase
struct CreateAMnemonicPhrase: Codable {
    let createAMnemonicPhraseAgreement, createAMnemonicPhraseDescription, createAMnemonicPhraseTitle, popUpFailedCreateAMnemonicPhraseTitle: String

    enum CodingKeys: String, CodingKey {
        case createAMnemonicPhraseAgreement
        case createAMnemonicPhraseDescription
        case createAMnemonicPhraseTitle
        case popUpFailedCreateAMnemonicPhraseTitle
    }
}

// MARK: - CreateAPasscode
struct CreateAPasscode: Codable {
    let creatingAPasswordDescription, creatingAPasswordErrorAmountOfCharacters, creatingAPasswordErrorDifference, creatingAPasswordTitel: String

    enum CodingKeys: String, CodingKey {
        case creatingAPasswordDescription
        case creatingAPasswordErrorAmountOfCharacters
        case creatingAPasswordErrorDifference
        case creatingAPasswordTitel
    }
}

// MARK: - FAQ
struct FAQ: Codable {
    let faqTitle: String

    enum CodingKeys: String, CodingKey {
        case faqTitle
    }
}

// MARK: - ImportMnemonics
struct ImportMnemonics: Codable {
    let importMnemonicsDescription, importMnemonicsPopUpSucsessDescription, importMnemonicsSameWordsError, importMnemonicsTitle: String
    let importMnemonicsTwelveWordsBtn, importMnemonicsTwentyFourWordsBtn, importMnemonicsWarning, importMnemonicsWrongWordsError: String
    let popUpFailedImportMnemonicsTitle: String

    enum CodingKeys: String, CodingKey {
        case importMnemonicsDescription
        case importMnemonicsPopUpSucsessDescription
        case importMnemonicsSameWordsError
        case importMnemonicsTitle
        case importMnemonicsTwelveWordsBtn
        case importMnemonicsTwentyFourWordsBtn
        case importMnemonicsWarning
        case importMnemonicsWrongWordsError
        case popUpFailedImportMnemonicsTitle
    }
}

// MARK: - ImportTokens
struct ImportTokens: Codable {
    let importMnemonicsPopUpSucsessTitle, importTokensLabelAdd, importTokensTitle: String

    enum CodingKeys: String, CodingKey {
        case importMnemonicsPopUpSucsessTitle
        case importTokensLabelAdd
        case importTokensTitle
    }
}

// MARK: - ListingRequest
struct ListingRequest: Codable {
    let listingRequestBlockchain, listingRequestEMail, listingRequestName, listingRequestProjectDescription: String
    let listingRequestProjectName, listingRequestTitle, listingRequestTwitter, popUpListingRequestDescription: String

    enum CodingKeys: String, CodingKey {
        case listingRequestBlockchain
        case listingRequestEMail
        case listingRequestName
        case listingRequestProjectDescription
        case listingRequestProjectName
        case listingRequestTitle
        case listingRequestTwitter
        case popUpListingRequestDescription
    }
}

// MARK: - MainScreen
struct MainScreen: Codable {
    let mainScreenAddressesBtn, mainScreenPurseAddWallet, mainScreenPurseAllWallets, mainScreenPurseBtn: String
    let mainScreenPurseImport, mainScreenReciveBtn, mainScreenSendBtn, mainScreenTitleBalance: String
    let mainScreenTitlePurse, mainScreenTransactionBtn: String

    enum CodingKeys: String, CodingKey {
        case mainScreenAddressesBtn
        case mainScreenPurseAddWallet
        case mainScreenPurseAllWallets
        case mainScreenPurseBtn
        case mainScreenPurseImport
        case mainScreenReciveBtn
        case mainScreenSendBtn
        case mainScreenTitleBalance
        case mainScreenTitlePurse
        case mainScreenTransactionBtn
    }
}

// MARK: - Menu
struct Menu: Codable {
    let menuAllSettings, menuDarkTheme, menuHideWalletBalanceDescription, menuHideWalletBalanceTitle: String
    let menuLightTheme, menuNotifications, menuPushNotificationsDescription, menuPushNotificationsTitle: String
    let menuSupportDescription, menuSupportTitle: String

    enum CodingKeys: String, CodingKey {
        case menuAllSettings
        case menuDarkTheme
        case menuHideWalletBalanceDescription
        case menuHideWalletBalanceTitle
        case menuLightTheme
        case menuNotifications
        case menuPushNotificationsDescription
        case menuPushNotificationsTitle
        case menuSupportDescription
        case menuSupportTitle
    }
}

// MARK: - MnemonicPhraseVerification
struct MnemonicPhraseVerification: Codable {
    let mnemonicPhraseVerificationDescription, mnemonicPhraseVerificationError, mnemonicPhraseVerificationPopUpSucsessTitle, mnemonicPhraseVerificationTask: String
    let mnemonicPhraseVerificationTitle: String

    enum CodingKeys: String, CodingKey {
        case mnemonicPhraseVerificationDescription
        case mnemonicPhraseVerificationError
        case mnemonicPhraseVerificationPopUpSucsessTitle
        case mnemonicPhraseVerificationTask
        case mnemonicPhraseVerificationTitle
    }
}

// MARK: - MyWallets
struct MyWallets: Codable {
    let myWalletsAddWallet, myWalletsLabelAdded, myWalletsLabelRemoved, myWalletsTitle: String

    enum CodingKeys: String, CodingKey {
        case myWalletsAddWallet
        case myWalletsLabelAdded
        case myWalletsLabelRemoved
        case myWalletsTitle
    }
}

// MARK: - NetworkDescription
struct NetworkDescription: Codable {
    let networkDescriptionBtn: String

    enum CodingKeys: String, CodingKey {
        case networkDescriptionBtn
    }
}

// MARK: - NoConnection
struct NoConnection: Codable {
    let noConnectionDescription, noConnectionTitle: String

    enum CodingKeys: String, CodingKey {
        case noConnectionDescription
        case noConnectionTitle
    }
}

// MARK: - Notifications
struct Notifications: Codable {
    let notificationsAll, notificationsCreditedToChiaWallet, notificationsCreditedToChivesWallet, notificationsEnrollments: String
    let notificationsMonth, notificationsOther, notificationsTitle, notificationsToday: String
    let notificationsWeek, notificationsWithdrawnFromChiaWallet, notificationsWithdrawnFromChivesWallet, notificationsWriteOff: String
    let notificationsYear, notificationsYesterday: String

    enum CodingKeys: String, CodingKey {
        case notificationsAll
        case notificationsCreditedToChiaWallet
        case notificationsCreditedToChivesWallet
        case notificationsEnrollments
        case notificationsMonth
        case notificationsOther
        case notificationsTitle
        case notificationsToday
        case notificationsWeek
        case notificationsWithdrawnFromChiaWallet
        case notificationsWithdrawnFromChivesWallet
        case notificationsWriteOff
        case notificationsYear
        case notificationsYesterday
    }
}

// MARK: - PasscodeEntryScreen
struct PasscodeEntryScreen: Codable {
    let passcodeEntryScreenError, passcodeEntryScreenReset: String

    enum CodingKeys: String, CodingKey {
        case passcodeEntryScreenError
        case passcodeEntryScreenReset
    }
}

// MARK: - ReceiveAToken
struct ReceiveAToken: Codable {
    let receiveATokenAdress, receiveATokenCopy: String

    enum CodingKeys: String, CodingKey {
        case receiveATokenAdress
        case receiveATokenCopy
    }
}

// MARK: - ScreenForCreatingANewWallet
struct ScreenForCreatingANewWallet: Codable {
    let screenForCreatingANewWalletDescription, screenForCreatingANewWalletTitle: String

    enum CodingKeys: String, CodingKey {
        case screenForCreatingANewWalletDescription
        case screenForCreatingANewWalletTitle
    }
}

// MARK: - SendToken
struct SendToken: Codable {
    let sendTokenAddAddress, sendTokenAddressIsAlreadyExist, sendTokenAdress, sendTokenAmount: String
    let sendTokenCommissionAmount, sendTokenCommissionRecommended, sendTokenInsufficientFundsError, sendTokenNameOfAdres: String
    let sendTokenPasswordError, sendTokenPopUpConfirmation, sendTokenPopUpSuccsessDescription, sendTokenPopUpSuccsessTitle: String
    let sendTokenPopUpTransactionFailErrorDescription, sendTokenPopUpTransactionFailErrorTitle: String

    enum CodingKeys: String, CodingKey {
        case sendTokenAddAddress
        case sendTokenAddressIsAlreadyExist
        case sendTokenAdress
        case sendTokenAmount
        case sendTokenCommissionAmount
        case sendTokenCommissionRecommended
        case sendTokenInsufficientFundsError
        case sendTokenNameOfAdres
        case sendTokenPasswordError
        case sendTokenPopUpConfirmation
        case sendTokenPopUpSuccsessDescription
        case sendTokenPopUpSuccsessTitle
        case sendTokenPopUpTransactionFailErrorDescription
        case sendTokenPopUpTransactionFailErrorTitle
    }
}

// MARK: - SlowConnection
struct SlowConnection: Codable {
    let slowConnectionDescription, slowConnectionTitle: String

    enum CodingKeys: String, CodingKey {
        case slowConnectionDescription
        case slowConnectionTitle
    }
}

// MARK: - Support
struct Support: Codable {
    let supportAboutApp, supportAskAQuestion, supportFAQ, supportListing: String

    enum CodingKeys: String, CodingKey {
        case supportAboutApp
        case supportAskAQuestion
        case supportFAQ
        case supportListing
    }
}

// MARK: - TermsOfUse
struct TermsOfUse: Codable {
    let termsOfUseText, trmsOfUseTitle: String

    enum CodingKeys: String, CodingKey {
        case termsOfUseText
        case trmsOfUseTitle
    }
}

// MARK: - Transactions
struct Transactions: Codable {
    let incomingOutgoing, transactionsAll, transactionsIncoming, transactionsLastMonth: String
    let transactionsLastWeek, transactionsPendind, transactionsTitle, transactionsToday: String
    let transactionsYesterday: String

    enum CodingKeys: String, CodingKey {
        case incomingOutgoing
        case transactionsAll
        case transactionsIncoming
        case transactionsLastMonth
        case transactionsLastWeek
        case transactionsPendind
        case transactionsTitle
        case transactionsToday
        case transactionsYesterday
    }
}

// MARK: - Wallet
struct Wallet: Codable {
    let walletDataAdress, walletDataMnemonics, walletDataPublicKey, walletDeleteWalletBtn: String
    let walletReceiveDescription, walletReceiveTitle, walletScanAddressDescription, walletScanAddressTitle: String
    let walletSendDescription, walletSendTitle, walletShareDescription, walletShareTitle: String
    let walletShowData, walletTitle, walletTransactionHistoryBtn: String

    enum CodingKeys: String, CodingKey {
        case walletDataAdress
        case walletDataMnemonics
        case walletDataPublicKey
        case walletDeleteWalletBtn
        case walletReceiveDescription
        case walletReceiveTitle
        case walletScanAddressDescription
        case walletScanAddressTitle
        case walletSendDescription
        case walletSendTitle
        case walletShareDescription
        case walletShareTitle
        case walletShowData
        case walletTitle
        case walletTransactionHistoryBtn
    }
}

// MARK: - WelcomeScreen
struct WelcomeScreen: Codable {
    let welcomeScreenTitelAfternoon, welcomeScreenTitelEvening, welcomeScreenTitelMorning, welcomeScreenTitelNight: String

    enum CodingKeys: String, CodingKey {
        case welcomeScreenTitelAfternoon
        case welcomeScreenTitelEvening
        case welcomeScreenTitelMorning
        case welcomeScreenTitelNight
    }
}
