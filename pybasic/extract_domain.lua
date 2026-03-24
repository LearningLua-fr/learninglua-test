function contains_print_statement(code)
    return string.match(code, "print%(") ~= nil
end

function contains_function_definition(code)
    return string.match(code, "def%s+%w+%(") ~= nil
end

function normalize_string(str)
    return str:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

function final_is_not_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    if normalized_user_output == normalized_expected_output then
        return true
    else
        return false
    end
end

function contains_domain_extraction(code)
    return string.match(code, "split") ~= nil
        or string.match(code, "replace") ~= nil
        or string.match(code, "re%.") ~= nil
        or string.match(code, "urlparse") ~= nil
end

function run_test(user_code, user_output, expected_output_user)
    -- Test 1 : Vérifier que la sortie est correcte
    if final_is_not_equal(user_output, expected_output_user) then
        print("Test Passed 1/3")
    else
        print("Test Failed 1/3: Output is not equal to expected output")
    end

    -- Test 2 : Vérifier qu'une fonction est définie
    if contains_function_definition(user_code) then
        print("Test Passed 2/3")
    else
        print("Test Failed 2/3: No function definition found")
    end

    -- Test 3 : Vérifier l'utilisation d'une méthode d'extraction
    if contains_domain_extraction(user_code) then
        print("Test Passed 3/3")
    else
        print("Test Failed 3/3: No domain extraction method used (split, replace, re, urlparse)")
    end

    -- Résultat final
    if final_is_not_equal(user_output, expected_output_user)
        and contains_function_definition(user_code)
        and contains_domain_extraction(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)
