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


struct Language: Decodable {
    let success: Bool
    let result: LanguageResult
}

// MARK: - Result
struct LanguageResult: Decodable {
    let version: String
    let list: [DefaultLanguage]
    let defaultLanguage: DefaultLanguage
    
    enum CodingKeys: String, CodingKey {
        case version, list
        case defaultLanguage
    }
}

// MARK: - DefaultLanguage
struct DefaultLanguage: Decodable {
    let name, nameBtn, code: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case nameBtn
        case code
    }
}



// MARK: - ListOfTranslate
struct ListOfTranslate: Codable {
    let success: Bool
    let result: Result

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct Result: Codable {
    let version: String
    let list: List

    enum CodingKeys: String, CodingKey {
        case version
        case list
    }
}

// MARK: - List
struct List: Codable {
    let all: All
    let select_language: SelectLanguage
    let terms_of_use: TermsOfUse
    let create_a_passcode: CreateAPasscode
    let welcome_screen: WelcomeScreen
    let passcode_entry_screen: PasscodeEntryScreen
    let main_screen: MainScreen
    let import_tokens: ImportTokens
    let import_mnemonics: ImportMnemonics
    let network_description: NetworkDescription
    let screen_for_creating_a_new_wallet: ScreenForCreatingANewWallet
    let create_a_mnemonic_phrase: CreateAMnemonicPhrase
    let mnemonic_phrase_verification: MnemonicPhraseVerification
    let receive_a_token: ReceiveAToken
    let send_token: SendToken
    let transactions: Transactions
    let address_book: AddressBook
    let my_wallets: MyWallets
    let menu: Menu
    let support: Support
    let ask_a_question: AskAQuestion
    let wallet: Wallet
    let notifications: Notifications
    let faq: FAQ
    let listing_request: ListingRequest
    let no_connection: NoConnection
    let slow_connection: SlowConnection
    let about_the_application: AboutTheApplication

    enum CodingKeys: String, CodingKey {
        case all
        case select_language
        case terms_of_use
        case create_a_passcode
        case welcome_screen
        case passcode_entry_screen
        case main_screen
        case import_tokens
        case import_mnemonics
        case network_description
        case screen_for_creating_a_new_wallet
        case create_a_mnemonic_phrase
        case mnemonic_phrase_verification
        case receive_a_token
        case send_token
        case transactions
        case address_book
        case my_wallets
        case menu
        case support
        case ask_a_question
        case wallet
        case notifications
        case faq
        case listing_request
        case no_connection
        case slow_connection
        case about_the_application
    }
}

// MARK: - AboutTheApplication
struct AboutTheApplication: Codable {
    let about_the_application_info: String
    let about_the_application_title: String

    enum CodingKeys: String, CodingKey {
        case about_the_application_info
        case about_the_application_title
    }
}

// MARK: - AddressBook
struct AddressBook: Codable {
    let address_book_add_adress: String
    let address_book_add_contact_add_btn: String
    let address_book_add_contact_adress: String
    let address_book_add_contact_description: String
    let address_book_add_contact_name: String
    let address_book_add_contact_title: String
    let address_book_edit_contact_description: String
    let address_book_edit_contact_name: String
    let address_book_edit_contact_title: String
    let address_book_pop_up_added_description: String
    let address_book_pop_up_added_title: String
    let address_book_pop_up_delete_description: String
    let address_book_pop_up_delete_title: String
    let address_book_title: String
    let address_book_wrong_adress_error: String
    let adress_book_edit_contact_pop_up_changed_description: String
    let adress_book_edit_contact_pop_up_changed_title: String
    let adress_book_loading_remove_description: String
    let adress_book_loading_remove_title: String
    let adress_book_pop_up_removed_description: String
    let adress_book_pop_up_removed_title: String

