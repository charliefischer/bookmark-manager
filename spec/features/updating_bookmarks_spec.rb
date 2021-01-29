feature 'Updating bookmarks' do
  scenario 'Updating a bookmark' do
    visit('/')
    click_button('Add Bookmark')
    fill_in('url', :with => 'http://www.twitter.com')
    fill_in('title', :with => 'Twitter Title')
    click_button("Add Bookmark")

    click_button('Edit')
    fill_in('title', :with => 'Twitter Title')
    click_button('OK')
    fill_in('title', :with => 'Tweeter')
    fill_in('url', :with => 'tweeter.com')
    click_button('Update')
    expect(page).to have_link("Tweeter", href: 'http://twitter.com')
  end
end
