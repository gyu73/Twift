import Foundation

extension Twift {
  public func getTweet(_ tweetId: Tweet.ID,
                       tweetFields: [Tweet.Fields] = [],
                       expansions: [Tweet.Expansions] = [],
                       userFields: [User.Fields] = []
  ) async throws -> TwitterAPIDataAndIncludes<Tweet, Tweet.Includes> {
    return try await call(userFields: userFields,
                          tweetFields: tweetFields,
                          expansions: expansions.map { $0.rawValue },
                          route: .tweet(tweetId),
                          expectedReturnType: TwitterAPIDataAndIncludes.self)
  }
  
  public func getTweets(_ tweetIds: [Tweet.ID],
                        tweetFields: [Tweet.Fields] = [],
                        expansions: [Tweet.Expansions] = [],
                        userFields: [User.Fields] = []
  ) async throws -> TwitterAPIDataAndIncludes<Tweet, Tweet.Includes> {
    return try await call(userFields: userFields,
                          tweetFields: tweetFields,
                          expansions: expansions.map { $0.rawValue },
                          route: .tweets(tweetIds),
                          expectedReturnType: TwitterAPIDataAndIncludes.self)
  }
}