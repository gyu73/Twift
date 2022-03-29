//
//  UserLikes.swift
//  Twift_SwiftUI
//
//  Created by Daniel Eden on 19/01/2022.
//

import SwiftUI
import Twift

struct UserLikes: View {
  @EnvironmentObject var twitterClient: Twift
  @State var tweets: [Tweet]?
  @State var errors: [TwitterAPIError] = []
  
  @State var includes: Tweet.Includes?
  
  @SceneStorage("userId") var userId = ""
  
  var body: some View {
    Form {
      Section {
        TextField("User ID", text: $userId)
          .keyboardType(.numberPad)
        
        AsyncButton(action: {
          do {
            let result = try await twitterClient.getLikedTweets(
              for: userId,
              fields: Set(Tweet.publicFields),
                 expansions: [.authorId(userFields: [\.profileImageUrl])]
            )
            
            withAnimation {
              tweets = result.data
              includes = result.includes
              errors = result.errors ?? []
            }
          } catch {
            if let error = error as? TwitterAPIError {
              withAnimation { errors = [error] }
            } else if let error = (error as? TwitterAPIManyErrors)?.errors {
              withAnimation { errors = error }
            } else {
              print(error.localizedDescription)
            }
          }
        }) {
          Text("Get user likes")
        }
        .disabled(userId.isEmpty)
      }
      
      TweetsMethodView(tweets: tweets, errors: errors, includes: includes)
    }.navigationTitle("Get User Likes")
  }
}

struct UserLikes_Previews: PreviewProvider {
    static var previews: some View {
        UserLikes()
    }
}