    enum CodingKeys: String, CodingKey {
        case address_book_add_adress
        case address_book_add_contact_add_btn
        case address_book_add_contact_adress
        case address_book_add_contact_description
        case address_book_add_contact_name
        case address_book_add_contact_title
        case address_book_edit_contact_description
        case address_book_edit_contact_name
        case address_book_edit_contact_title
        case address_book_pop_up_added_description
        case address_book_pop_up_added_title
        case address_book_pop_up_delete_description
        case address_book_pop_up_delete_title
        case address_book_title
        case address_book_wrong_adress_error
        case adress_book_edit_contact_pop_up_changed_description
        case adress_book_edit_contact_pop_up_changed_title
        case adress_book_loading_remove_description
        case adress_book_loading_remove_title
        case adress_book_pop_up_removed_description
        case adress_book_pop_up_removed_title
    }
}

// MARK: - All
struct All: Codable {
    let add_wallet_import: String
    let add_wallet_new: String
    let add_wallet_title: String
    let agreement_with_terms_of_use_chekbox: String
    let back_btn: String
    let camera_permission_missing: String
    let cancel_btn: String
    let confirm_btn: String
    let delet_wallet_warning_cancel_btn: String
    let delet_wallet_warning_confirml_btn: String
    let delet_wallet_warning_description: String
    let delet_wallet_warning_title: String
    let lable_copied: String
    let loading_pop_up_description: String
    let loading_pop_up_title: String
    let next_btn: String
    let non_existent_adress_error: String
    let passcode_confirmation_description: String
    let passcode_confirmation_title: String
    let personal_data_agreement_chekbox: String
    let pop_up_failed_error_description: String
    let pop_up_failed_error_return_btn: String
    let pop_up_failed_error_title: String
    let pop_up_sent_title: String
    let pop_up_wallet_removed_description: String
    let pop_up_wallet_removed_title: String
    let ready_btn: String
    let reconnect_btn: String
    let return_btn: String
    let save_btn: String
    let search: String
    let select_network: String
    let share_btn: String

    enum CodingKeys: String, CodingKey {
        case add_wallet_import
        case add_wallet_new
        case add_wallet_title
        case agreement_with_terms_of_use_chekbox
        case back_btn
        case camera_permission_missing
        case cancel_btn
        case confirm_btn
        case delet_wallet_warning_cancel_btn
        case delet_wallet_warning_confirml_btn
        case delet_wallet_warning_description
        case delet_wallet_warning_title
        case lable_copied
        case loading_pop_up_description
        case loading_pop_up_title
        case next_btn
        case non_existent_adress_error
        case passcode_confirmation_description
        case passcode_confirmation_title
        case personal_data_agreement_chekbox
        case pop_up_failed_error_description
        case pop_up_failed_error_return_btn
        case pop_up_failed_error_title
        case pop_up_sent_title
        case pop_up_wallet_removed_description
        case pop_up_wallet_removed_title
        case ready_btn
        case reconnect_btn
        case return_btn
        case save_btn
        case search
        case select_network
        case share_btn
    }
}

// MARK: - AskAQuestion
struct AskAQuestion: Codable {
    let ask_a_question_e_mail: String
    let ask_a_question_name: String
    let ask_a_question_question: String
    let ask_a_question_title: String
    let pop_up_sent_a_question_description: String

    enum CodingKeys: String, CodingKey {
        case ask_a_question_e_mail
        case ask_a_question_name
        case ask_a_question_question
        case ask_a_question_title
        case pop_up_sent_a_question_description
    }
}

// MARK: - CreateAMnemonicPhrase
struct CreateAMnemonicPhrase: Codable {
    let create_a_mnemonic_phrase_agreement: String
    let create_a_mnemonic_phrase_description: String
    let create_a_mnemonic_phrase_title: String
    let pop_up_failed_create_a_mnemonic_phrase_title: String

