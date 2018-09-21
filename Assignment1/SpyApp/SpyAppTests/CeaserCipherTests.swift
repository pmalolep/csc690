/************************************/
/* Author: Peter Malolepszy         */
/* File: CeaserCipherTests.swift    */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import XCTest
@testable import SpyApp

class CeaserCipherTests: XCTestCase{
    
    var cipher: Cipher!

    override func setUp(){
        super.setUp()
        
        cipher = CeaserCipher()
    }
    
    func test_oneCharacterStringGetsMappedToSelfWith_0_secret(){
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(plaintext,result)
    }
    
    func test_nonNumericInputForSecret(){
        let result = cipher.encode("b", secret: "nonNumericString")
        
        XCTAssertEqual(result, "Secret must be a number for this cipher type")
    }
    
    func test_basicEnciption(){
        let result = cipher.encode("abcdefg", secret: "1")
        
        XCTAssertEqual(result,"bcdefgh")
    }
    
    func test_basicDecription(){
        let result = cipher.decode("bcdefgh", secret: "1")
        
        XCTAssertEqual(result,"abcdefg")
    }
    
    func test_EnciptionDecription(){
        let message = "message"
        let result = cipher.encode(message, secret: "1")
        let final =  cipher.decode(result, secret: "1")
        
        XCTAssertEqual(message, final)
    }
}
