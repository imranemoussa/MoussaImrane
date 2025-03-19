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