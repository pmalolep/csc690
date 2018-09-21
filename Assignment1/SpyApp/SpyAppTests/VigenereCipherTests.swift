/************************************/
/* Author: Peter Malolepszy         */
/* File: VigenereCipherTests.swift  */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import XCTest
@testable import SpyApp

class VigenereCipherTests: XCTestCase{
    
    var cipher: Cipher!
    
    override func setUp(){
        super.setUp()
        
        cipher = VigenereCipher()
    }
    
    func test_oneCharacterStringGetsMappedToSelfWith_0_secret(){
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "a")
        
        XCTAssertEqual(plaintext,result)
    }
    
    func test_incorrectInputForSecret(){
        let message = "message~"
        let result = cipher.encode(message, secret: "secret")
        XCTAssertEqual(result, "input string contained character(s) outside of our scope")
    }
    
    func test_EnciptionDecription(){
        let message = "message"
        let result = cipher.encode(message, secret: "secret")
        let final =  cipher.decode(result, secret: "secret")
        
        XCTAssertEqual(message, final)
    }
}
