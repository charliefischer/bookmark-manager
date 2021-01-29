feature "adding bookmarks" do
  scenario "adding a new URL to bookmark list" do
    visit('/bookmarks/new')
    fill_in('url', :with => 'http://www.twitter.com')
    fill_in('title', :with => 'Twitter')
    click_button("Add bookmark")

    expect(page).to have_link("Twitter", href: 'http://www.twitter.com')
  end
  scenario "the bookmark must be a valid URL" do
    visit('/bookmarks/new')
    fill_in('url', with: 'not a real bookmark')
    click_button('Add bookmark')

    expect(page).to have_content "You must submit a valid URL."
  end 
end
