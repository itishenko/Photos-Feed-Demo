// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
import RxSwift
@testable import Demo


// MARK: - PhotosListInteractorProtocol
open class PhotosListInteractorProtocolMock: PhotosListInteractorProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getPhotos(page: Int, limit: Int) -> Single<[Photo]> {
        addInvocation(.m_getPhotos__page_pagelimit_limit(Parameter<Int>.value(`page`), Parameter<Int>.value(`limit`)))
		let perform = methodPerformValue(.m_getPhotos__page_pagelimit_limit(Parameter<Int>.value(`page`), Parameter<Int>.value(`limit`))) as? (Int, Int) -> Void
		perform?(`page`, `limit`)
		var __value: Single<[Photo]>
		do {
		    __value = try methodReturnValue(.m_getPhotos__page_pagelimit_limit(Parameter<Int>.value(`page`), Parameter<Int>.value(`limit`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getPhotos(page: Int, limit: Int). Use given")
			Failure("Stub return value not specified for getPhotos(page: Int, limit: Int). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getPhotos__page_pagelimit_limit(Parameter<Int>, Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_getPhotos__page_pagelimit_limit(let lhsPage, let lhsLimit), .m_getPhotos__page_pagelimit_limit(let rhsPage, let rhsLimit)):
                guard Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getPhotos__page_pagelimit_limit(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getPhotos(page: Parameter<Int>, limit: Parameter<Int>, willReturn: Single<[Photo]>...) -> MethodStub {
            return Given(method: .m_getPhotos__page_pagelimit_limit(`page`, `limit`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPhotos(page: Parameter<Int>, limit: Parameter<Int>, willProduce: (Stubber<Single<[Photo]>>) -> Void) -> MethodStub {
            let willReturn: [Single<[Photo]>] = []
			let given: Given = { return Given(method: .m_getPhotos__page_pagelimit_limit(`page`, `limit`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<[Photo]>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getPhotos(page: Parameter<Int>, limit: Parameter<Int>) -> Verify { return Verify(method: .m_getPhotos__page_pagelimit_limit(`page`, `limit`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getPhotos(page: Parameter<Int>, limit: Parameter<Int>, perform: @escaping (Int, Int) -> Void) -> Perform {
            return Perform(method: .m_getPhotos__page_pagelimit_limit(`page`, `limit`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PhotosListModuleOutput
open class PhotosListModuleOutputMock: PhotosListModuleOutput, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func openDetails(for photo: Photo) {
        addInvocation(.m_openDetails__for_photo(Parameter<Photo>.value(`photo`)))
		let perform = methodPerformValue(.m_openDetails__for_photo(Parameter<Photo>.value(`photo`))) as? (Photo) -> Void
		perform?(`photo`)
    }


    fileprivate enum MethodType {
        case m_openDetails__for_photo(Parameter<Photo>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_openDetails__for_photo(let lhsPhoto), .m_openDetails__for_photo(let rhsPhoto)):
                guard Parameter.compare(lhs: lhsPhoto, rhs: rhsPhoto, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_openDetails__for_photo(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func openDetails(for photo: Parameter<Photo>) -> Verify { return Verify(method: .m_openDetails__for_photo(`photo`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func openDetails(for photo: Parameter<Photo>, perform: @escaping (Photo) -> Void) -> Perform {
            return Perform(method: .m_openDetails__for_photo(`photo`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

