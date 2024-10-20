-- Fonction pour vérifier si le code contient une certaine chaîne
function contains_print_statement(user_code)
    -- Vérifier que user_code est bien une chaîne non vide
    if type(user_code) ~= "string" or user_code == "" then
        error("Invalid input: user_code must be a non-empty string")
    end

    return string.find(user_code, "print") ~= nil
end

-- Fonction qui prend le code de l'utilisateur comme paramètre
function run_test(user_code)
    -- Appeler la fonction de vérification
    if contains_print_statement(user_code) then
        print("Test Passed!")
    else
        print("Test Failed! The code must contain a 'print' statement.")
    end
end

-- Exécution du test avec le code utilisateur
run_test(user_code)
