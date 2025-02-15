
def calculatrice()
    operations = ['plus', 'moins', 'fois', 'multiplié', 'divisé']

    puts "Entrez votre phrase d'operation"
    phrase = gets.chomp.downcase
    phrase_tb = phrase.split(' ')

    expression = []

    phrase_tb.each do |mot|
        if mot =~ /^-?\d+$/
            expression << mot.to_f
        elsif operations.include?(mot)
            expression << mot
        end
    end

    if expression.length == 0
        puts "Erreur expression invalide"
        return
    elsif expression.length == 1
        puts "evaluer a \'#{expression[0]}\'"
    end

    resultat = expression[0]
    index = 1

    while index < expression.length
        ops = expression[index]
        nb_suivant = expression[index + 1]
        if ops == "plus"
            resultat += nb_suivant
        elsif ops == "moins"
            resultat -= nb_suivant
        elsif ops == "multiplié" || ops == "fois"
            resultat *= nb_suivant
        elsif ops == "divisé"
            if nb_suivant != 0
                resultat /= nb_suivant
            else
                puts "Impossible de faire une division par 0, veuillez reesseyer"
                return calculatrice()
            end
        end
        index += 2
    end

    puts "Evaluer a \'#{resultat}\'"
    puts expression.inspect
end

puts calculatrice()