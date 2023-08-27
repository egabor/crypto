//
//  PercentageFormatterUseCaseTests.swift
//  cryptoTests
//
//  Created by Eszenyi Gábor on 2023. 08. 26..
//

import XCTest
@testable import crypto

final class PercentageFormatterUseCaseTests: XCTestCase {

    let percentageFormatter = PercentageFormatterUseCase()

    func test_percentageFormatter_forValidInputs_shouldReturnValidOutputs() throws {
        let dataSet: [(input: String, output: String)] = [
            (input: "0.01",  output: "0.01%"),
            (input: "0.015", output: "0.02%"),
            (input: "0.1",   output: "0.10%"),
            (input: "1",     output: "1.00%"),
            (input: "1.0",   output: "1.00%"),
            (input: "10.0",  output: "10.00%"),
            (input: "99.99",  output: "99.99%"),
            (input: "100.0",  output: "100.00%")
        ]

        for set in dataSet {
            XCTAssertEqual(percentageFormatter(set.input), set.output)
        }
    }
}
