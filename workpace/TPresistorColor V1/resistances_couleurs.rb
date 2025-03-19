def resistances(phrase)
    couleurs_index = {'black' => 0, 'brown' => 1, 'red' => 2, 'orange' => 3, 'yellow' => 4, 'green' => 5, 'blue' => 6, 'violet' => 7, 'grey' => 8, 'white' => 9}
    
    resultat = []
    
    index = 0
    phrase_tb = phrase.split(', ')

    phrase_tb.each do |color|
        if couleurs_index[color].nil?
            return "Cette couleur est inconnue"
        else
            resultat << couleurs_index[color]
        end
    end
    rest = [resultat[0], resultat[1]]
    tree = resultat[2]
    x = '0' * tree
    return "Les index de ces couleurs sont #{rest.join}#{x}"
    
end

puts resistances()