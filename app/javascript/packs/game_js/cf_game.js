// app/javascript/packs/cf_game.js

function bindClickSquareEvent(){
  $(document).find(".square").on('click', function(){
    var column = $(this).attr('data-col');
    var player_id = $(this).attr('data-player-id');
    var url = $(this).attr('data-player-moves-url');

    $.post(url, {
      authenticity_token: $(document).find('meta[name="csrf-token"]').attr('content'),
      player_id: player_id,
      player_moves: { column: column }
    }, function(data, status) {});
  });
}

$(document).on('turbolinks:load', function() {
  bindClickSquareEvent();

  $(document).on("DOMSubtreeModified", ".main_board_container", function () {
    bindClickSquareEvent();
  });
});
