require 'rails_helper'

RSpec.describe 'properties/show', type: :view do
  before(:each) do
    @property = assign(:property, Property.create!(
                                    name: 'Name',
                                    photos: [
                                      {
                                        io: File.open(Rails.root.join('spec/fixtures/images/cat_1.jpg')),
                                        filename: 'cat_1.jpg',
                                        content_type: 'image/jpeg'
                                      },
                                      {
                                        io: File.open(Rails.root.join('spec/fixtures/images/cat_2.jpg')),
                                        filename: 'cat_2.jpg',
                                        content_type: 'image/jpeg'
                                      },
                                      {
                                        io: File.open(Rails.root.join('spec/fixtures/images/cat_3.jpg')),
                                        filename: 'cat_3.jpg',
                                        content_type: 'image/jpeg'
                                      }
                                    ]
                                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
