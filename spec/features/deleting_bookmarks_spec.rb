feature "deleting bookmarks" do

  scenario "deeleting a bookmark from the table" do
    visit('/bookmarks/new')
    fill_in('url', :with => 'http://www.twitter.com')
    fill_in('title', :with => 'Twitter Title')
    click_button("Add bookmark")
    expect(page).to have_content('Twitter Title')

    visit ('/bookmarks/delete')
    fill_in('title', :with => 'Twitter Title')
    click_button("Delete bookmark")
    expect(page).to_not have_content('Twitter Title')
  end

end
