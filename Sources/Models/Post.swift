import Vapor
import Fluent

final class Post: Model {
  var id: Node?
  var text: String?

  init(text: String) {
    self.text = text
  }

  init(node: Node, in context: Context) throws {
    id = nil
    text = try node.extract("text")
  }

  func makeNode(context: Context) throws -> Node {
    return try Node(node: [
      "id": id,
      "text": text
    ])
  }

  static func prepare(_ database: Database) throws {
    //
  }

  static func revert(_ database: Database) throws {
    //
  }
}
