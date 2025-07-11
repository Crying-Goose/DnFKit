//
//  TransObjectTests.swift
//  DnFKit
//
//  Created by 라주영 on 4/28/25.
//

import XCTest
@testable import DnFKit

final class DnFKitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetCharacters() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let name = "라주팔"

        // ✅ 실행
        let result = try await apiService.getCharacters(name: name)

        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testGetCharacter() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let name = "라주팔"
        let server = "cain"

        // ✅ 실행
        let result = try await apiService.getCharacter(server: server, name: name)

        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testGetCharacterInfo() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"

        // ✅ 실행
        let result = try await apiService.getCharacterInfo(server: server, id: id)

        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testGetCharacterEquipment() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"

        // ✅ 실행
        let result = try await apiService.getEquipment(server: server, id: id)

        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testGetCharacterCreature() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"
        
        // ✅ 실행
        let result = try await apiService.getCreature(server: server, id: id)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testFetchInfo() async throws {
        // ✅ 준비
        let repository = DnFRepository()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"
        
        // ✅ 실행
        let result = try await repository.fetchDnFCharacterInfo(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
}
