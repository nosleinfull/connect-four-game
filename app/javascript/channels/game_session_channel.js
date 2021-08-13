import consumer from "./consumer"

function bindClickSquareEvent(){
  $(document).find(".square").on('click', function(){
    var column = $(this).attr('data-col');
    var player_id = $(this).attr('data-player-id');
    var url = $(this).attr('data-player-moves-url');

    $.post(url, {
      authenticity_token: $(document).find('meta[name="csrf-token"]').attr('content'),
      player_id: player_id,
      player_moves: { column: column }
    }, function(data, status) {
      console.log('Server data ' + data + 'status: ' + status);
    });
  });
}

document.addEventListener('turbolinks:load', () => {
  bindClickSquareEvent();
  const element = document.getElementById('game-session-id');
  const game_session_id = element.getAttribute('data-game-session-id');
  const player_id = element.getAttribute('data-player-id');

  consumer.subscriptions.create({ channel: "GameSessionChannel", id: game_session_id,
  player_id: player_id },{
    connected() {
      console.log("Connected to GameSessionChannel: ", game_session_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      if (data['data'] == 'change_board'){
        console.log('board updated!')
        $('.main_board_container').load('/game/' + player_id + '/board', bindClickSquareEvent);
      }
      console.log(data)
    }
  });
});
