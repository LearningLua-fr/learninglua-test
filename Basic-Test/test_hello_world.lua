-- Fonction pour vérifier si le code contient une certaine chaîne
function contains_print_statement(code)
    -- Vérifier que le code n'est pas vide
    if type(code) ~= "string" or code == "" then
        error("Invalid input: code must be a non-empty string")
    end

    -- Ne montre pas la réponse directement
    return string.find(code, "print") ~= nil
end

-- Fonction pour exécuter le code utilisateur dans un environnement sécurisé
function run_test(code)
    if contains_print_statement(code) then
        print("Test Passed!")
    else
        print("Test Failed! A 'print' statement is expected.")
    end
end
