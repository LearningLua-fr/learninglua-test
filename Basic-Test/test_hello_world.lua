-- Fonction pour vérifier si le code contient une certaine chaîne
function contains_print_statement(user_code)
    return string.find(user_code, "print") ~= nil
end

-- Fonction qui prend le code de l'utilisateur comme paramètre
function run_test(user_code)
    if contains_print_statement(user_code) then
        print("Test Passed!")
    else
        print("Test Failed! The code must contain a 'print' statement.")
    end
end

-- Le code de l'utilisateur est passé comme argument lors de l'appel de run_test
run_test(user_code)
