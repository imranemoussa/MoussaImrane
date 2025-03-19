require 'json'
require 'securerandom'


class BankSystem
    FICHIER_COMPTES = 'comptes.json'
    def charger_comptes
    File.exist?(FICHIER_COMPTES) ? JSON.parse(File.read(FICHIER_COMPTES)) : []
    end
    require 'json'
    require 'securerandom'
    
    class Banque
      FICHIER_COMPTES = 'comptes.json'
      LES_LOGS = 'logs.json'
    
      def initialize
        @comptes = charger_comptes
        @logs = charger_logs
      end
    
      def charger_comptes
        File.exist?(FICHIER_COMPTES) ? JSON.parse(File.read(FICHIER_COMPTES)) : []
      end
    
      def sauvegarder_comptes
        File.write(FICHIER_COMPTES, JSON.pretty_generate(@comptes))
      end
    
      def charger_logs
        File.exist?(LES_LOGS) ? JSON.parse(File.read(LES_LOGS)) : []
      end
    
      def sauvegarder_logs
        File.write(LES_LOGS, JSON.pretty_generate(@logs))
      end
    
      def enregistrer_log(numero, nom, transaction, montant)
        log = { "numero" => numero, "nom" => nom, "transaction" => transaction, "montant" => montant }
        @logs << log
        sauvegarder_logs
      end
    
      def afficher_logs(numero)
        log_compte = @logs.select { |log| log["numero"] == numero }
        if log_compte.empty?
          puts "Aucun compte n'a été trouvé dans le système"
        else
          puts "Historique du compte N : #{numero}"
          log_compte.each do |element|
            puts "Numéro : #{element["numero"]}, Nom : #{element["nom"]}, Transaction : #{element["transaction"]}, Montant : #{element["montant"]} FCFA"
          end
        end
      end
    
      def creer_compte(nom)
        numero_compte = SecureRandom.hex(2)
        compte = { "nom" => nom, "numero" => numero_compte, "solde" => 0.0, "actif" => true }
        @comptes << compte
        sauvegarder_comptes
        puts "Compte de #{nom} créé avec succès, ID : #{numero_compte}"
      end
    
      def depot(numero, montant)
        compte = @comptes.find { |account| account["numero"] == numero }
        if compte.nil?
          puts "Aucun compte ne correspond à ce numéro"
          return
        elsif !compte["actif"]
          puts "Impossible de faire une transaction sur un compte désactivé"
          return
        elsif montant < 0
          puts "Le montant doit être supérieur à 0"
          return
        end
    
        compte["solde"] += montant
        sauvegarder_comptes
        enregistrer_log(numero, compte["nom"], "depot", montant)
        puts "Dépôt effectué avec succès"
      end
    
      def retrait(numero, montant)
        compte = @comptes.find { |account| account["numero"] == numero }
        if compte.nil?
          puts "Aucun compte ne correspond à ce numéro"
          return
        elsif !compte["actif"]
          puts "Impossible de faire une transaction sur un compte désactivé"
          return
        elsif compte["solde"] < montant
          puts "Solde insuffisant"
          return
        end
    
        compte["solde"] -= montant
        sauvegarder_comptes
        enregistrer_log(numero, compte["nom"], "retrait", montant)
        puts "Retrait effectué avec succès"
      end
    
      def desactiver_compte(numero)
        compte = @comptes.find { |account| account["numero"] == numero }
        if compte.nil?
          puts "Aucun compte ne correspond à ce numéro"
          return
        end
    
        compte["actif"] = false
        sauvegarder_comptes
        puts "Compte #{compte["nom"]} (#{compte["numero"]}) désactivé avec succès"
      end
    
      def afficher_tous_les_comptes
        @comptes.each do |account|
          puts "Nom : #{account["nom"]}, Numéro : #{account["numero"]}, Solde : #{account["solde"]}, Actif : #{account["actif"]}"
        end
      end
    
      def menu
        loop do
          puts "1. Créer un compte"
          puts "2. Déposer de l'argent"
          puts "3. Retirer de l'argent"
          puts "4. Désactiver un compte"
          puts "5. Afficher tous les comptes"
          puts "6. Afficher les logs d'un compte"
          puts "7. Quitter"
          print "Votre choix : "
          choix = gets.chomp
    
          case choix
          when "1"
            print "Nom du propriétaire : "
            nom = gets.chomp
            creer_compte(nom)
          when "2"
            print "Numéro du compte : "
            numero = gets.chomp
            print "Montant : "
            montant = gets.chomp.to_f
            depot(numero, montant)
          when "3"
            print "Numéro du compte : "
            numero = gets.chomp
            print "Montant : "
            montant = gets.chomp.to_f
            retrait(numero, montant)
          when "4"
            print "Numéro du compte : "
            numero = gets.chomp
            desactiver_compte(numero)
          when "5"
            afficher_tous_les_comptes
          when "6"
            print "Numéro du compte : "
            numero = gets.chomp
            afficher_logs(numero)
          when "7"
            puts "Au revoir"
            break
          else
            puts "Choix invalide, veuillez réessayer."
          end
        end
      end
    end
    
    # Exécution du programme
    Banque.new.menu
    


