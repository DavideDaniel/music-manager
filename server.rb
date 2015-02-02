require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/connection'
require_relative './lib/artist'
require_relative './lib/album'
require_relative './lib/song'
require 'pry'

echoAPIKey = ENV['ECHOAPI']

after do
  ActiveRecord::Base.connection.close
end

get("/") do

  erb(:index)
end


get("/artists") do
  erb(:"artists/index", { locals: { artists: Artist.all() } })
end

get("/artists/new") do

  erb(:"artists/new", { locals: { artists: Artist.all() } })
end

get("/artist/:id") do
  artist = Artist.find_by({id: params[:id]})
  
  erb(:"artists/show", { locals: { artist: artist } })
end

post '/artists' do
  artist_hash = {
    name: params["name"]
  }

  Artist.create(artist_hash)

  erb :"artists/index", locals: { artists: Artist.all() }
  redirect "/artists"
end


put("/artist/:id") do
  artist = Artist.find_by({id: params[:id]})
  puts "#{artist.name} is old name"
  artist_hash = {
    name: params["name"]
  }
  puts artist_hash

  artist.update(artist_hash)

  redirect ("/artists")
end

delete("/artist/:id") do
  artist = Artist.find_by({id: params[:id]})
  songs = Song.where({album_id: params[:id]} )
  albums = Album.where({artist_id: params[:id]})
  songs.each do |song|
    song.destroy
  end
  albums.each do |album|
    album.destroy
  end
  artist.destroy

  redirect "/artists"
end

get("/artist/:id/edit") do
  artist = Artist.find_by({id: params[:id]})
  erb(:"artists/edit", { locals: { artist: artist } })
end

get("/albums") do
  erb(:"albums/index", { locals: { albums: Album.all() } })
end

post("/albums") do
  album_hash = {
    title: params["title"],
    artist_id: params["artist_id"]
  }

  album = Album.create(album_hash)

  redirect"/album/#{album.id}"
end


get("/album/:id") do
  puts "Hit the route /:id"
  album = Album.find_by({id: params[:id]})

  erb(:"albums/show", { locals: { album: album } })
end



get("/album/:id/edit") do
  album = Album.find_by({id: params[:id]})

  erb(:"albums/edit", { locals: { album: album, artists: Artist.all() } })
end

put("/album/:id") do
  album_hash = {
    title: params["title"],
    artist_id: params["artist_id"]
  }

  album = Album.find_by({id: params[:id]})
  album.update(album_hash)

  erb(:"albums/show", { locals: { album: album } })
end

delete("/album/:id") do
  album = Album.find_by({id: params[:id]})
  songs = Song.where({album_id: params[:id]} )

  songs.each do |song|
    song.destroy
  end
  album.destroy

  redirect "/albums"
end

get("/albums/new") do
puts "Hit the route /new"
  erb(:"albums/new", { locals: { artists: Artist.all() } })
end

get("/songs") do

  erb(:"songs/index", { locals: { songs: Song.all() } })
end

get("/songs/new") do

  erb(:"songs/new", { locals: { albums: Album.all() } })
end

post("/songs") do
  song_hash = {
    title: params["title"],
    album_id: params["album_id"]
  }

  song = Song.create(song_hash)
  
  erb(:"songs/show", { locals: { song: song, albums: Album.all() } })

end

get("/song/:id") do
  echoKey = "#{echoAPIKey}"

  song = Song.find_by({id: params[:id]})

  erb(:"songs/show", { locals: { echoKey: echoKey, song: song } })
end

get("/song/:id/edit") do
  song = Song.find_by({id: params[:id]})
  erb(:"songs/edit", { locals: { song: song , albums: Album.all()} })
end

put("/song/:id") do
  song_hash = {
    title: params["title"],
    album_id: params["album_id"]
  }

  song = Song.find_by({id: params[:id]})
  song.update(song_hash)

  erb(:"songs/show", { locals: { song: song } })
end

delete("/song/:id") do
  song = Song.find_by({id: params[:id]})
  song.destroy

  redirect "/songs"
end