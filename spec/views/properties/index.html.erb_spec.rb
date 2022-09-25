require 'rails_helper'

RSpec.describe "properties/index", type: :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        name: "Name",
        photos: [
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_1.jpg')), filename: 'cat_1.jpg', content_type: 'image/jpeg'},
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_2.jpg')), filename: 'cat_2.jpg', content_type: 'image/jpeg'},
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_3.jpg')), filename: 'cat_3.jpg', content_type: 'image/jpeg'}
        ]
      ),
      Property.create!(
        name: "Name",
        photos: [
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_1.jpg')), filename: 'cat_1.jpg', content_type: 'image/jpeg'},
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_2.jpg')), filename: 'cat_2.jpg', content_type: 'image/jpeg'},
          {io: File.open(Rails.root.join('spec/fixtures/images/cat_3.jpg')), filename: 'cat_3.jpg', content_type: 'image/jpeg'}
        ]
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "p>strong", text: "Name:".to_s, count: 2
  end
end
