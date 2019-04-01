User.create!(name: "Example User",
             email: "example@railstutorial.org",
             phone: "0123456780",
             address: "88 khuong dinh stress",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
9.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  phone = "012345678#{n+1}"
  address = "#{n+1} khuong dinh stress"
  User.create!(name:  name,
               email: email,
               phone: phone,
               address: address,
               password: password,
               password_confirmation: password,
               admin: false,
               activated: true,
               activated_at: Time.zone.now)
end

10.times do |n|
  Post.create!(title: FFaker::Lorem.sentence(5),
               like_quantity: 0,
               content: FFaker::Lorem.sentence(60),
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

Pet.create!(name: "Cat", description: FFaker::Lorem.sentence(10))
Pet.create!(name: "Dog", description: FFaker::Lorem.sentence(10))
