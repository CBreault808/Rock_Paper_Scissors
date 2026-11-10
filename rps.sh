#!/bin/bash

# --- COLOR DEFINITIONS ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color (Reset)

# --- MOVE-SPECIFIC TRASH TALK ARRAYS ---
# Computer Loses (Player Wins)
WIN_ROCK_INSULTS=("Lucky guess. My scissors were rusty anyway." "You crushed me, but you're still a tool.")
WIN_PAPER_INSULTS=("Paper? Creative. Did you graduate from origami school?" "Oh look, you covered me. Thrilling.")
WIN_SCISSORS_INSULTS=("Cutting my paper doesn't make you sharp." "Fine, you snipped me. Want a gold star?")

# Computer Wins (Player Loses)
LOSS_ROCK_INSULTS=("My rock absolutely pulverized you." "Did you really think papering over this loss would help?")
LOSS_PAPER_INSULTS=("Suffocated by paper. How embarrassing." "You just got wrapped up and thrown away.")
LOSS_SCISSORS_INSULTS=("Sliced and diced. You never stood a chance." "Running with scissors? Clearly you can't even play with them.")

# Ties
TIE_ROCK_INSULTS=("Two rocks hitting each other. Just like our brains right now." "Rock on rock. Riveting gameplay.")
TIE_PAPER_INSULTS=("A double paper trail. Are we doing taxes or playing a game?" "Two papers. Are we starting a library?")
TIE_SCISSORS_INSULTS=("Scissor me timbers. Try something else." "Don't cross blades with me.")


# --- Initialize scores ---
player_score=0
computer_score=0

# --- Initialize Stats ---
total_games=0
ties_count=0

# --- Array to map numbers to choices/emojis ---
choices=("" "🪨 Rock" "📄 Paper" "✂️ Scissors")

# --- Clear screen and display welcome message ---
clear
echo "========================================"
echo "      🪨📄✂️ BASH BATTLE! ✂️📄🪨"
echo "========================================"
echo "Welcome to the ultimate showdown!"
echo ""

# --- MAIN GAME LOOP ---
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
    # Begins tracking total number of games
    ((total_games++))

    # Display choices
    echo "You chose: ${choices[$user_input]}"
    echo "Computer chose: ${choices[$comp_choice]}"
    echo ""

    # Game logic
    if [ "$user_input" -eq "$comp_choice" ]; then
        ((ties_count++))
        # Handle Tie Insults
        case "$comp_choice" in
            1) TAUNT=${TIE_ROCK_INSULTS[$RANDOM % ${#TIE_ROCK_INSULTS[@]}]} ;;
            2) TAUNT=${TIE_PAPER_INSULTS[$RANDOM % ${#TIE_PAPER_INSULTS[@]}]} ;;
            3) TAUNT=${TIE_SCISSORS_INSULTS[$RANDOM % ${#TIE_SCISSORS_INSULTS[@]}]} ;;
        esac
        echo -e "${YELLOW}🤝 IT'S A TIE! $TAUNT${NC}"
    
    # Player wins 
    elif [[ "$user_input" -eq 1 && "$comp_choice" -eq 3 ]]; then
        INSULT=${WIN_ROCK_INSULTS[$RANDOM % ${#WIN_ROCK_INSULTS[@]}]}
        echo "💥 ROCK CRUSHES SCISSORS!"
        echo -e "${GREEN}🏆 YOU WIN! $INSULT${NC}"
        ((player_score++))
    elif [[ "$user_input" -eq 2 && "$comp_choice" -eq 1 ]]; then
        INSULT=${WIN_PAPER_INSULTS[$RANDOM % ${#WIN_PAPER_INSULTS[@]}]}
        echo "💥 PAPER COVERS ROCK!"
        echo -e "${GREEN}🏆 YOU WIN! $INSULT${NC}"
        ((player_score++))
    elif [[ "$user_input" -eq 3 && "$comp_choice" -eq 2 ]]; then
        INSULT=${WIN_SCISSORS_INSULTS[$RANDOM % ${#WIN_SCISSORS_INSULTS[@]}]}
        echo "💥 SCISSORS CUTS PAPER!"
        echo -e "${GREEN}🏆 YOU WIN! $INSULT${NC}"
        ((player_score++))
    else
        # Computer wins
        case "$comp_choice" in
            1)
                echo "💥 ROCK CRUSHES SCISSORS!"
                INSULT=${LOSS_ROCK_INSULTS[$RANDOM % ${#LOSS_ROCK_INSULTS[@]}]}
                ;;
            2)
                echo "💥 PAPER COVERS ROCK!"
                INSULT=${LOSS_PAPER_INSULTS[$RANDOM % ${#LOSS_PAPER_INSULTS[@]}]}
                ;;
            3)
                echo "💥 SCISSORS CUTS PAPER!"
                INSULT=${LOSS_SCISSORS_INSULTS[$RANDOM % ${#LOSS_SCISSORS_INSULTS[@]}]}
                ;;
        esac
        echo -e "${RED}💻 COMPUTER WINS! $INSULT${NC}"
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

# --- GAME OVER / EXIT SECTION ---
clear
echo "========================================"
echo "              GAME OVER                "
echo "========================================"
echo "Thanks for playing!"
echo ""
echo "Final Score:"
echo "🏆 You: $player_score"
echo "💻 Computer: $computer_score"
echo ""
echo "--- Final Game Statistics ---"
echo "Total Games Played: $total_games"
echo "Wins: $player_score"
echo "Losses: $computer_score"
echo "Ties: $ties_count"

# Calculate win percentage using awk which handles floating integers
if [ "$total_games" -gt 0 ]; then
    win_percentage=$(awk "BEGIN {print ($player_score / $total_games) * 100}")
    printf "Win Percentage: %.2f%%\n" "$win_percentage"
else
    echo "Win Percentage: 0.00%"
fi
echo "========================================"
