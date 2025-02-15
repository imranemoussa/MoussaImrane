# 1 - l'utilisateur va mettre les deux adn 
# 2 - le programme verifie d'abord s'ils ont la meme taille
# 3 - on verifie si chaque lettre du premier adn et dans la lettre du deuxieme adn
# 4 - si une lettre qui se trouve a l'index 1 dans adn 1 par exemple est la meme si se trouve au meme index dans adn2 alors il sont identique
# 5 - sinon on compte le nombre de fois ou il ya une difference de lettre


def hamming()
    puts "Entrez le premier ADN : "
    adn1 = gets.chomp.downcase
    puts "Entrez le deuxieme ADN : "
    adn2 = gets.chomp.downcase.chars

    nb = 0

    if adn1.chars.length == adn2.length
        adn1.chars.each_with_index do |lettre, index|
            if adn2.include?(lettre)
                if adn1 == adn2.join('')
                    puts "Les deux ADN sont identiques"
                    return
                else
                    nb += 1
                end
            else
                puts "La lettre \'#{lettre}\' ne se trouve pas dans le deuxieme ADN"
            end
        end
    else
        puts "Les deux ADN n'ont pas la meme taille, veuillez reessayer a nouveau"
        return hamming()
    end

    puts "Les deux ADN ne sont pas identiques, avec \"#{nb}\" dicance de Hamming "
end

puts hamming()
            