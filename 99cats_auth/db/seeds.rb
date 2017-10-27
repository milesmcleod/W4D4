# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CAT_COLORS = %w(purple burnt_orange glass crocodile_skin
volcanic water bluish rainbow fuzzy spotted white)

10.times do
  Cat.create(birth_date: Date.yesterday,
    color: CAT_COLORS.sample,
    name: Faker::Cat.name,
    sex: ['M', 'F'].sample,
    description: Faker::Cat.breed,
    user_id: [1, 2, 3, 4, 5].sample
  )
end

5.times do
  User.create(
    username: Faker::Hacker.noun,
    password_digest: BCrypt::Password.create("password"),
    session_token: SecureRandom::urlsafe_base64
  )
end
