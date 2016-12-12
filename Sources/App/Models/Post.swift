import Vapor
import Fluent

final class Post: Model {
  var id: Node?
  var text: String

  // used by fluent internally
  var exists: Bool = false

  init(text: String) {
    self.text = text
  }

  init(node: Node, in context: Context) throws {
    id = try node.extract("id")
    text = try node.extract("text")
  }

  func makeNode(context: Context) throws -> Node {
    var data = [String: Node]()
    data["text"] = Node(text)

    if id != nil {
      data["id"] = id
    }

    return try Node(node: data)
  }

  static func prepare(_ database: Database) throws {
    //
  }

  static func revert(_ database: Database) throws {
    //
  }
}
