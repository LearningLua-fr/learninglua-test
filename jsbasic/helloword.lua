--[[
    Lua Unit Test pour l'exercice "Hello World en JS"

    Ce script effectue deux tests :
    1. Vérifie si la sortie de l'utilisateur correspond à la sortie attendue.
    2. Vérifie si le code de l'utilisateur contient une instruction `console.log`.

    Assumptions :
    - Les variables `user_code`, `user_output`, et `expected_output_user` sont définies
      externement dans l'environnement du compilateur et sont accessibles lors de l'exécution de ce script.
--]]

-- Fonction pour vérifier si le code de l'utilisateur contient une instruction console.log
local function contains_console_log(code)
    -- Pattern pour détecter 'console.log(' avec des espaces optionnels
    return string.match(code, "console%.log%s*%(") ~= nil
end

-- Fonction pour normaliser les chaînes de caractères en remplaçant les espaces multiples par un seul espace
-- et en supprimant les espaces en début et fin de chaîne
local function normalize_string(str)
    -- Remplacer un ou plusieurs caractères d'espacement par un seul espace
    local normalized = string.gsub(str, "%s+", " ")
    -- Supprimer les espaces en début et fin de chaîne
    normalized = string.gsub(normalized, "^%s*(.-)%s*$", "%1")
    return normalized
end

-- Fonction pour comparer la sortie de l'utilisateur avec la sortie attendue
local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

-- Fonction pour exécuter les tests unitaires
local function run_test(user_code, user_output, expected_output_user)
    -- Test 1 : Vérifier si la sortie correspond à la sortie attendue
    if final_is_equal(user_output, expected_output_user) then
        print("Test Passed 1/2: La sortie correspond à la sortie attendue.")
    else
        print("Test Failed 1/2: La sortie ne correspond pas à la sortie attendue.")
    end

    -- Test 2 : Vérifier si le code contient une instruction console.log
    if contains_console_log(user_code) then
        print("Test Passed 2/2: Instruction console.log trouvée dans le code.")
    else
        print("Test Failed 2/2: Aucune instruction console.log trouvée dans le code.")
    end

    -- Résumé final
    if final_is_equal(user_output, expected_output_user) and contains_console_log(user_code) then
        print("Tous les tests ont réussi.")
    else
        print("Certains tests ont échoué. Veuillez revoir votre code et votre sortie.")
    end
end

run_test(user_code, user_output, expected_output_user)

