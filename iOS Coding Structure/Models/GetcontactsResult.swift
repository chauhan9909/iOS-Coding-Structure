//
//  GetcontactsResult.swift
//
//  Created by WOS on 14/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct GetcontactsResult {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let data = "data"
    static let message = "message"
    static let totalContacts = "TotalContacts"
  }

  // MARK: Properties
  public var status: Int?
  public var data: [DataContact]?
  public var message: String?
  public var totalContacts: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    status = json[SerializationKeys.status].int
    if let items = json[SerializationKeys.data].array { data = items.map { DataContact(json: $0) } }
    message = json[SerializationKeys.message].string
    totalContacts = json[SerializationKeys.totalContacts].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = totalContacts { dictionary[SerializationKeys.totalContacts] = value }
    return dictionary
  }

}
