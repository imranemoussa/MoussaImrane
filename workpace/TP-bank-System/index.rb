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

def enregistrer_log(numero, operation, montant)
  logs = charger_logs
  log = {
    "numero" => numero,
    "operation" => operation,
    "montant" => montant
  }
  logs << log
  sauvegarder_logs(logs)
end

def afficher_logs(numero)
  logs = charger_logs
  logs_compte = logs.select { |log| log["numero"] == numero }

  if logs_compte.nil?
    puts "Aucune transaction pour ce compte"
  else
    puts "L'historique du compte #{numero} :"
    logs_compte.each do |log|
      puts "#{log["operation"]} de #{log["montant"]} FCFA"
    end
  end
end



def creer_compte(nom)
  comptes = charger_comptes
  numero_compte = SecureRandom.hex(2)
  compte = { numero: numero_compte, nom: nom, solde: 0.0, actif: true }
  comptes << compte
  sauvegarder_comptes(comptes)
  puts "Le compte de \'#{nom}\' a ete creer avec succee avec un num compte : #{numero_compte}"
end

  

def depot(numero, montant)
  comptes = charger_comptes
  compte_trouve = nil

  comptes.each do |compte|
    if compte["numero"] == numero
      compte_trouve = compte
      break
    end
  end

  if compte_trouve.nil?
    puts "compte n'existe pas"
    return
  elsif !compte_trouve["actif"]
    puts "Le compte est inactif"
    return
  end

  compte_trouve["solde"] += montant
  sauvegarder_comptes(comptes)

  enregistrer_log(numero, "depot", montant)
  puts "depot effectuer avec succees"
end

def retrait(numero, montant)
  comptes = charger_comptes
  compte_trouve = nil

  comptes.each do |compte|
    if compte["numero"] == numero
      compte_trouve = compte
      break
    end
  end

  if compte_trouve.nil?
    puts "Le compte n'existe pas"
    return
  elsif !compte_trouve["actif"]
    puts "compte est inactif"
    return
  elsif compte_trouve["solde"] < montant
    puts "desole mais votre solde est insuffisant"
    return
  end

  compte_trouve["solde"] -= montant
  sauvegarder_comptes(comptes)

  enregistrer_log(numero, "retrait", montant)
  puts "Retrait effectuer avec succees"
end

  

def desactiver_compte(numero)
  comptes = charger_comptes
  compte_trouve = nil

  comptes.each do |compte|
    if compte["numero"] == numero
      compte_trouve = compte
      break
    end
  end

  if compte_trouve.nil?
    puts "Ce compte est introuvable"
    return
  end

  compte_trouve["actif"] = false
  sauvegarder_comptes(comptes)
  puts "Compte desactiver avec succees"
end



def lister_tout_les_comptes
  comptes = charger_comptes
  comptes.each do |c|
    puts "Numéro: #{c["numero"]}, Nom: #{c["nom"]}, Solde: #{c["solde"]}, Actif: #{c["actif"]}"
  end
end


loop do
  puts "Les options :"
  puts "1. si vous voulez creer un compte"
  puts "2. si vous voulez effectuer un depot"
  puts "3. si vous voulez faire un retrait"
  puts "4. pour desactiver un compte"
  puts "5. avoir la liste de tout les compte"
  puts "6. voir l'historique des transactions"
  puts "7. pour quitter le programme"
  puts "Choisissez une option : "
  choix = gets.chomp


  if choix == "1"
    print "le nom du proprietaire : "
    nom = gets.chomp
    creer_compte(nom)
  elsif choix == "2"
    print "le numero du compte : "
    numero = gets.chomp
    print "le montant a deposer : "
    montant = gets.chomp.to_f
    depot(numero, montant)
  elsif choix == "3"
    print "le numero du compte : "
    numero = gets.chomp
    print "Entrez le montant a retirer : "
    montant = gets.chomp.to_f
    retrait(numero, montant)
  elsif choix == "4"
    print "le numero du compte a desactiver : "
    numero = gets.chomp
    desactiver_compte(numero)
  elsif choix == "5"
    lister_tout_les_comptes
  elsif choix == "6"
    print "Entrez le numéro du compte pour afficher l'historique : "
    numero = gets.chomp
    afficher_logs(numero)
  else
    puts "Au revoir !"
    break
  end
end