    enum CodingKeys: String, CodingKey {
        case create_a_mnemonic_phrase_agreement
        case create_a_mnemonic_phrase_description
        case create_a_mnemonic_phrase_title
        case pop_up_failed_create_a_mnemonic_phrase_title
    }
}

// MARK: - CreateAPasscode
struct CreateAPasscode: Codable {
    let creating_a_password_description: String
    let creating_a_password_error_amount_of_characters: String
    let creating_a_password_error_difference: String
    let creating_a_password_titel: String
    let repeat_passcode_description: String
    let repeat_passcode_title: String

    enum CodingKeys: String, CodingKey {
        case creating_a_password_description
        case creating_a_password_error_amount_of_characters
        case creating_a_password_error_difference
        case creating_a_password_titel
        case repeat_passcode_description
        case repeat_passcode_title
    }
}

// MARK: - FAQ
struct FAQ: Codable {
    let faq_title: String

    enum CodingKeys: String, CodingKey {
        case faq_title
    }
}

// MARK: - ImportMnemonics
struct ImportMnemonics: Codable {
    let import_mnemonics_description: String
    let import_mnemonics_pop_up_sucsess_description: String
    let import_mnemonics_same_words_error: String
    let import_mnemonics_title: String
    let import_mnemonics_twelve_words_btn: String
    let import_mnemonics_twenty_four_words_btn: String
    let import_mnemonics_warning: String
    let import_mnemonics_wrong_words_error: String
    let pop_up_failed_import_mnemonics_title: String

    enum CodingKeys: String, CodingKey {
        case import_mnemonics_description
        case import_mnemonics_pop_up_sucsess_description
        case import_mnemonics_same_words_error
        case import_mnemonics_title
        case import_mnemonics_twelve_words_btn
        case import_mnemonics_twenty_four_words_btn
        case import_mnemonics_warning
        case import_mnemonics_wrong_words_error
        case pop_up_failed_import_mnemonics_title
    }
}

// MARK: - ImportTokens
struct ImportTokens: Codable {
    let import_mnemonics_pop_up_sucsess_title: String
    let import_tokens_label_add: String
    let import_tokens_title: String

    enum CodingKeys: String, CodingKey {
        case import_mnemonics_pop_up_sucsess_title
        case import_tokens_label_add
        case import_tokens_title
    }
}

// MARK: - ListingRequest
struct ListingRequest: Codable {
    let listing_request_blockchain: String
    let listing_request_e_mail: String
    let listing_request_name: String
    let listing_request_project_description: String
    let listing_request_project_name: String
    let listing_request_title: String
    let listing_request_twitter: String
    let pop_up_listing_request_description: String

    enum CodingKeys: String, CodingKey {
        case listing_request_blockchain
        case listing_request_e_mail
        case listing_request_name
        case listing_request_project_description
        case listing_request_project_name
        case listing_request_title
        case listing_request_twitter
        case pop_up_listing_request_description
    }
}

// MARK: - MainScreen
struct MainScreen: Codable {
    let main_screen_addresses_btn: String
    let main_screen_purse_add_wallet: String
    let main_screen_purse_all_wallets: String
    let main_screen_purse_btn: String
    let main_screen_purse_import: String
    let main_screen_recive_btn: String
    let main_screen_send_btn: String
    let main_screen_title_balance: String
    let main_screen_title_purse: String
    let main_screen_transaction_btn: String

    enum CodingKeys: String, CodingKey {
        case main_screen_addresses_btn
        case main_screen_purse_add_wallet
        case main_screen_purse_all_wallets
        case main_screen_purse_btn
        case main_screen_purse_import
        case main_screen_recive_btn
        case main_screen_send_btn
        case main_screen_title_balance
        case main_screen_title_purse
        case main_screen_transaction_btn
    }
}

// MARK: - Menu
struct Menu: Codable {
    let menu_change_language: String
    let menu_dark_theme: String
    let menu_hide_wallet_balance_description: String
    let menu_hide_wallet_balance_title: String
    let menu_light_theme: String
    let menu_notifications: String
    let menu_push_notifications_description: String
    let menu_push_notifications_title: String
    let menu_show_more_title: String
    let menu_support_description: String
    let menu_support_title: String

