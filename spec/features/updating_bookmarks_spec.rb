feature 'Updating bookmarks' do
  scenario 'Updating a bookmark' do

    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("TRUNCATE bookmarks;")

    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit('/bookmarks')
    expect(page).to have_link('Google', href:'http://www.google.com')

    click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('title', :with => 'Twitter')
    fill_in('url', :with => 'twitter.com')
    click_button('Submit')
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Google', href: 'http://google.com')
    expect(page).to have_link("Twitter", href: 'twitter.com')
  end
end
