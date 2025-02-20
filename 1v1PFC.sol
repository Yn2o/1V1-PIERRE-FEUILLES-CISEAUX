// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DuelEliminatoire {
    address public owner;
    address public joueur1;
    address public joueur2;
    string public choixJoueur1;
    string public choixJoueur2;
    address public gagnant;
    bool public jeuActif = true;

    event ChoixAttendu(address joueur, string message);
    event ChoixEffectue(address joueur, string choix);
    event GagnantDeclare(address gagnant);
    event JeuTermine(string message);

    constructor() {
        owner = msg.sender;
    }

    // Fonction pour inscrire le joueur 1 (TRUMP)
    function inscrireTrump() public {
        require(jeuActif, "Le jeu est termine.");
        require(joueur1 == address(0), "TRUMP est deja inscrit.");
        joueur1 = msg.sender;
        emit ChoixAttendu(joueur1, "Vous etes TRUMP. Faites votre choix: pierre, feuille ou ciseaux.");
    }

    // Fonction pour inscrire le joueur 2 (POUTINE)
    function inscrirePoutine() public {
        require(jeuActif, "Le jeu est termine.");
        require(joueur2 == address(0), "POUTINE est deja inscrit.");
        joueur2 = msg.sender;
        emit ChoixAttendu(joueur2, "Vous etes POUTINE. Faites votre choix: pierre, feuille ou ciseaux.");
    }

    // Fonction pour que chaque joueur fasse son choix
    function faiteVotreChoix(string memory choix) public {
        require(jeuActif, "Le jeu est termine.");
        require(msg.sender == joueur1 || msg.sender == joueur2, "Vous devez etre inscrit pour faire un choix.");
        require(keccak256(bytes(choix)) == keccak256(bytes("pierre")) || keccak256(bytes(choix)) == keccak256(bytes("feuille")) || keccak256(bytes(choix)) == keccak256(bytes("ciseaux")), "Choix invalide, choisissez entre pierre, feuille ou ciseaux.");
        
        if (msg.sender == joueur1) {
            choixJoueur1 = choix;
            emit ChoixEffectue(joueur1, choix);
        } else {
            choixJoueur2 = choix;
            emit ChoixEffectue(joueur2, choix);
        }

        // Si les deux joueurs ont fait leur choix, résoudre le duel
        if (bytes(choixJoueur1).length > 0 && bytes(choixJoueur2).length > 0) {
            _resoudreDuel();
        }
    }

    // Résoudre le duel
    function _resoudreDuel() private {
        require(bytes(choixJoueur1).length > 0 && bytes(choixJoueur2).length > 0, "Les deux joueurs doivent faire leur choix.");

        if (keccak256(bytes(choixJoueur1)) == keccak256(bytes(choixJoueur2))) {
            emit JeuTermine("Il y a une egalite ! Refaites vos choix.");
            choixJoueur1 = "";
            choixJoueur2 = "";
        } else if (
            (keccak256(bytes(choixJoueur1)) == keccak256(bytes("pierre")) && keccak256(bytes(choixJoueur2)) == keccak256(bytes("ciseaux"))) ||
            (keccak256(bytes(choixJoueur1)) == keccak256(bytes("feuille")) && keccak256(bytes(choixJoueur2)) == keccak256(bytes("pierre"))) ||
            (keccak256(bytes(choixJoueur1)) == keccak256(bytes("ciseaux")) && keccak256(bytes(choixJoueur2)) == keccak256(bytes("feuille")))
        ) {
            gagnant = joueur1;
            emit GagnantDeclare(gagnant);
            emit JeuTermine("Le jeu est termine ! Le gagnant est TRUMP.");
            jeuActif = false;
        } else {
            gagnant = joueur2;
            emit GagnantDeclare(gagnant);
            emit JeuTermine("Le jeu est termine ! Le gagnant est POUTINE.");
            jeuActif = false;
        }
    }

    // Permet de réinitialiser le jeu (uniquement par le propriétaire)
    function reinitialiserJeu() public {
        require(msg.sender == owner, "Seul le proprietaire peut reinitialiser.");
        joueur1 = address(0);
        joueur2 = address(0);
        choixJoueur1 = "";
        choixJoueur2 = "";
        jeuActif = true;
    }
}
