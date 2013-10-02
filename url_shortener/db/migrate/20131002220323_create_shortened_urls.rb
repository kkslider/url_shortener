class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|

      t.timestamps
    end
  end
end