    enum CodingKeys: String, CodingKey {
        case menu_change_language
        case menu_dark_theme
        case menu_hide_wallet_balance_description
        case menu_hide_wallet_balance_title
        case menu_light_theme
        case menu_notifications
        case menu_push_notifications_description
        case menu_push_notifications_title
        case menu_show_more_title
        case menu_support_description
        case menu_support_title
    }
}

// MARK: - MnemonicPhraseVerification
struct MnemonicPhraseVerification: Codable {
    let mnemonic_phrase_verification_description: String
    let mnemonic_phrase_verification_error: String
    let mnemonic_phrase_verification_pop_up_sucsess_description: String
    let mnemonic_phrase_verification_pop_up_sucsess_title: String
    let mnemonic_phrase_verification_task: String
    let mnemonic_phrase_verification_title: String

    enum CodingKeys: String, CodingKey {
        case mnemonic_phrase_verification_description
        case mnemonic_phrase_verification_error
        case mnemonic_phrase_verification_pop_up_sucsess_description
        case mnemonic_phrase_verification_pop_up_sucsess_title
        case mnemonic_phrase_verification_task
        case mnemonic_phrase_verification_title
    }
}

// MARK: - MyWallets
struct MyWallets: Codable {
    let my_wallets_add_wallet: String
    let my_wallets_label_added: String
    let my_wallets_label_removed: String
    let my_wallets_title: String

    enum CodingKeys: String, CodingKey {
        case my_wallets_add_wallet
        case my_wallets_label_added
        case my_wallets_label_removed
        case my_wallets_title
    }
}

// MARK: - NetworkDescription
struct NetworkDescription: Codable {
    let network_description_btn: String

    enum CodingKeys: String, CodingKey {
        case network_description_btn
    }
}

// MARK: - NoConnection
struct NoConnection: Codable {
    let no_connection_description: String
    let no_connection_title: String

    enum CodingKeys: String, CodingKey {
        case no_connection_description
        case no_connection_title
    }
}

// MARK: - Notifications
struct Notifications: Codable {
    let notifications_all: String
    let notifications_credited_to_chia_wallet: String
    let notifications_credited_to_chives_wallet: String
    let notifications_enrollments: String
    let notifications_month: String
    let notifications_other: String
    let notifications_title: String
    let notifications_today: String
    let notifications_week: String
    let notifications_withdrawn_from_chia_wallet: String
    let notifications_withdrawn_from_chives_wallet: String
    let notifications_write_off: String
    let notifications_year: String
    let notifications_yesterday: String
    let notifications_transaction_info_block_height: String
    let notifications_transaction_info_commission: String
    let notifications_transaction_info_data: String
    let notifications_transaction_info_number_of_coins: String
    let notifications_transaction_info_title: String

    enum CodingKeys: String, CodingKey {
        case notifications_all
        case notifications_credited_to_chia_wallet
        case notifications_credited_to_chives_wallet
        case notifications_enrollments
        case notifications_month
        case notifications_other
        case notifications_title
        case notifications_today
        case notifications_week
        case notifications_withdrawn_from_chia_wallet
        case notifications_withdrawn_from_chives_wallet
        case notifications_write_off
        case notifications_year
        case notifications_yesterday
        case notifications_transaction_info_block_height
        case notifications_transaction_info_commission
        case notifications_transaction_info_data
        case notifications_transaction_info_number_of_coins
        case notifications_transaction_info_title
    }
}

// MARK: - PasscodeEntryScreen
struct PasscodeEntryScreen: Codable {
    let passcode_entry_screen_error: String
    let passcode_entry_screen_reset: String

    enum CodingKeys: String, CodingKey {
        case passcode_entry_screen_error
        case passcode_entry_screen_reset
    }
}

// MARK: - ReceiveAToken
struct ReceiveAToken: Codable {
    let receive_a_token_adress: String
    let receive_a_token_copy: String

