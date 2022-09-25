FactoryBot.define do
  factory :property do
    name { Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 0) }
    after(:create) do |property|
      property.photos.attach(io: File.open(Rails.root.join('spec/fixtures/images/cat_1.jpg')), filename: 'cat_1.jpg',
                             content_type: 'image/jpeg')
      property.photos.attach(io: File.open(Rails.root.join('spec/fixtures/images/cat_2.jpg')), filename: 'cat_2.jpg',
                             content_type: 'image/jpeg')
      property.photos.attach(io: File.open(Rails.root.join('spec/fixtures/images/cat_3.jpg')), filename: 'cat_3.jpg',
                             content_type: 'image/jpeg')
    end
  end
end
