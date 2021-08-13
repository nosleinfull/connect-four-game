// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'materialize-css/dist/js/materialize'

require("jquery")
require("packs/game_js/cf_game")

function bindClickResetGameButton(){
  $(document).find(".reset-game-btn").on('click', function(){

    var url = $(this).attr('data-update-game-url');

    $.ajax({
       type: 'PATCH',
       url: url,
       data: { authenticity_token: $(document).find('meta[name="csrf-token"]').attr('content'), reset: true }
    });
  });
}

$(document).on('turbolinks:load', function() {
  bindClickResetGameButton();
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
