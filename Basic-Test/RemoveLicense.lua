function contains_function_declaration(code)
    return string.match(code, "function%s+ExtractLicense%s*%(%s*licenseStr%s*%)") ~= nil
end


function contains_string_manipulation(code)
    return string.match(code, "string%.gsub") ~= nil or string.match(code, "string%.sub") ~= nil
end


function CheckOutput(user_output, expected_output)
    if user_output == expected_output then
        return true
    else
        return false
    end
end


function run_test(user_code, expected_output_user)
    local test_passed = 0
    local total_tests = 3


    if contains_function_declaration(user_code) then
        print("Test Passed 1/3")
        test_passed = test_passed + 1
    else
        print("Test Failed 1/3: The function `ExtractLicense` is not defined")
    end

    -- Test 2 : Vérifie qu'une manipulation de chaîne est utilisée
    if contains_string_manipulation(user_code) then
        print("Test Passed 2/3")
        test_passed = test_passed + 1
    else
        print("Test Failed 2/3: The function `ExtractLicense` does not contain any string manipulation")
    end

    if CheckOutput(user_code, expected_output_user) then
        print("Test Passed 3/3")
        test_passed = test_passed + 1
    else
        print("Test Failed 3/3: The function `ExtractLicense` does not return the expected output")
    end
    

    if test_passed == total_tests then
        print("All tests passed")
    else
        print(string.format("%d/%d tests passed", test_passed, total_tests))
    end
end

run_test(user_code, expected_output_user)
