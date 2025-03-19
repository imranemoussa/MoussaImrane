require 'json'
require 'securerandom'

FICHIER_COMPTES = 'comptes.json'
def charger_comptes
  File.exist?(FICHIER_COMPTES) ? JSON.parse(File.read(FICHIER_COMPTES)) : []
end
  
def sauvegarder_comptes(comptes)
  File.write(FICHIER_COMPTES, JSON.pretty_generate(comptes))
end


LES_LOGS = 'logs.json'
def charger_logs
  File.exist?(LES_LOGS) ? JSON.parse(File.read(LES_LOGS)) : []
end
  
def sauvegarder_logs(logs)
  File.write(LES_LOGS, JSON.pretty_generate(logs))
end

def enregistrer_log (numero, nom, transaction, montant)
    logs = charger_logs

    log = {
        "numero" => numero,
        "nom" => nom,
        "transaction" => transaction,
        "montant" => montant
    }

    logs << log
    sauvegarder_logs(logs)
end

def afficher_logs(numero)
    logs = charger_logs
    log_compte = logs.select {|log| log["numero"] == numero}
    
    if log_compte.nil?
        puts "Aucun compte n'a ete trouver dans le systeme"
        return
    else
        puts "L'historique du compte N : #{numero}"
        log_compte.each do |element|
            puts "Le numero du compte : #{element["numero"]}, Le nom du Proprio : #{element["nom"]}, Le type de transaction : #{element["transaction"]}, Le montant transiter : #{element["montant"]} FCFA"
        end
    end
end

def creer_compte(nom)
    comptes = charger_comptes
    numero_compte = SecureRandom.hex(2)

    compte = {
        "nom" => nom,
        "numero" => numero_compte,
        "solde" => 0.0,
        "actif" => true
    }

    comptes << compte
    sauvegarder_comptes(comptes)
    puts "Le compte de Mr/Mdm #{nom} a ete creer avec succees avec un ID : #{numero_compte}"
end

def depot(numero, montant)
    comptes = charger_comptes
    compte_trouve = comptes.find {|account| account["numero"] == numero}
    if compte_trouve.nil?
        puts "Aucun compte ne correspond pas a ce numero"
        return
    elsif !compte_trouve["actif"]
        puts "Impossible de faire une transaction sur un compte desactiver"
        return
    end

    if montant < 0
        puts "Le montant doit etre superieur a 0"
        return
    end
    compte_trouve["solde"] += montant
    sauvegarder_comptes(comptes)
    enregistrer_log(numero, compte_trouve["nom"], "depot", montant)
    puts "Depot effectuer avec succees"
end

def retrait(numero, montant)
    comptes = charger_comptes

    compte_trouve = comptes.find {|account| account["numero"] == numero}

    if compte_trouve.nil?
        puts "Aucun compte ne correcpond pas a ce numero"
        return
    elsif !compte_trouve["actif"]
        puts "IMpossible de faire une transaction sur un compte desactiver"
        return
    end

    if compte_trouve["solde"] < montant
        puts "Votre solde est insuffisant pour faire un retrait"
        return
    end

    compte_trouve["solde"] -= montant
    sauvegarder_comptes(comptes)
    enregistrer_log(numero, compte_trouve["nom"], "retrait", montant)
    puts "Retrait effectuer avec succees"
end

def desactiver_compte(numero)
    comptes = charger_comptes
    compte_trouve = comptes.find {|account| account["numero"] == numero}

    if compte_trouve==nil
        puts "Aucun compte ne correspond pas a ce numero"
        return
    end

    compte_trouve["actif"] = false
    sauvegarder_comptes(comptes)
    puts "Compte de Mr/Mdm #{compte_trouve["nom"]} qui a le numero du compte #{compte_trouve["numero"]} a ete desactiver avec succees"
end

def afficher_tout_les_comptes ()
    comptes = charger_comptes

    comptes.each do |account|
        puts "Le nom de la personne : #{account["nom"]}, Le numero du compte : #{account["numero"]}, Le solde : #{account["solde"]}, L'etat du compte : #{account["actif"]}"
    end
end

loop do
    puts "1. pour creer un compte"
    puts "2. pour faire un depot"
    puts "3. pour faire un retrait"
    puts "4. pour desactiver un compte"
    puts "5. pour afficher la liste de tout les comptes"
    puts "6. pour afficher les logs d'un compte"
    puts "7. pour quitter le programme"
    puts "Entrez votre choix"
    choix = gets.chomp

    if choix == "1"
        puts "Veuillez mettre le nom du proprio"
        name = gets.chomp
        creer_compte(name)
    elsif choix == "2"
        puts "Veuillez mettre le numero du compte"
        num = gets.chomp
        puts "Veuillez mettre le montant"
        amount = gets.chomp.to_f
        depot(num, amount)
    elsif choix == "3"
        puts "Veuillez mettre le numero du compte"
        num = gets.chomp
        puts "Veuillez mettre le montant"
        amount = gets.chomp.to_f
        retrait(num, amount)
    elsif choix == "4"
        puts "Veuillez mettre le numero du compte"
        num = gets.chomp
        desactiver_compte(num)
    elsif choix == "5"
        afficher_tout_les_comptes()
    elsif choix == "6"
        puts "Veuillez mettre le numero du compte"
        num = gets.chomp
        afficher_logs(num)
    else
        puts "Au revoir"
        break
    end
end