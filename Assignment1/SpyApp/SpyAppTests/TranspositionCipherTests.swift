//***************************************/
/* Author: Peter Malolepszy             */
/* File: TranspositionCipherTests.swift */
/* Project: SpyApp                      */
/* Class: CSC 690 Fall 2018 SFSU        */
/* Date: 9/20/2018                      */
/****************************************/

import XCTest
@testable import SpyApp

class TranspositionCipherTests: XCTestCase{
    
    var cipher: Cipher!
    
    override func setUp(){
        super.setUp()
        
        cipher = TranspositionCipher()
    }
    
    func test_oneCharacterStringGetsMappedToSelfWith_92_secret(){
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "92")
        XCTAssertEqual("a",result)
    }
    
    func test_nonNumericInputForSecret(){
        let result = cipher.encode("b", secret: "nonNumericString")
        
        XCTAssertEqual(result, "Secret must be a number for this cipher")
    }
    
    func test_unknownCharacterInInput(){
        let result = cipher.encode("message~", secret: "0")
        
        XCTAssertEqual(result, "Input contains unknown character(s)")
    }
    
    func test_basicEnciption(){
        let result = cipher.encode("abcdef", secret: "0")
        
        XCTAssertEqual(result,"ZYXWVU")
    }
    
    func test_basicDecription(){
        let result = cipher.decode("ZYXWVU", secret: "1")
        
        XCTAssertEqual(result,"abcdef")
    }
    
    func test_EnciptionDecription(){
        let message = "message"
        let result = cipher.encode(message, secret: "1")
        let final =  cipher.decode(result, secret: "1")
        
        XCTAssertEqual(message, final)
    }
}
