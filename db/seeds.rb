User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
10.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false,
               activated: true,
               activated_at: Time.zone.now)
end

10.times do |n|
  Post.create!(title: FFaker::Lorem.sentence(5),
               like_quantity: 0,
               content: FFaker::Lorem.sentence(15),
               sumary: FFaker::Lorem.sentence(5),
               status: 1)
end

10.times do |n|
  10.times do |m|
    Comment.create!(post_id: m+1,
              user_id: n+1,
              content: FFaker::Lorem.sentence(10)
    )
  end
end

20.times do |n|
  Service.create!(name: FFaker::Lorem.sentence(3),
                  status: 1,
                  price: FFaker::Random.rand(10..99),
                  description: FFaker::Lorem.sentence(10))
end

10.times do |n|
  Pet.create!(name: FFaker::Lorem.sentence(3),
              user_id: FFaker::Random.rand(2..10),
              breed: FFaker::Lorem.sentence(1),
              gender: "Male",
              weight: FFaker::Random.rand(2..10),
              height: FFaker::Random.rand(2..10),)
end

10.times do |n|
  Pet.create!(name: FFaker::Lorem.sentence(2),
              user_id: FFaker::Random.rand(2..10),
              breed: FFaker::Lorem.sentence(1),
              gender: "Female",
              weight: FFaker::Random.rand(2..10),
              height: FFaker::Random.rand(2..10),)
end
