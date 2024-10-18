-- Fonction pour exécuter le code utilisateur sans montrer de détails
function execute_user_code(user_code)
    if not user_code or user_code == "" then
        -- Si le code utilisateur est nil ou vide, retourner une erreur explicite
        return false, "Error: No user code provided or code is empty"
    end

    -- Tenter de charger le code utilisateur
    local func, err = load(user_code)
    
    if not func then
        -- Si le code utilisateur ne peut pas être chargé, retourner l'erreur
        return false, "Error while loading user code: " .. err
    end

    -- Exécuter le code chargé
    return pcall(func)
end

-- Fonction de test avec vérification de la table sans afficher les détails
function run_test(step_description, user_code, validation_function)
    print("Testing user code for:", step_description)  -- Affichage pour le debug
    print("Code utilisateur testé :\n", user_code)  -- Affichage du code utilisateur pour le debug

    -- Exécuter le code utilisateur et capturer les erreurs s'il y en a
    local success, err = execute_user_code(user_code)

    -- Si l'exécution a échoué, afficher l'erreur
    if not success then
        print(step_description .. " : Test Failed! Error: " .. (err or "Unknown error"))
        return
    end

    -- Si l'exécution est réussie, vérifier la fonction de validation
    if validation_function(user_code) then
        print(step_description .. " : Test Passed!")
    else
        print(step_description .. " : Test Failed!")
    end
end

-- Test 8 : Vérification que l'utilisateur n'imprime pas directement toute la sortie en une seule chaîne
function check_for_direct_output(user_code)
    -- Expression régulière stricte pour vérifier l'impression directe de la chaîne complète
    local forbidden_output_pattern = [[print%s*\(%s*"Name:%s*Max%s*Age:%s*25%s*Job:%s*Developer%s*Name:%s*Jenna%s*Age:%s*30%s*Job:%s*Designer"%s*\)]]
    
    -- Log pour vérifier l'exécution
    print("Vérification de la présence du pattern dans le code : ", forbidden_output_pattern)

    -- Si l'utilisateur a ce pattern exact dans son code, le test échoue
    return not string.match(user_code, forbidden_output_pattern)
end

-- Appel du test avec vérification du code utilisateur et gestion des erreurs
run_test("Step 8: Vérification que l'utilisateur n'imprime pas directement toute la sortie en une seule chaîne", user_code, check_for_direct_output)
