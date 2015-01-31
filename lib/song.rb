require 'active_record'

class Song < ActiveRecord::Base
  def albums
    Album.find_by({id: self.album_id})
  end
end
