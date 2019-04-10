FactoryBot.define do
  factory :like do
    user_id { 2 }
    status {1}
    post_id { 2 }

    after(:build) do |comment|
      user = FactoryBot.create :user
      comment.user_id = user.id
    end

    after(:build) do |comment|
      post = FactoryBot.create :post
      comment.post_id = post.id
    end
  end
end
