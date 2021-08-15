# Connect-Four

[Connect Four Game](https://en.wikipedia.org/wiki/Connect_Four) using Ruby on Rails with Action Cable.

## App Link

Link to Game: https://softpath.com.br/

## About the code desing

The design of the code allows the extension to any web game real-time application, that has interactions of two users and has a board.

### Tree structure

A board game is rendered according to the following object (with some dependency injections):

```ruby
Game.create(
  player_one_id: player_one_id,
  player_two_id: player_two_id,
  session_data: {
    # Name of the partial view of the board game
    game_board_partial: 'cf_game/board',
    # Class responsible for processing player actions.
    player_move_processor: 'CfGame::ProcessPlayerMoves', 
    # Class responsible for processing game config updates (reset the game and whatever).
    game_updator: 'CfGame::UpdateGameSession',
    # Any custom data needed for the game and every above class
    board_matrix: board_matrix.to_a,
    player_turn: (rand 1..2),
    game_status: nil
  }
)
```

We should organize the code according to the following structure:

(Of course, we can even go further, separating the code into Gem or Rails Engines)

#### Services
```
app/
    ...
    controllers/
    game_services/
        cf_game/
        another_board_game/
    ...
```

#### Assets
```
app/
    ...
    assets/
        game_scss/
    controllers/
    ...
```

#### JavaScripts

We need require the new js in application.js (Eg: require("packs/game_js/new_game_js_file")

```
app/
    ...
    controllers/
    javascript
        packs/
            game_js/
    ...
```

#### Views
```
app/
    ...
    controllers/
    views/
        game_views/
          another_board_game_view/
    ...
```

## What to improve?

- [ ] Integrations Tests
- [ ] Finishing of some unit tests
- [ ] Refactoring of some game_services/cf_game class
- [ ] Design Active Jobs to allow bot players and AI
- [ ] Fixing of the Responsive Web Design
- [ ] Allow players to create new game sessions, sharing game session links and login of players.
- [ ] Optimizations, like move some server-side rendering to front-end and improve API (add HTTP code responses and etc)
- [ ] CSS animations


## Localhost initializing

It's recommended to use docker and docker-compose to initialize the App in localhost.

Run the following commands in the terminal to access the bash of the folder app.:
```
docker-compose up -d runner
```

```
docker exec -it connect-four-game_runner_1 bash
```

After that, we can start to run the rails server, tasks generators and etc. Eg:

```
rails s -b 0.0.0.0
bundle exec rails db:create && rails db:migrate
```
