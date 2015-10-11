require 'rails_helper'

RSpec.feature "showing Articles" do
  before do
    @article = Article.create(title: "the first article", body: "body of first article")
  end

  scenario "display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
