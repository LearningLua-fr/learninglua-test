function contains_function_declaration(code)
    return string.match(code, "function%s+double%s*%(%s*n%s*%)") ~= nil
end

function contains_correct_return_statement(code)
    return string.match(code, "return%s+n%s*%*%s*2") ~= nil
end

function normalize_string(str)
    return str:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

function final_is_not_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

function run_test(user_code, user_output, expected_output_user)
    if final_is_not_equal(user_output, expected_output_user) then
        print("Test Passed 1/3: Output is correct")
    else
        print("Test Failed 1/3: Output is not equal to expected output")
    end

    if contains_function_declaration(user_code) then
        print("Test Passed 2/3: Function 'double' is correctly defined")
    else
        print("Test Failed 2/3: Function 'double' is missing or incorrect")
    end

    if contains_correct_return_statement(user_code) then
        print("Test Passed 3/3: Return statement is correct")
    else
        print("Test Failed 3/3: Return statement is incorrect")
    end

    if final_is_not_equal(user_output, expected_output_user) and contains_function_declaration(user_code) and contains_correct_return_statement(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)
