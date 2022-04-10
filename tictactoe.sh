# tictactoe.sh

#!/bin/bash

player1="X"
player2="O"
turn=1
game_on=true
moves=( 1 2 3 4 5 6 7 8 9 )

board() {
  clear
  echo "- - - - - - -"
  echo "| ${moves[0]} | ${moves[1]} | ${moves[2]} |"
  echo "- - - - - - -"
  echo "| ${moves[3]} | ${moves[4]} | ${moves[5]} |"
  echo "- - - - - - -"
  echo "| ${moves[6]} | ${moves[7]} | ${moves[8]} |"
  echo "- - - - - - -"
  echo " "
}

player_move() {
  if [[ $(($turn % 2)) == 0 ]]
  then
    play=$player2
    echo -n "Gracz 2 podaje pole: "
  else
    echo -n "Gracz 1 podaje pole: "
    play=$player1
  fi

  read field

  space=${moves[($field - 1)]} 

  if [[ ! $field =~ ^[1-9]$ ]] || [[ ! $space =~ ^[1-9]$ ]]
  then 
    echo "Podales niepoprawne pole"
    player_move
  else
    moves[($field - 1)]=$play
    ((turn=turn + 1))
  fi

  space=${moves[($field - 1)]} 
}

check_match() {
  if [[ ${moves[$1]} == ${moves[$2]} ]] && [[ ${moves[$2]} == ${moves[$3]} ]]
  then
    game_on=false
  fi

  if [ $game_on == false ]
  then
    if [ ${moves[$1]} == 'X' ]
    then
      echo "Wynik: gracz 1 wygrywa"
      return 
    else
      echo "Wynik: gracz 2 wygrywa"
      return 
    fi
  fi
}

check_winner() {
  if [ $game_on == false ]; then return; fi
  check_match 0 1 2
  if [ $game_on == false ]; then return; fi
  check_match 3 4 5
  if [ $game_on == false ]; then return; fi
  check_match 6 7 8
  if [ $game_on == false ]; then return; fi
  check_match 0 4 8
  if [ $game_on == false ]; then return; fi
  check_match 2 4 6
  if [ $game_on == false ]; then return; fi
  check_match 0 3 6
  if [ $game_on == false ]; then return; fi
  check_match 1 4 7
  if [ $game_on == false ]; then return; fi
  check_match 2 5 8
  if [ $game_on == false ]; then return; fi

  if [ $turn -gt 9 ]
  then 
    $game_on=false
    echo "Wynik: remis"
  fi
}

board

while $game_on
do
  player_move
  board
  check_winner
done

$SHELL