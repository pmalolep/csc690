/************************************/
/* Author: Peter Malolepszy         */
/* File: CipherFactory.swift        */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "Vigenere": VigenereCipher(),
        "Transposition":TranspositionCipher(),
        "Alphanumeric":AlphanumericCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
