-- Vérifie que la fonction `ExtractLicense` est définie
function contains_function_declaration(code)
    return string.match(code, "function%s+ExtractLicense%s*%(%s*licenseStr%s*%)") ~= nil
end

-- Vérifie que le code de l'utilisateur contient une manipulation de chaîne (string.gsub ou string.sub)
function contains_string_manipulation(code)
    return string.match(code, "string%.gsub") ~= nil or string.match(code, "string%.sub") ~= nil
end

-- Vérifie que la sortie de l'utilisateur correspond à la sortie attendue
function CheckOutput(user_output, expected_output)
    return user_output == expected_output
end

-- Fonction principale de test
function run_test(user_code, expected_output_user)
    local test_passed = 0
    local total_tests = 3

    -- Test 1 : Vérifie la déclaration de la fonction
    if contains_function_declaration(user_code) then
        print("Test Passed 1/3: The function `ExtractLicense` is correctly defined")
        test_passed = test_passed + 1
    else
        print("Test Failed 1/3: The function `ExtractLicense` is not defined")
    end

    -- Test 2 : Vérifie qu'une manipulation de chaîne est utilisée
    if contains_string_manipulation(user_code) then
        print("Test Passed 2/3: String manipulation is used in the function")
        test_passed = test_passed + 1
    else
        print("Test Failed 2/3: The function `ExtractLicense` does not contain any string manipulation")
    end

    -- Test 3 : Vérifie la sortie attendue de la fonction
    local user_function, load_error = loadstring(user_code .. "\n return ExtractLicense")  -- Charge le code de l'utilisateur pour exécution
    if user_function then
        local extracted_func = user_function()
        local success, user_output = pcall(extracted_func, "license:aaabbbccc1454")
        if success and CheckOutput(user_output, expected_output_user) then
            print("Test Passed 3/3: The Expected output is correct")
            test_passed = test_passed + 1
        else
            print("Test Failed 3/3: The Expected output is not correct")
        end
    else
        print("Test Failed 3/3: Function could not be loaded - " .. tostring(load_error))
    end

    -- Résumé final avec débogage détaillé
    if test_passed == total_tests then
        print("All tests passed")
    else
        print(string.format("%d/%d tests passed", test_passed, total_tests))
    end
end
run_test(user_code, expected_output_user)
