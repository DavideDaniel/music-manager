require 'active_record'

class Album < ActiveRecord::Base
  def songs
    Song.where({album_id: self.id})
  end
  def artist
    Artist.find_by({id: self.artist_id})
  end
end
