require 'sinatra'
require './fonctions'
require 'json'



#blog debut


DATA_FILE = "data.json"

def charger_donnees
  File.exist?(DATA_FILE) ? JSON.parse(File.read(DATA_FILE)) : []
end

def enregistrer_donnees(donnees)
  File.write(DATA_FILE, JSON.pretty_generate(donnees))
end


get '/blog' do
    @donnees = charger_donnees
    erb:'blog'
end

get '/ajoutBlog' do
    erb:'ajoutBlog'
end

# Ajouter une nouvelle donnée
post '/creation' do
    donnees = charger_donnees
    new_id = (donnees.map { |d| d["id"] }.max || 0) + 1
    nouvelle_donnee = {
      "id" => new_id,
      "titre" => params[:titre],
      "contenu" => params[:contenu]
    }
    donnees << nouvelle_donnee
    enregistrer_donnees(donnees)
    redirect '/blog'
end


get '/modifier/:id' do
    @donnee = charger_donnees.find { |d| d["id"] == params[:id].to_i }
    erb:'editer'
end


post '/modifier/:id' do
    donnees = charger_donnees
    donnee = donnees.find { |d| d["id"] == params[:id].to_i }
    if donnee
      donnee["titre"] = params[:titre]
      donnee["contenu"] = params[:contenu]
      enregistrer_donnees(donnees)
    end
    redirect '/'
end

post '/supprimer/:id' do
    donnees = charger_donnees.reject { |d| d["id"] == params[:id].to_i }
    enregistrer_donnees(donnees)
    redirect '/'
end
#blog fin






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