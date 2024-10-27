-- Vérifie que la fonction `ExtractLicense` est définie avec le bon argument
function contains_function_declaration(code)
    return string.match(code, "function%s+ExtractLicense%s*%(%s*licenseStr%s*%)") ~= nil
end

-- Vérifie que le code de l'utilisateur utilise une manipulation de chaîne (string.sub ou string.gsub)
function contains_string_manipulation(code)
    return string.match(code, "string%.gsub") ~= nil or string.match(code, "string%.sub") ~= nil
end

-- Normalise les chaînes de caractères pour comparaison
function normalize_string(str)
    return str:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

-- Vérifie que la sortie utilisateur est égale à la sortie attendue
function check_output(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

-- Fonction principale de test
function run_test(user_code, expected_output_user)
    local test_passed = 0
    local total_tests = 3

    -- Test 1 : Vérifie que la sortie est correcte
    local user_function, load_error = loadstring(user_code .. "\n return ExtractLicense")
    if user_function then
        local extracted_func = user_function()
        local success, user_output = pcall(extracted_func, "license:aaabbbccc1454")
        if success and check_output(user_output, expected_output_user) then
            test_passed = test_passed + 1
        end
    end

    -- Test 2 : Vérifie que la fonction est correctement définie
    if contains_function_declaration(user_code) then
        test_passed = test_passed + 1
    end

    -- Test 3 : Vérifie qu'une manipulation de chaîne est utilisée
    if contains_string_manipulation(user_code) then
        test_passed = test_passed + 1
    end

    -- Résumé final
    if test_passed == total_tests then
        print("All tests passed")
    else
        print(string.format("%d/%d tests passed", test_passed, total_tests))
    end
end

-- Exécute le test
run_test(user_code, expected_output_user)
