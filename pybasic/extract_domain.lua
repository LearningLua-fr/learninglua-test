function contains_function_definition(code)
    return string.match(code, "def%s+%w+%(") ~= nil
end

function normalize_string(str)
    return str:gsub("%s+", ""):gsub("^%s*(.-)%s*$", "%1")
end

function output_is_correct(user_output, expected_output)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output)

    return normalized_user_output == normalized_expected_output
end

function run_test(user_code, user_output, expected_output)
    -- Test 1 : Vérifier le résultat
    if output_is_correct(user_output, expected_output) then
        print("Test Passed 1/3")
    else
        print("Test Failed 1/3: Output is incorrect")
    end

    -- Test 2 : Vérifier qu'une fonction est définie
    if contains_function_definition(user_code) then
        print("Test Passed 2/3")
    else
        print("Test Failed 2/3: No function definition found")
    end

    -- Test 3 : Vérifier l'utilisation de split ou équivalent
    if string.match(user_code, "split") or string.match(user_code, "replace") then
        print("Test Passed 3/3")
    else
        print("Test Failed 3/3: No string processing method used")
    end

    -- Résultat final
    if output_is_correct(user_output, expected_output)
        and contains_function_definition(user_code)
        and (string.match(user_code, "split") or string.match(user_code, "replace")) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output)
