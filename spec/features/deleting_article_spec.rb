require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    @john = User.create!(email: "john@example.com", password:"password")
    visit "/"
    click_link "Sign in"
    fill_in "Email",  with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"

    @article = Article.create(title: "the first article", body: "body of first article")
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end