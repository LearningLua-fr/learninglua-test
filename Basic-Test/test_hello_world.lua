-- Fonction pour exécuter le code utilisateur contenu dans test_du_joueur
function execute_user_code()
    load(test_du_joueur)()  -- Exécuter le code utilisateur contenu dans la variable
end

-- Fonction pour tester le code de l'utilisateur
function run_test()
    local success, message = pcall(execute_user_code)
    if success then
        print("Test Passed!")
    else
        print("Test Failed! Error: " .. message)
    end
end

-- Lancement du test
run_test()
