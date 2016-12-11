import Vapor
import HTTP

final class PostController {
  func index(request: Request) throws -> ResponseRepresentable {
    return try Post.all().makeNode().converted(to: JSON.self)
  }

  func show(request: Request, post: Post) -> ResponseRepresentable {
    return post
  }
}

extension PostController: ResourceRepresentable {
  func makeResource() -> Resource<Post> {
    return Resource(
      index: index,
      show: show
    )
  }
}
