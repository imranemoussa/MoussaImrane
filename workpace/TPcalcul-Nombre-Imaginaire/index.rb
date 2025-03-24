def calculImaginare()

    puts "Entrez l'operation que vous souhaitez : "
    op = gets.chomp
    if op == '1/z' || op == '|z|' || op == 'inverse'
        liste = []
        puts "Entrez le nombre imaginaire"
        nombrei = gets.chomp
        nombrei_tb = nombrei.split('')
        nombrei_tb.each do |i|
            if i =~ /^-?\d+$/
                liste << i.to_i
            end
        end

        if op == '1/z'
            result = (liste[0]/(liste[0]**2 + liste[1]**2)) - (liste[1]/(liste[0]**2 + liste[1]**2))
            puts "#{result}i"
        elsif op == "|z|"
            result = Math.sqrt((liste[0]**2) + (liste[1]**2))
            puts "#{result}i"
        elsif op == "inverse"
            if nombrei_tb.include?('+')
                puts "#{liste[0]} - #{liste[1]}i"
            else
                puts "#{liste[0]} + #{liste[1]}i"
            end
        end

    else

        liste_nb1 = []
        liste_nb2 = []
        puts "Entrez le premiere nombre imaginaire"
        nombre1 = gets.chomp
        puts "Entrez le deuxieme nombre imaginaire"
        nombre2 = gets.chomp
        nombre1_tb = nombre1.split('')
        nombre2_tb = nombre2.split('')
        nombre1_tb.each do |i|
            if i =~ /^-?\d+$/
                liste_nb1 << i.to_i
            end
        end

        nombre2_tb.each do |i|
            if i =~ /^-?\d+$/
                liste_nb2 << i.to_i
            end
        end

        if op == "plus" || op == '+'
            result = (liste_nb1[0]+liste_nb2[0]) + (liste_nb1[1]+liste_nb2[1])
            puts "#{result}i"
        elsif op == "moins" || op == '-'
            result = (liste_nb1[0]-liste_nb2[0]) + (liste_nb1[1]-liste_nb2[1])
            puts "#{result}i"
        elsif op == "fois" || op == '*'
            result = ((liste_nb1[0]*liste_nb2[0])-(liste_nb1[1]*liste_nb2[1])) + ((liste_nb1[1]*liste_nb2[0])+(liste_nb1[0]*liste_nb2[1]))
            puts "#{result}i"
        elsif op == "z/z"
            result = ((liste_nb1[0]*liste_nb2[0])+(liste_nb1[1]*liste_nb2[1]) / (liste_nb2[0]**2 + liste_nb2[1]**2) + (liste_nb1[1]*liste_nb2[0]-liste_nb1[0]*liste_nb2[1]) / (liste_nb2[0]**2 + liste_nb2[1]**2))
            puts "#{result}i"
        end
    end
end

puts calculImaginare()