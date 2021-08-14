import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
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
      $('.main_board_container').load('/game/' + player_id + '/board');
      console.log(data)
    }
  });
});
