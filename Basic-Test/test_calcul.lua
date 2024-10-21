local tests = {}

-- Fonction pour exécuter le code utilisateur et capturer la sortie
function execute_user_code()
    local result = {}
    local function custom_print(...)
        table.insert(result, table.concat({...}, " "))
    end
    
    local original_print = print
    print = custom_print
    
    -- Exécuter le code de l'utilisateur (par exemple, via une fonction globale)
    local success, message = pcall(user_code)  -- user_code doit être une fonction contenant le code de l'utilisateur

    -- Restaurer la fonction print originale
    print = original_print
    
    if success then
        return table.concat(result, "\n")  -- Retourne la sortie capturée
    else
        return nil, message  -- Retourne une erreur si l'exécution échoue
    end
end

-- Fonction pour compter les appels à print() dans le code utilisateur
function count_print_calls(user_code)
    local print_count = 0
    for _ in string.gmatch(user_code, "print%(") do
        print_count = print_count + 1
    end
    return print_count
end

-- Fonction pour vérifier la présence d'au moins une table
function has_table_in_code(user_code)
    return string.match(user_code, "%b{}") ~= nil  -- Recherche d'une table (délimitée par {} dans le code)
end

-- Test 1: Vérification de la présence d'au moins une table
table.insert(tests, function()
    local has_table = has_table_in_code(user_code)
    return has_table, "Test 1: Vérification de la présence d'au moins une table"
end)

-- Test 2: Vérification du nombre d'appels à print() (maximum 3)
table.insert(tests, function()
    local print_calls = count_print_calls(user_code)
    return print_calls <= 3, "Test 2: Vérification du nombre d'appels à print()"
end)

-- Boucle pour exécuter tous les tests
for i, test in ipairs(tests) do
    local success, test_name = test()
    if success then
        print(test_name .. " passed.")
    else
        print(test_name .. " failed.")
    end
end
