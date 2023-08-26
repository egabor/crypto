//
//  NumberShortenerUseCaseTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import XCTest
@testable import crypto

final class NumberShortenerUseCaseTests: XCTestCase {

    let numberShortener = NumberShortenerUseCase()

    func testNumberShortenerUseCase_forValidInputs_under1K_shouldReturnValidOutputs() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "1",       output: "$1.00"),
            (input: "1.0",     output: "$1.00"),
            (input: "1.00",    output: "$1.00"),
            (input: "10.0",    output: "$10.00"),
            (input: "99.99",   output: "$99.99"),
            (input: "99.999",  output: "$100.00"),
            (input: "100.00",  output: "$100.00"),
            (input: "999.99",  output: "$999.99"),
            (input: "999.999", output: "$1.00K")
        ]

        for set in dataSet {
            XCTAssertEqual(numberShortener(set.input), set.output)
        }
    }

    func testNumberShortenerUseCase_forValidInputs_under1M_shouldReturnValidOutputs() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "1000",       output: "$1.00K"),
            (input: "1000.0",     output: "$1.00K"),
            (input: "1000.00",    output: "$1.00K"),
            (input: "9999.99",    output: "$9.99K"),
            (input: "9999.999",   output: "$10.00K"),
            (input: "10000.00",   output: "$10.00K"),
            (input: "99999.99",   output: "$99.99K"),
            (input: "99999.999",  output: "$100.00K"),
            (input: "100000.00",  output: "$100.00K"),
            (input: "999999.99",  output: "$999.99K"),
            (input: "999999.999", output: "$1.00M")
        ]

        for set in dataSet {
            XCTAssertEqual(numberShortener(set.input), set.output)
        }
    }

    func testNumberShortenerUseCase_forValidInputs_under1B_shouldReturnValidOutputs() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "1000000",       output: "$1.00M"),
            (input: "1000000.0",     output: "$1.00M"),
            (input: "1000000.00",    output: "$1.00M"),
            (input: "9999999.99",    output: "$9.99M"),
            (input: "9999999.999",   output: "$10.00M"),
            (input: "10000000.00",   output: "$10.00M"),
            (input: "99999999.99",   output: "$99.99M"),
            (input: "99999999.999",  output: "$100.00M"),
            (input: "100000000.00",  output: "$100.00M"),
            (input: "999999999.99",  output: "$999.99M"),
            (input: "999999999.999", output: "$1.00B")
        ]

        for set in dataSet {
            XCTAssertEqual(numberShortener(set.input), set.output)
        }
    }

    func testNumberShortenerUseCase_forValidInputs_over1B_shouldReturnValidOutputs() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "1000000000.00",    output: "$1.00B"),
            (input: "10000000000.00",   output: "$10.00B"),
            (input: "100000000000.00",  output: "$100.00B"),
            (input: "1000000000000.00", output: "$1000.00B")
        ]

        for set in dataSet {
            XCTAssertEqual(numberShortener(set.input), set.output)
        }
    }

    func testNumberShortenerUseCase_forInvalidInputs_shouldReturnOriginalInput() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "1000000000,00",    output: "1000000000,00"),
            (input: "1,000,000,000.00", output: "1,000,000,000.00")
        ]

        for set in dataSet {
            XCTAssertEqual(numberShortener(set.input), set.output)
        }
    }
}
