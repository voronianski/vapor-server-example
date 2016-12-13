import Vapor
import Fluent

final class Post: Model {
  var id: Node? // required to conform Fluent protocol
  var _id: Node? // required to store correct value in db
  var text: String

  // used by fluent internally
  var exists: Bool = false

  init(text: String) {
    self.text = text
  }

  init(node: Node, in context: Context) throws {
    id = try node.extract("id")
    _id = try node.extract("_id")
    text = try node.extract("text")
  }

  func makeNode(context: Context) throws -> Node {
    return try Node(node: [
      "_id": id, // we don't want to double values in response
      "text": text
    ])
  }

  func merge(_ updates: Post) {
    text = updates.text
  }

  static func prepare(_ database: Database) throws {
    // implementation is not needed in case of mongodb
  }

  static func revert(_ database: Database) throws {
    //
  }
}
