var searchSimilar = function ( artist, echoKey ) {
  var xhr = new XMLHttpRequest();

  var echoUrl = "http://developer.echonest.com/api/v4/artist/similar?api_key="+echoKey+"&name="+artist+"&bucket=id:CAOCJCS12C028B69A6&limit=true&results=1"
  xhr.open( "GET", echoUrl )
  xhr.addEventListener( 'load', function ( e ) {

    var similarArtist = JSON.parse(xhr.responseText)


    var id = similarArtist[ "response" ][ "artists" ][ 0 ][ "id" ];
    var name = similarArtist[ "response" ][ "artists" ][ 0 ][ "name" ];

    console.log( id );
    console.log( name );
  } );
  xhr.send();

};