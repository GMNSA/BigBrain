function imagesGames(name) {
	switch (name) {
		case '2048':
			return "qrc:/resources/games_icons/tower.svg"
			break;
		case 'QUICK MATH':
			return "qrc:/resources/games_icons/hourglass.png"
			break;
		case 'BRAIN OVER':
			return "qrc:/resources/games_icons/brain.png"
			break;
		case 'TABLE OF GROW':
			return "qrc:/resources/games_icons/insert_table.png"
			break;
		case 'BALANCE':
			return "qrc:/resources/games_icons/balance.png"
			break;
		case 'HARD MATH':
			return "qrc:/resources/games_icons/hard_math.png"
			break;
		case 'TRUE / FALSE':
			return "qrc:/resources/games_icons/true_false.png"
			break;
		case 'MULTIPLICATION TABLE':
			return "qrc:/resources/games_icons/multiplication_table.png"
			break;
		default:
			return '-1'
	}
}
