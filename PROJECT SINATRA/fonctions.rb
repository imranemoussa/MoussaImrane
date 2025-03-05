#Calculatrice DEBUT

def calculatrice(phrase)
    index = 1
    operateurs = ['plus', 'moins', 'fois', 'multiplier', 'diviser']
    expression = []
    phrase_tb = phrase.split(' ')
    phrase_tb.each do |op|
        if op =~ /^-?\d+$/
            expression << op.to_f
        elsif operateurs.include?(op)
            expression << op
        end
    end

    if expression.length.nil?
        return "Cette operation n'est pas pris en compte par notre programme"
    elsif expression.length == 2
        expression.each do |i|
            if i == /^-?\d+$/
                return "Evaluer a #{i}"
            end
        end
    end

    resultat = expression[0]

    while index < expression.length
        nombre_suivant = expression[index+1]
        opt = expression[index]
        if opt == "plus"
            resultat += nombre_suivant
        elsif opt == "moins"
            resultat -= nombre_suivant
        elsif opt == "fois" || opt == "multiplier"
            resultat *= nombre_suivant
        elsif opt == "diviser"
            if nombre_suivant != 0
                resultat /= nombre_suivant
            else
                return "La division sur un nombre nul n'existe pas"
            end
        end

        index += 2
    end

    return "Evaluer a #{resultat}"
end

#Calculatrice FIN

#ISOGRAMME DEBUT

def isogramme(mot)
    frequence = {}
    mot_tb = mot.chars

    mot_tb.each do |letter|
        if frequence[letter].nil?
            frequence[letter] = 1
        else
            frequence[letter] += 1
        end
    end

    frequence.each do |cle, valeur|
        if valeur > 1
            return "Ce mot n'est pas un isogramme"
        end
    end
    return "Ce mot est un isogramme"
end

#ISOGRAMME FIN

#DISTANCE HAMMING DEBUT

def hamming(adn1, adn2)
    nombre = 0

    if adn1.chars.length != adn2.chars.length
        return "Les deux ADN doivent avoir la meme taille"
    end

    adn1.chars.each_with_index do |letter, index|
        if !(adn2.chars.include?(letter) && adn1.chars.include?(adn2.chars[index]))
            return "Les lettres \'#{letter}, #{adn2.chars[index]}\' ne figure pas dans l'un des ADN"
        end

        if adn2.chars[index] != letter
            nombre += 1
        end
    end
    
    if nombre != 0
        return "Les deux ADN ne sont pas identiques avec \'#{nombre}\' de distance de hamming"
    else
        return "Les deux ADN sont identique"
    end
end

#DISTANCE HAMMING FIN

#COLOR V1 DEBUT

def colorV1(liste)
    resultat = []
    couleurs_index = {'black' => 0, 'brown' => 1, 'red' => 2, 'orange' => 3, 'yellow' => 4, 'green' => 5, 'blue' => 6, 'violet' => 7, 'grey' => 8, 'white' => 9}
    liste_tb = liste.split('-')
    liste_tb.each do |color|
        if couleurs_index.key?(color)
            resultat << couleurs_index[color]
        end
    end

    if resultat.length == 2
        return resultat.join('')
    else
        return "Vous avez depasser le nombre de couleur pris en charge par notre programme"
    end
end

#COLOR V1 FIN

#COLOR V2 DEBUT

def colorV2(liste)
    couleurs_index = {'black' => 0, 'brown' => 1, 'red' => 2, 'orange' => 3, 'yellow' => 4, 'green' => 5, 'blue' => 6, 'violet' => 7, 'grey' => 8, 'white' => 9}
    
    resultat = []

    liste_tb = liste.split('-')
    liste_tb.each do |color|
        if couleurs_index.key?(color)
            resultat << couleurs_index[color]
        else
            return "Cette couleur n'est pas prise en compte par notre programme"
        end
    end

    if resultat.length == 3
        tree = resultat[2]
        x ='0' * tree
        return "Le resultat : #{resultat[0]}#{resultat[1]}#{x}"
    else
        return "Vous avez depasser le nombre de couleur pris en charge par notre programme"
    end
end

#COLOR V2 FIN