    enum CodingKeys: String, CodingKey {
        case receive_a_token_adress
        case receive_a_token_copy
    }
}

// MARK: - ScreenForCreatingANewWallet
struct ScreenForCreatingANewWallet: Codable {
    let screen_for_creating_a_new_wallet_description: String
    let screen_for_creating_a_new_wallet_title: String

    enum CodingKeys: String, CodingKey {
        case screen_for_creating_a_new_wallet_description
        case screen_for_creating_a_new_wallet_title
    }
}

// MARK: - SelectLanguage
struct SelectLanguage: Codable {
    let select_language_title: String

    enum CodingKeys: String, CodingKey {
        case select_language_title
    }
}

// MARK: - SendToken
struct SendToken: Codable {
    let send_token_add_address: String
    let send_token_address_is_already_exist: String
    let send_token_adress: String
    let send_token_amount: String
    let send_token_commission_amount: String
    let send_token_commission_recommended: String
    let send_token_insufficient_funds_error: String
    let send_token_name_of_adres: String
    let send_token_password_error: String
    let send_token_pop_up_confirmation: String
    let send_token_pop_up_confirmation_adress: String
    let send_token_pop_up_confirmation_amount: String
    let send_token_pop_up_confirmation_blockchain: String
    let send_token_pop_up_confirmation_token: String
    let send_token_pop_up_succsess_description: String
    let send_token_pop_up_succsess_title: String
    let send_token_pop_up_transaction_fail_error_description: String
    let send_token_pop_up_transaction_fail_error_title: String

    enum CodingKeys: String, CodingKey {
        case send_token_add_address
        case send_token_address_is_already_exist
        case send_token_adress
        case send_token_amount
        case send_token_commission_amount
        case send_token_commission_recommended
        case send_token_insufficient_funds_error
        case send_token_name_of_adres
        case send_token_password_error
        case send_token_pop_up_confirmation
        case send_token_pop_up_confirmation_adress
        case send_token_pop_up_confirmation_amount
        case send_token_pop_up_confirmation_blockchain
        case send_token_pop_up_confirmation_token
        case send_token_pop_up_succsess_description
        case send_token_pop_up_succsess_title
        case send_token_pop_up_transaction_fail_error_description
        case send_token_pop_up_transaction_fail_error_title
    }
}

// MARK: - SlowConnection
struct SlowConnection: Codable {
    let slow_connection_description: String
    let slow_connection_title: String

    enum CodingKeys: String, CodingKey {
        case slow_connection_description
        case slow_connection_title
    }
}

// MARK: - Support
struct Support: Codable {
    let support_about_app: String
    let support_ask_a_question: String
    let support_FAQ: String
    let support_listing: String

    enum CodingKeys: String, CodingKey {
        case support_about_app
        case support_ask_a_question
        case support_FAQ
        case support_listing
    }
}

// MARK: - TermsOfUse
struct TermsOfUse: Codable {
    let terms_of_use_text: String
    let trms_of_use_title: String

    enum CodingKeys: String, CodingKey {
        case terms_of_use_text
        case trms_of_use_title
    }
}

// MARK: - Transactions
struct Transactions: Codable {
    let incoming_outgoing: String
    let transaction_pop_up_info_block_height: String
    let transaction_pop_up_info_commission: String
    let transaction_pop_up_info_date: String
    let transaction_pop_up_info_sum: String
    let transaction_pop_up_info_title: String
    let transactions_all: String
    let transactions_amount: String
    let transactions_height: String
    let transactions_incoming: String
    let transactions_last_month: String
    let transactions_last_week: String
    let transactions_pendind: String
    let transactions_status: String
    let transactions_title: String
    let transactions_today: String
    let transactions_yesterday: String

