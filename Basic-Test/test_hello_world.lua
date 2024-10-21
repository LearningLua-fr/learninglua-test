function contains_print_statement(code)
    return string.match(code, "print%(") ~= nil
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

function run_test(user_code, user_output, expected_output_user)
    if final_is_not_equal(user_output, expected_output_user) then
        print("Test Passed 1/2")
    else
        print("Test Failed 1/2: Output is not equal to expected output")
    end

    if contains_print_statement(user_code) then
        print("Test Passed 2/2")
    else
        print("Test Failed 2/2: No print statement found in the code")
    end
end

run_test(user_code, user_output, expected_output_user)
