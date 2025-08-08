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
    
    func testGetBuffs() async throws {
        // ✅ 준비
        let apiService = DnFService()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"

        // ✅ 실행
        let result1 = try await apiService.getBuffEquipment(server: server, id: id)
        let result2 = try await apiService.getBuffAvatar(server: server, id: id)
        let result3 = try await apiService.getBuffCreature(server: server, id: id)
        
        // ✅ 출력
        print(result1)
        print(result2)
        print(result3)

        // ✅ 검증
        XCTAssertNoThrow(result1)
        XCTAssertNoThrow(result2)
        XCTAssertNoThrow(result3)
        XCTAssertNotNil(result1, "검색 결과가 없음")
        XCTAssertNotNil(result2, "검색 결과가 없음")
        XCTAssertNotNil(result3, "검색 결과가 없음")
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
    
    func testFetchEquipment() async throws {
        // ✅ 준비
        let repository = DnFRepository()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"
        
        // ✅ 실행
        let result = try await repository.fetchDnFCharacterEquipment(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testFetchBuffs() async throws {
        // ✅ 준비
        let repository = DnFRepository()
        let id = "6797474a796842ef65e46424773b8d25"
        let server = "cain"
        
        // ✅ 실행
        let result = try await repository.fetchDnFCharacterBuffs(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testFetchTimeline() async throws {
        // ✅ 준비
        let repository = DnFRepository()
        let id = "96b4b30b29b96bdaa835ba3def65efc2"
        let server = "cain"
        
        // ✅ 실행
        let result = try await repository.fetchDnFTimeline(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testItemSearch() async throws {
        // ✅ 준비
        let repository = DnFRepository()
        let name = "요기"
        
        // ✅ 실행
        let result = try await repository.fetchDnFItems(name: name)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testEquipmentInfo() async throws {
        // ✅ 준비
        let useCase = EquipmentUseCase(repository: DnFRepository())
        let id = "715119fb55abb595ef7889739782227b"
        let server = "cain"
        
        // ✅ 실행
        let result = try await useCase.characterEquipInfo(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
    
    func testFetchEditBuffs() async throws {
        // ✅ 준비
        let useCase = EquipmentUseCase(repository: DnFRepository())
        let id = "715119fb55abb595ef7889739782227b"
        let server = "cain"
        
        // ✅ 실행
        let result = try await useCase.characterBuffs(server: server, id: id)
        
        // ✅ 출력
        print(result)
        
        // ✅ 검증
        XCTAssertNoThrow(result)
        XCTAssertNotNil(result, "검색 결과가 없음")
    }
}
