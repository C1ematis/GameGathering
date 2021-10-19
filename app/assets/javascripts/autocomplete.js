$(document).on('turbolinks:load', function () {
  const dataListTitle = function(request, response) {
    $.ajax({
      url: '/autocomplete_games/' + extractLast( request.term ),
      dataType: 'json',
      type: 'GET',
      cache: true,
      success: function(data) {
        response(data);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        response(['']);
      }
    });
  }
  const dataListTag = function(request, response) {
    $.ajax({
      url: '/autocomplete_tags/' + extractLast( request.term ),
      dataType: 'json',
      type: 'GET',
      cache: true,
      success: function(data) {
        response(data);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        response(['']);
      }
    });
  }
  function split( val ) {
    return val.split( /\s/ );
  }
  function extractLast( term ) {
    return split( term ).pop();
  }
  $('.autocomplete-title').autocomplete({
    source: dataListTitle,
    delay: 300,
    search: function() {
      var term = extractLast( this.value );
      if ( term.length < 1 ) {
        return false;
      }
    },
    select: function( event, ui ) {
      var terms = split( this.value );
      terms.pop();
      terms.push( ui.item.value );
      terms.push( "" );
      this.value = terms.join( " " );
      return false;
    }
  })
  $('.autocomplete-tag').autocomplete({
    source: dataListTag,
    delay: 300,
    search: function() {
      var term = extractLast( this.value );
      if ( term.length < 1 ) {
        return false;
      }
    },
    select: function( event, ui ) {
      var terms = split( this.value );
      terms.pop();
      terms.push( ui.item.value );
      terms.push( "" );
      this.value = terms.join( " " );
      return false;
    }
  })
});