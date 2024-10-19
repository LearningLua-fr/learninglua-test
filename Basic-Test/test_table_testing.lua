local tests = {}

-- Test 1: Vérification de la sortie attendue
table.insert(tests, function()
    local output = execute_user_code()  -- Exécuter le code de l'utilisateur
    local expected_output = "Name: Max\nAge: 25\nJob: Developer\nName: Jenna\nAge: 30\nJob: Designer"
    return output == expected_output, "Test 1: Vérification de la sortie attendue"
end)

-- Test 2: Vérification du nombre d'appels à print()
table.insert(tests, function()
    local print_calls = count_print_calls(user_code)
    return print_calls >= 3, "Test 2: Vérification du nombre d'appels à print()"
end)

-- Ajouter d'autres tests ici...

-- Boucle pour exécuter tous les tests
for i, test in ipairs(tests) do
    local success, test_name = test()
    if success then
        print(test_name .. " passed.")
    else
        print(test_name .. " failed.")
    end
end
