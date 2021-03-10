require 'rails_helper'

RSpec.feature "Visitor navigates to product page from home page through clicking on specific product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  
  scenario "User sees product details" do
    # ACT
    visit root_path
    find_link("Details", match: :first).click
    visit "/products/1"
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content 'Quantity'
    expect(page).to have_css 'article.product-detail'
  end
end