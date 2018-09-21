/************************************/
/* Author: Peter Malolepszy         */
/* File: CeaserCipher.swift         */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/

import Foundation

/***********************************/
/* -Cipher Protocol-               */
/* Establishes stardard functions  */
/***********************************/
protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String
    func decode(_ codedtext:String, secret: String) -> String
}


/************************************/
/* -Ceaser Cipher-                  */
/* Encodes message by shifting each */
/* characters unicode value by the  */
/* value of the secret              */
/************************************/

struct CeaserCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String {
        guard let shiftBy = UInt32(secret) else{
            return "Secret must be a number for this cipher type"
        }
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decode(_ codedtext: String, secret: String) -> String {
        guard let shiftBy = UInt32(secret) else{
            return "Secret must be a number for this cipher type"
        }
        var decoded = ""
        
        for character in codedtext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded += shiftedCharacter
        }
        return decoded
    }
}
