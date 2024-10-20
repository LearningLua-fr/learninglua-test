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

    return table.concat(output, " "), nil
end

-- Fonction pour supprimer les espaces blancs de début et fin de chaîne
function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Fonction pour exécuter le test
function run_test(user_code, expected_output)
    local result, err = capture_output(user_code)

    if err then
        print("Test Failed! An error occurred during execution.")
    else
        -- Comparer les résultats en nettoyant les espaces blancs
        result = trim(result)
        expected_output = trim(expected_output)

        if result == expected_output then
            print("Test Passed!")
        else
            print("Test Failed! The output does not match the expected result.")
        end
    end
end
