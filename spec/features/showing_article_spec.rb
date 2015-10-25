require 'rails_helper'

RSpec.feature "showing Articles" do
  before do
    @john = User.create!(email: "john@example.com", password:"password")
    @fred = User.create!(email: "fred@example.com", password:"password")

    @article = Article.create(title: "the first article", body: "body of first article", user: @john)
  end

  scenario "A non-signed in user does not see Edit or Delete links" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A non-owning user does not see Edit or Delete links" do
    login_as @fred

    visit "/"

    click_link @article.title

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "An owning user does see Edit or Delete links" do
    login_as @john

    visit "/"

    click_link @article.title

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
