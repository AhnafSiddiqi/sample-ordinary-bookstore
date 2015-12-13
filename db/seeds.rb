20.times do |k|
  if (k % 5) == 0 || (k % 3) == 0
    format = 'hardcover'
  else
    format = 'softcover'
  end

  Book.create(
    isbn13: Faker::Code.isbn(13),
    title: Faker::Book.title,
    format: format,
    publisher: Faker::Book.publisher,
    year_of_publication: Faker::Number.between(1900, 2015),
    copies: Faker::Number.number(1),
    keywords: "#{Faker::Lorem.word}, #{Faker::Lorem.word}",
    subject: Faker::Book.genre,
    price: Faker::Commerce.price,
    authors: "#{Faker::Book.author}, #{Faker::Book.author}"
  )
end

password = BCrypt::Password.create('123')
u = User.create(id: 1, login_id: 'storemanager@bookz.com', password_digest: password)
StoreManager.create(id: u.id, name: 'Bruce Wayne')
