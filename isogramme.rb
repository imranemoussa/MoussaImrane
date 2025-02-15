#premier = recuperer un mot
# 2 - transformer ce mot en un tableau
# 3 - ajouter te chaque lettre de ce mot dans un hash vide et chaque lettre aura par defaut une valeur de 1
# 4 - trier le hash (en triant un hash par sort_by il devient un tableau) en fonction de la lettre qui a la plus grande valeur(du plus grand qu plus petit)
# 5 - recuperer le premier element de ce tableau trier
# 6 - on verifie si l'element qui se trouve a l'index 1 est superieur ou bien egal a 1
# 7 - si c'est superieur alors c'est pas un isogramme sinon c'est un isogramme


def isogramme()
    loop do
        puts "Veuillez entrer un mot s'il vous plait : "
        mot = gets.chomp.tr("!@,:", '').downcase
        if mot == "-1"
            puts "Desole mais vous devez mettre un mot valide"
            return
        end
        frequence = {}
        mot_tb = mot.chars
        mot_tb.each do |lettre|
            if frequence[lettre] == nil
                frequence[lettre] = 1
            else
                frequence[lettre] += 1
            end
        end

        frequence = frequence.sort_by {|char, nombre| nombre}
        frequence.reverse!

        essai = frequence[0]

        if essai[1] > 1
            puts "Ce \"#{mot}\" n'est pas un isogramme"
        elsif essai[1] == 1
            puts "Ce mot \"#{mot}\" est un isogramme"
        end
    end
end

puts isogramme()