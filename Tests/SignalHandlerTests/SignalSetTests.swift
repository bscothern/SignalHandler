import LoftTest_StandardLibraryProtocolChecks
@testable import SignalHandler
import XCTest

final class SignalSetTests: XCTestCase {
    func testConformances() throws {
        let iterations = 1_000
        for _ in  0..<iterations {
            let signals: [Signal] = Signal.allCases.filter({ _ in Int.random(in: 0...1).isMultiple(of: 2) }).sorted(by: { $0.rawValue < $1.rawValue })
            let sigset = signals.lazy
                .map(\.rawValue)
                .map {
                    sigset_t(1 << ($0 - 1))
                }
                .reduce(into: sigset_t.emptySet(), |=)

            let fromArray = SignalSet(signals: signals)
            let fromSigset_t = SignalSet(sigset)

            XCTAssertEqual(fromSigset_t, fromArray)

            fromSigset_t.checkCollectionLaws(expecting: signals)
            fromSigset_t.checkHashableLaws(equal: fromArray)
        }
    }

    func testEmptySignalSet() {
        let signalSet = SignalSet(.init())
        XCTAssertEqual(signalSet.startIndex, signalSet.endIndex)
    }

    func testFullSignalSet() {
        let signalSet = SignalSet(signals: Signal.allCases)
        XCTAssertEqual(signalSet.startIndex.offset, 0)
        XCTAssertEqual(signalSet.endIndex.offset, Signal.allCases.count)
    }

    func testInitWithVariadics() {
        let signalSet = SignalSet(signals: .abort, .floatingPointException, .illegalInstruction, .interrupt, .segmentationViolation, .termination)
        signalSet.checkCollectionLaws(expecting: [.abort, .floatingPointException, .illegalInstruction, .interrupt, .segmentationViolation, .termination].sortedByRawValue())
    }

    func testInitWithArrayLiteral() {
        let signalSet: SignalSet = [.abort, .floatingPointException, .illegalInstruction, .interrupt, .segmentationViolation, .termination]
        signalSet.checkCollectionLaws(expecting: [.abort, .floatingPointException, .illegalInstruction, .interrupt, .segmentationViolation, .termination].sortedByRawValue())
    }

    func testIndices() {
        for bit in 0..<sigset_t.emptySet().bitWidth {
            let sigset = sigset_t.emptySet() | numericCast(1 << bit)
            let signalSet = SignalSet(sigset)
            let startIndex = signalSet.startIndex
            let endIndex = signalSet.endIndex
            XCTAssertEqual(startIndex.offset, bit)
            XCTAssertEqual(endIndex.offset, bit + 1)
            XCTAssertEqual(endIndex, signalSet.index(after: startIndex))
        }
    }
}

extension Collection where Element == Signal {
    func sortedByRawValue() -> [Signal] {
        sorted(by:) { $0.rawValue < $1.rawValue }
    }
}
