require 'active_record'

class Artist < ActiveRecord::Base
  def albums
    Album.where({artist_id: self.id})
  end
end
