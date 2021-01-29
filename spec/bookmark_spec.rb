require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Website')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Website'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("TRUNCATE bookmarks;")
      
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.create' do
    it "creates a new bookmark" do
      bookmark = Bookmark.create(url: 'http://www.twitter.com', title: 'Twitter Website')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.url).to include 'http://www.twitter.com'
      expect(bookmark.title).to include 'Twitter Website'
    end
  end

  describe '.delete' do
    it "deletes an existing bookmark" do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("TRUNCATE bookmarks;")

      bookmark = Bookmark.create(title: 'Twitter Title', url: 'http://www.twitter.com')
      Bookmark.delete(title: bookmark.title)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Find Me', url: 'http://lostandfound.com')
      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Find Me'
      expect(result.url).to eq 'http://lostandfound.com'
    end
  end
end
