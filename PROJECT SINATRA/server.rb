require 'sinatra'
require './fonctions'
require 'json'



#blog debut


require 'sinatra'
require 'json'

DATA_FILE = "data.json"


def charger_donnees
  File.exist?(DATA_FILE) ? JSON.parse(File.read(DATA_FILE)) : []
end


def enregistrer_donnees(donnees)
  File.write(DATA_FILE, JSON.pretty_generate(donnees))
end


get '/blog' do
  @donnees = charger_donnees
  erb :blog
end

get '/ajoutBlog' do
  erb :ajoutBlog
end


post '/creation' do
  donnees = charger_donnees
  new_id = (donnees.map { |d| d["id"] }.max || 0) + 1
  nouvelle_donnee = {
    "id" => new_id,
    "titre" => params[:titre],
    "contenu" => params[:contenu],
    "commentaires" => []
  }
  donnees << nouvelle_donnee
  enregistrer_donnees(donnees)
  redirect '/blog'
end


get '/blog/:id' do
    donnees = charger_donnees
    @donnee = donnees.find { |d| d["id"] == params[:id].to_i }
  
    if @donnee.nil?
      halt 404, "aucun Article"
    end
  
    @donnee["commentaires"] ||= []

  
    erb :blog_detail
  end
  

get '/modifier/:id' do
  @donnee = charger_donnees.find { |d| d["id"] == params[:id].to_i }
  erb :editer
end

post '/modifier/:id' do
  donnees = charger_donnees
  donnee = donnees.find { |d| d["id"] == params[:id].to_i }
  if donnee
    donnee["titre"] = params[:titre]
    donnee["contenu"] = params[:contenu]
    enregistrer_donnees(donnees)
  end
  redirect "/blog/#{params[:id]}"
end

post '/supprimer/:id' do
  donnees = charger_donnees.reject { |d| d["id"] == params[:id].to_i }
  enregistrer_donnees(donnees)
  redirect '/blog'
end

post '/blog/:id/commentaire' do
    donnees = charger_donnees
    donnee = donnees.find { |d| d["id"] == params[:id].to_i }
  
    if donnee.nil?
      halt 404, "Article non trouvé"
    end
  
    
    donnee["commentaires"] ||= []

    new_comment_id = (donnee["commentaires"].map { |c| c["id"] }.max || 0) + 1

    nouveau_commentaire = {
      "id" => new_comment_id,
      "auteur" => params[:auteur],
      "contenu" => params[:contenu]
    }

    donnee["commentaires"] << nouveau_commentaire
    enregistrer_donnees(donnees)
  

    redirect "/blog/#{donnee['id']}"
end
  


post '/blog/:id/commentaire/:comment_id/modifier' do
  donnees = charger_donnees
  donnee = donnees.find { |d| d["id"] == params[:id].to_i }
  if donnee
    commentaire = donnee["commentaires"].find { |c| c["id"] == params[:comment_id].to_i }
    commentaire["contenu"] = params[:contenu] if commentaire
    enregistrer_donnees(donnees)
  end
  redirect "/blog/#{params[:id]}"
end

post '/blog/:id/commentaire/:comment_id/supprimer' do
  donnees = charger_donnees
  donnee = donnees.find { |d| d["id"] == params[:id].to_i }
  if donnee
    donnee["commentaires"].reject! { |c| c["id"] == params[:comment_id].to_i }
    enregistrer_donnees(donnees)
  end
  redirect "/blog/#{params[:id]}"
end


#blog fin

#compte debut

FICHIER_COMPTES = 'comptes.json'
LES_LOGS = 'logs.json'

def charger_comptes
  File.exist?(FICHIER_COMPTES) ? JSON.parse(File.read(FICHIER_COMPTES)) : []
end

def sauvegarder_comptes(comptes)
  File.write(FICHIER_COMPTES, JSON.pretty_generate(comptes))
end

def charger_logs
  File.exist?(LES_LOGS) ? JSON.parse(File.read(LES_LOGS)) : []
end

def sauvegarder_logs(logs)
  File.write(LES_LOGS, JSON.pretty_generate(logs))
end

def enregistrer_log(numero, operation, montant)
  logs = charger_logs
  logs << { "numero" => numero, "operation" => operation, "montant" => montant }
  sauvegarder_logs(logs)
end

get '/index' do
  erb :index
end

get '/comptes' do
  @comptes = charger_comptes
  erb :comptes
end

get '/compte/:numero' do
  @compte = charger_comptes.find { |c| c["numero"] == params[:numero] }
  halt 404, "Compte introuvable" unless @compte
  @logs = charger_logs.select { |log| log["numero"] == params[:numero] }
  erb :compte_detail
end

get '/ajout_compte' do
  erb :ajout_compte
end

post '/ajout_compte' do
  comptes = charger_comptes
  numero_compte = SecureRandom.hex(2)
  compte = { "numero" => numero_compte, "nom" => params[:nom], "solde" => 0.0, "actif" => true }
  comptes << compte
  sauvegarder_comptes(comptes)
  redirect '/comptes'
end


get "/ajout_transaction" do
    erb :ajout_transaction
end

post "/depot" do
    numero = params[:numero]
    montant = params[:montant].to_f
  
    comptes = charger_comptes
    compte = comptes.find { |c| c["numero"] == numero }
  
    if compte
      compte["solde"] += montant
      sauvegarder_comptes(comptes)
  
      enregistrer_log(numero, "depot", montant)
      redirect "/compte/#{numero}"
    else
      "Compte introuvable"
    end
end
  
get "/retrait_transaction" do
    erb :retrait_transaction
end
  

post "/retrait" do
    numero = params[:numero]
    montant = params[:montant].to_f
  
    comptes = charger_comptes
    compte = comptes.find { |c| c["numero"] == numero }
  
    if compte.nil?
      "Compte introuvable"
    elsif compte["solde"] < montant
      "Solde insuffisant"
    else
      compte["solde"] -= montant
      sauvegarder_comptes(comptes)
  
      enregistrer_log(numero, "retrait", montant)
      redirect "/compte/#{numero}"
    end
end
  

#compte fin






get '/' do
    erb:'accueil'
end

get '/isogramme' do
    erb:'isogramme'
end

post '/isogramme' do
    mot = params[:mot]
    @message = isogramme(mot)
    erb:'resultat'
end

get '/calculatrice' do
    erb:'calculatrice'
end

post '/calculatrice' do
    phrase = params[:phrase]
    @message = calculatrice(phrase)
    erb:'resultat'
end

get '/hamming' do
    erb:'hamming'
end

post '/hamming' do
    adn1 = params[:adn1]
    adn2 = params[:adn2]
    @message = hamming(adn1, adn2)
    erb:'resultat'
end

get '/colorResistanceV1' do
    erb:'colorResistanceV1'
end

post '/colorResistanceV1' do
    liste = params[:liste]
    @message = colorV1(liste)
    erb:'resultat'
end

get '/colorResistanceV2' do
    erb:'colorResistanceV2'
end

post '/colorResistanceV2' do
    liste = params[:liste]
    @message = colorV2(liste)
    erb:'resultat'
end