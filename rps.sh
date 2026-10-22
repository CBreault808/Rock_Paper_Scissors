#!/bin/bash

# Initialize scores
player_score=0
computer_score=0

# Array to map numbers to choices/emojis
choices=("" "🪨 Rock" "📄 Paper" "✂️ Scissors")

# Clear screen and display welcome message
clear
echo "========================================"
echo "      🪨📄✂️ BASH BATTLE! ✂️📄🪨"
echo "========================================"
echo "Welcome to the ultimate showdown!"
echo ""

# Main game loop
while true; do
    echo "Choose your weapon!"
    echo "1) Rock"
    echo "2) Paper"
    echo "3) Scissors"
    echo "Q) Quit"
    echo ""
    
    # Read user input
    read -p "Your choice: " user_input
    echo ""

    # Check for quit option (handles both uppercase and lowercase)
    if [[ "$user_input" == "Q" || "$user_input" == "q" ]]; then
        break
    fi

    # Validate that input is 1, 2, or 3
    if [[ "$user_input" != "1" && "$user_input" != "2" && "$user_input" != "3" ]]; then
        echo "❌ Invalid choice! Please select 1, 2, 3, or Q."
        echo "----------------------------------------"
        continue
    fi

    # Generate random computer choice (1 = Rock, 2 = Paper, 3 = Scissors)
    comp_choice=$(( (RANDOM % 3) + 1 ))

    # Display choices
    echo "You chose: ${choices[$user_input]}"
    echo "Computer chose: ${choices[$comp_choice]}"
    echo ""

    # Game logic
    if [ "$user_input" -eq "$comp_choice" ]; then
        echo "🤝 IT'S A TIE!"
    elif [[ "$user_input" -eq 1 && "$comp_choice" -eq 3 ]]; then
        echo "💥 ROCK CRUSHES SCISSORS!"
        echo "🏆 YOU WIN!"
        ((player_score++))
    elif [[ "$user_input" -eq 2 && "$comp_choice" -eq 1 ]]; then
        echo "💥 PAPER COVERS ROCK!"
        echo "🏆 YOU WIN!"
        ((player_score++))
    elif [[ "$user_input" -eq 3 && "$comp_choice" -eq 2 ]]; then
        echo "💥 SCISSORS CUTS PAPER!"
        echo "🏆 YOU WIN!"
        ((player_score++))
    else
        # If it's not a tie and the player didn't win, the computer won
        if [ "$comp_choice" -eq 1 ]; then
            echo "💥 ROCK CRUSHES SCISSORS!"
        elif [ "$comp_choice" -eq 2 ]; then
            echo "💥 PAPER COVERS ROCK!"
        else
            echo "💥 SCISSORS CUTS PAPER!"
        fi
        echo "💻 COMPUTER WINS!"
        ((computer_score++))
    fi

    # Display current score
    echo ""
    echo "Score:"
    echo "You: $player_score"
    echo "Computer: $computer_score"
    echo "----------------------------------------"
    echo "Play again?"
    echo ""
done

# Game over / exit section
clear
echo "========================================"
echo "              GAME OVER                "
echo "========================================"
echo "Thanks for playing!"
echo ""
echo "Final Score:"
echo "🏆 You: $player_score"
echo "💻 Computer: $computer_score"
echo "========================================"
