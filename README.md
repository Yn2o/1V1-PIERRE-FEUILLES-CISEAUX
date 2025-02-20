# 1V1-PIERRE-FEUILLES-CISEAUX

Inscription : Les joueurs TRUMP et POUTINE s'inscrivent en appelant inscrireTrump() et inscrirePoutine().

Choix des joueurs : Chaque joueur choisit entre "pierre", "feuille" ou "ciseaux" en appelant faiteVotreChoix(<choix>) avec la réponse correcte en minuscule.

Résolution : Le jeu détermine le gagnant en comparant les choix des joueurs.

Égalité : Si les choix sont identiques, les joueurs refont leurs choix.

Fin du jeu : Le gagnant est annoncé et le jeu se termine. Vous pouvez recommencer avec reinitialiserJeu() si vous le souhaitez.


Pour suivre le jeu via les logs (événements), voici ce que vous devez savoir :

Logs des choix des joueurs : Lorsque chaque joueur fait son choix, un événement est émis pour l’informer de son choix et de l’état du jeu. Vous verrez des messages comme :

"TRUMP, vous êtes le Joueur 1. Faites votre choix: pierre, feuille ou ciseaux."
"POUTINE, vous êtes le Joueur 2. Faites votre choix: pierre, feuille ou ciseaux."
Log du résultat de la partie : Après chaque tour, vous pouvez suivre l’évolution avec des messages comme :

"Duel engagé entre TRUMP et POUTINE."
"Le gagnant est TRUMP." ou "Il y a une égalité ! Refaites vos choix."
Fin de la partie : Lorsque la partie se termine, un message final est logué pour annoncer le résultat :

"Le gagnant est TRUMP."
"Le jeu est terminé. Merci d'avoir joué !"





