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
        -- Normaliser les résultats pour enlever les espaces multiples et retours à la ligne superflus
        result = normalize_string(result)
        expected_output = normalize_string(expected_output)

        if result == expected_output then
            print("Test Passed!")
        else
            print("Test Failed! The output does not match the expected result.")
            -- Loguer la différence entre le résultat et l'attendu
            print("Expected: [" .. expected_output:gsub("\n", "\\n"):gsub(" ", "_") .. "]")
            print("Got: [" .. result:gsub("\n", "\\n"):gsub(" ", "_") .. "]")
        end
    end
end
