//
//  DataBinding.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 04/12/2022.
//

import Foundation
import Combine

//func bind<T>(_ pub: AnyPublisher<T, Never>,
//             _ completion: @escaping (T) -> Void) -> AnyCancellable {
//  return pub
//    .receive(on: DispatchQueue.main)
//    .sink(receiveValue: completion)
//}

//class DataBinding<T> {
//  let pub: AnyPublisher<T, Never>
//  private var connections: [String: Cancellable] = [:]
//
//  init(_ pub: AnyPublisher<T, Never>) {
//    self.pub = pub
//  }
//
//  @discardableResult
//  func receive(_ connection: @escaping (T) -> Void) -> String {
//    let connectionId = UUID().uuidString
//    connections[connectionId] = pub.receive(on: DispatchQueue.main).sink(receiveValue: connection)
//    return connectionId
//  }
//
//  func disconnect(_ connectionId: String) {
//    connections[connectionId]?.cancel()
//    connections[connectionId] = nil
//  }
//
//  func map<U>(_ transform: @escaping (T) -> U) -> DataBinding<U> {
//    return DataBinding<U>(pub.map(transform).eraseToAnyPublisher())
//  }
//
//  func compactMap<U>(_ transform: @escaping (T) -> U?) -> DataBinding<U> {
//    return DataBinding<U>(pub.compactMap(transform).eraseToAnyPublisher())
//  }
//
//  func flatMap<U>(_ transform: @escaping (T) -> AnyPublisher<U, Never>) -> DataBinding<U> {
//    return DataBinding<U>(pub.flatMap(transform).eraseToAnyPublisher())
//  }
//
//  func flatMap<U>(_ transform: @escaping (T) -> DataBinding<U>) -> DataBinding<U> {
//    return flatMap { transform($0).pub }
//  }
//}
