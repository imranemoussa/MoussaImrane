def matrix()
    puts "Veuillez entrez votre matrice Mr:"
    cellule = gets.chomp
    cellule_tb = cellule.split(', ')
    index = 0
    matrice_inverse = ""
    while index < (cellule_tb.length+1)
        cellule_tb.each do |ensemble|
            ensemble_tb = ensemble.chars
            matrice_inverse << (ensemble_tb[index] || ' ')
        end
        matrice_inverse << ', '
        index += 1
    end
    return matrice_inverse.split(', ')
end

puts matrix()

        


            
