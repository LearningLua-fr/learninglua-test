-- Vérifie que la fonction `IsPalindrome` est définie
function contains_function_declaration(code)
    return string.match(code, "function%s+IsPalindrome%s*%(%s*text%s*%)") ~= nil
end

-- Vérifie que le code de l'utilisateur contient une manipulation de chaîne (string.gsub, string.reverse, ou string.lower)
function contains_string_manipulation(code)
    return string.match(code, "string%.gsub") ~= nil or string.match(code, "string%.reverse") ~= nil or string.match(code, "string%.lower") ~= nil
end

-- Vérifie que la sortie de l'utilisateur correspond à la sortie attendue (sans espaces et caractères spéciaux)
function check_output(user_output, expected_output)
    -- Supprime les sauts de ligne, retours chariots et espaces des deux chaînes
    local sanitized_user_output = string.gsub(user_output, "[\n\r%s]", "")
    local sanitized_expected_output = string.gsub(expected_output, "[\n\r%s]", "")
    return sanitized_user_output == sanitized_expected_output
end

-- Fonction principale de test
function run_test(user_code, user_output, expected_output_user)
    local test_passed = 0
    local total_tests = 2
    local test_result = {}

    -- Test 1 : Vérifie la déclaration de la fonction
    if contains_function_declaration(user_code) then
        table.insert(test_result, "Test Passed 1/3: The function `IsPalindrome` is correctly defined")
        test_passed = test_passed + 1
    else
        table.insert(test_result, "Test Failed 1/3: The function `IsPalindrome` is not defined")
    end

    -- Test 2 : Vérifie qu'une manipulation de chaîne est utilisée
    if contains_string_manipulation(user_code) then
        table.insert(test_result, "Test Passed 2/3: String manipulation is used in the function")
        test_passed = test_passed + 1
    else
        table.insert(test_result, "Test Failed 2/3: The function `IsPalindrome` does not contain any string manipulation")
    end

    -- Résumé final
    if test_passed == total_tests then
        table.insert(test_result, "All tests passed")
    else
        table.insert(test_result, string.format("%d/%d tests passed", test_passed, total_tests))
    end

    -- Affiche le résultat consolidé
    return table.concat(test_result, "\n")
end


print(run_test(user_code, user_output, expected_output_user))
