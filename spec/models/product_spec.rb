require 'rails_helper'

describe Product do

  let(:product) { Product.create!(name: "race bike") }
  let(:user) { User.create!(email: "firstname@lastname.com", password: "password") }

  before do
    product.comments.create!(rating: 1, user: user, body: "Awful bike!")
    product.comments.create!(rating: 3, user: user, body: "Ok bike!")
    product.comments.create!(rating: 5, user: user, body: "Great bike!")
  end

  it "returns the average rating of all comments" do
    expect(product.average_rating).to eq 3
  end

  it "is not valid without a name" do
    expect(Product.new(description: "Nice bike")).not_to be_valid
  end

  it "returns the highest rating" do
    expect(product.highest_rating_comment&.rating).to eq 5
  end

  it "returns the lowest rating" do
    expect(product.lowest_rating_comment&.rating).to eq 1
  end

  it 'finds searched product by partial name' do
    product = Product.create(name: "Product")
    @result = Product.search(search_term: "roduct")
    expect(@result.name).to eq("Product")
  end

end
