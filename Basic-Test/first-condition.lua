function contains_correct_variables(code)
    local has_paris = string.match(code, "local%s+Paris%s*=%s*2161000")
    local has_londres = string.match(code, "local%s+Londres%s*=%s*8982000")
    return has_paris ~= nil and has_londres ~= nil
end

function contains_if_statement(code)
    return string.match(code, "if%s+Paris%s*>%s*Londres") ~= nil or string.match(code, "if%s+Londres%s*>%s*Paris") ~= nil
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

    if contains_correct_variables(user_code) then
        print("Test Passed 2/3: Variables Paris and Londres are correctly defined")
    else
        print("Test Failed 2/3: Variables Paris and Londres are missing or incorrect")
    end

    if contains_if_statement(user_code) then
        print("Test Passed 3/3: If statement is correctly used")
    else
        print("Test Failed 3/3: If statement is missing or incorrect")
    end

    if final_is_not_equal(user_output, expected_output_user) and contains_correct_variables(user_code) and contains_if_statement(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)