    enum CodingKeys: String, CodingKey {
        case incoming_outgoing
        case transaction_pop_up_info_block_height
        case transaction_pop_up_info_commission
        case transaction_pop_up_info_date
        case transaction_pop_up_info_sum
        case transaction_pop_up_info_title
        case transactions_all
        case transactions_amount
        case transactions_height
        case transactions_incoming
        case transactions_last_month
        case transactions_last_week
        case transactions_pendind
        case transactions_status
        case transactions_title
        case transactions_today
        case transactions_yesterday
    }
}

// MARK: - Wallet
struct Wallet: Codable {
    let wallet_data_adress: String
    let wallet_data_mnemonics: String
    let wallet_data_public_key: String
    let wallet_delete_wallet_btn: String
    let wallet_receive_description: String
    let wallet_receive_title: String
    let wallet_scan_address_description: String
    let wallet_scan_address_title: String
    let wallet_send_description: String
    let wallet_send_title: String
    let wallet_share_description: String
    let wallet_share_title: String
    let wallet_show_data: String
    let wallet_title: String
    let wallet_transaction_history_btn: String

    enum CodingKeys: String, CodingKey {
        case wallet_data_adress
        case wallet_data_mnemonics
        case wallet_data_public_key
        case wallet_delete_wallet_btn
        case wallet_receive_description
        case wallet_receive_title
        case wallet_scan_address_description
        case wallet_scan_address_title
        case wallet_send_description
        case wallet_send_title
        case wallet_share_description
        case wallet_share_title
        case wallet_show_data
        case wallet_title
        case wallet_transaction_history_btn
    }
}

// MARK: - WelcomeScreen
struct WelcomeScreen: Codable {
    let welcome_screen_titel_afternoon: String
    let welcome_screen_titel_evening: String
    let welcome_screen_titel_morning: String
    let welcome_screen_titel_night: String

    enum CodingKeys: String, CodingKey {
        case welcome_screen_titel_afternoon
        case welcome_screen_titel_evening
        case welcome_screen_titel_morning
        case welcome_screen_titel_night
    }
}

struct Systems: Codable {
    let success: Bool
    let result: ResultSystems

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct ResultSystems: Codable {
    let version: String
    let list: [ListSystems]

    enum CodingKeys: String, CodingKey {
        case version
        case list
    }
}

// MARK: - List
struct ListSystems: Codable, Hashable {
    let name: String
    let full_node: String
    let wallet: String
    let daemon: String
    let farmer: String
    let harvester: String

    enum CodingKeys: String, CodingKey {
        case name
        case full_node
        case wallet
        case daemon
        case farmer
        case harvester
    }
}

struct PushNotifications: Codable {
    let success: Bool
    let result: PushNotificationsResult

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct PushNotificationsResult: Codable {
    let version: String
    let list: [PushNotificationsList]

    enum CodingKeys: String, CodingKey {
        case version
        case list
    }
}

// MARK: - List
struct PushNotificationsList: Codable {
    let guid: String
    let created_at: String
    let message: String

    enum CodingKeys: String, CodingKey {
        case guid
        case created_at
        case message
    }
}

struct Agreement: Codable {
    let success: Bool
    let result: AgreementResult

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct AgreementResult: Codable {
    let version: String
    let agreement_text: String

    enum CodingKeys: String, CodingKey {
        case version
        case agreement_text
    }
}

struct Tails: Codable {
    let success: Bool
    let result: TailsResult

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct TailsResult: Codable {
    let version: String
    let list: [TailsList]

    enum CodingKeys: String, CodingKey {
        case version
        case list
    }
}

// MARK: - List
struct TailsList: Codable {
    let name: String
    let code: String
    let hash: String
    let clvm: String
    let logo_url: String

    enum CodingKeys: String, CodingKey {
        case name
        case code
        case hash
        case clvm
        case logo_url
    }
}

struct TailsPrices: Codable {
    let success: Bool
    let result: [TailsPricesResult]

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Result
struct TailsPricesResult: Codable {
    let code: String
    let hash: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case code
        case hash
        case price
    }
}



