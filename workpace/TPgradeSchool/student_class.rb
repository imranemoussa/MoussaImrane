def student()
    while true
        students = []
        classroom = []
        students_classroom = {}

        puts "Voulez vous ajouter le nom de l'eleve ainsi que sa classe ?"
        op = gets.chomp
        while op == "oui"
            puts "Si vous voulez continuer le programme ecivez 'continue'"
            puts "Mettez le nom de l'eleve"
            nom_eleve = gets.chomp
            if students.include?(nom_eleve)
                puts "Erreur, Cet eleve existe deja"
                break
            elsif nom_eleve == "continue"
                break
            else
                students << nom_eleve
            end
            puts "Veuillez attribuer une classe a cet eleve"
            numero_classroom = gets.chomp
            classroom << numero_classroom

            students_classroom[nom_eleve] = numero_classroom
        end
            
        puts students_classroom.inspect

        puts " voulez vous avoir La liste de chaque eleve avec sa classe?"
        op = gets.chomp
        if op == "oui"
            puts "Mettez le numero de la classe que vous chercher"
            phrase = gets.chomp
            phrase_tb = phrase.split(' ')
            phrase_tb.each do |mot|
                if classroom.include?(mot)
                    
                    students_classroom.each do |ensembles|
                        if ensembles[1] == mot
                            puts ensembles[0].inspect
                        end
                    end
                end
            end
        else
            next
        end

        puts "voulez vous avoir la liste triee par ordre de tout les eleves ainsi que des classe?"
        op = gets.chomp
        if op == "oui"
            text = students_classroom.sort_by {|noms, numero| numero}
            puts "La liste triées est la suivantes : "
            puts text.inspect
        else
            next
        end


        puts "Voulez vous avoir La liste de tout eleves avec les classes respectives"
        op = gets.chomp
        if op == "oui"
            puts "Laissez moi reflechir"
            students_classroom.sort_by {|noms, numero_classe| numero_classe}
            students_classroom.each do |ensembles|
                puts "Nous avons \"#{ensembles[0]}\" en classe \"#{ensembles[1]}\""
            end
        else
            next
        end
    end

end

puts student()



    


        
                

