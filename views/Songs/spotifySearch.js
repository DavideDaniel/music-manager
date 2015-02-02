var song = "<%= song.title  %>"
console.log( song );
var album = "<%= song.album.title %>"
console.log( album );
var artist = "<%= song.album.artist.name  %>"
console.log( artist );

var searchArtist = function ( artist ) {
  var xhr = new XMLHttpRequest();
  var url = "https://api.spotify.com/v1/search?q=artist:" + artist +
    "&type=artist"

  xhr.open( "GET", url )
  xhr.addEventListener( 'load', function ( e ) {

    var musicAct = JSON.parse( xhr.responseText )
    var container = document.querySelector( '.container' );
    console.log( musicAct.artists.items[ 0 ].name );
    console.log( musicAct.artists.items[ 0 ].popularity );
    var img = document.createElement( "img" )

    img.src = musicAct[ "artists" ][ "items" ][ 0 ][ "images" ][ 2 ].url;

    container.appendChild( img )

  } );
  xhr.send();
};
var searchTrack = function ( artist, album, song ) {
  var xhr = new XMLHttpRequest();
  var url = "https://api.spotify.com/v1/search?q=" + artist + "+" + album + "+" +
    song + "&type=track&limit=1&offset=1"
  xhr.open( "GET", url )
  xhr.addEventListener( 'load', function ( e ) {

    var track = JSON.parse( xhr.responseText )
    console.log( track );
    var id = track[ "tracks" ][ "items" ][ 0 ][ "id" ];
    var uri = track[ "tracks" ][ "items" ][ 0 ][ "uri" ];
    console.log( id );
    console.log( uri );
    generateTrack( uri );
  } );
  xhr.send();

};


var generateTrack = function ( uri ) {
  var spotFrame = document.querySelector( '.spotFrame' );
  var spotWidget = document.createElement( 'iframe' );
  spotWidget.src =
    "https://embed.spotify.com/?uri=" + uri;
  console.log( spotWidget.src );

  spotWidget.style.height = "80px";
  spotWidget.style.width = "250px";
  spotWidget.style.frameborder = "0";

  spotFrame.appendChild( spotWidget );
  var body = document.querySelector( "body" )

}

var genPlayList = function () {
  var frame = document.createElement( "iframe" )
  var frameSrc =
    "https://embed.spotify.com/?uri=spotify:trackset:PREFEREDTITLE:5Z7ygHQo02SUrFmcgpwsKW,1x6ACsKV4UdWS2FMuPFUiT,4bi73jCM02fMpkI11Lqmfe"

  frame.src = frameSrc

  body.appendChild( frame )
}