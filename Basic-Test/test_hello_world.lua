-- Fonction pour capturer la sortie du code utilisateur
function capture_output(code)
    local output = {}
    local function capture_print(...)
        local args = {...}
        for i = 1, #args do
            output[#output + 1] = tostring(args[i])
        end
    end

    -- Redéfinir la fonction print pour capturer la sortie
    local original_print = print
    print = capture_print

    -- Exécuter le code utilisateur
    local success, message = pcall(load(code))

    -- Restaurer la fonction print originale
    print = original_print

    if not success then
        return nil, message
    end

    return table.concat(output, "\n"), nil  -- Ajouter un vrai retour à la ligne entre chaque print
end

-- Fonction pour supprimer les espaces blancs et retours à la ligne de début et fin de chaîne
function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Fonction pour nettoyer la chaîne en supprimant les espaces multiples et les retours à la ligne
function normalize_string(s)
    return s:gsub("%s+", " "):gsub("\n", " "):gsub("^%s*(.-)%s*$", "%1")
end

-- Fonction pour exécuter le test
function run_test(user_code, expected_output)
    local result, err = capture_output(user_code)

    if err then
        print("Test Failed! An error occurred during execution.")
    else
        -- Afficher la sortie brute et attendue avant normalisation
        print("Raw result: [" .. result:gsub("\n", "\\n"):gsub(" ", "_") .. "]")
        print("Raw expected: [" .. expected_output:gsub("\n", "\\n"):gsub(" ", "_") .. "]")

        -- Nettoyer et normaliser les résultats pour éviter les différences dues aux espaces/retours à la ligne
        result = normalize_string(result)
        expected_output = normalize_string(expected_output)

        -- Afficher la sortie nettoyée pour vérifier la normalisation
        print("Normalized result: [" .. result:gsub("\n", "\\n"):gsub(" ", "_") .. "]")
        print("Normalized expected: [" .. expected_output:gsub("\n", "\\n"):gsub(" ", "_") .. "]")

        -- Comparer le résultat avec l'attendu
        if result == expected_output then
            print("Test Passed!")
        else
            print("Test Failed! The output does not match the expected result.")
        end
    end
end
