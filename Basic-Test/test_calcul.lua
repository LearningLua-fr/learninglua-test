
function contains_correct_variables(code)
    local has_a = string.match(code, "local%s+a%s*=%s*5")
    local has_b = string.match(code, "local%s+b%s*=%s*10")
    return has_a ~= nil and has_b ~= nil
end

function contains_sum_statement(code)
    return string.match(code, "a%s*%+%s*b") ~= nil
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
        print("Test Passed 1/3: Output is correct")
    else
        print("Test Failed 1/3: Output is not equal to expected output")
    end

    if contains_correct_variables(user_code) then
        print("Test Passed 2/3: Variables a and b are correct")
    else
        print("Test Failed 2/3: Variables a and b are missing or incorrect")
    end

    if contains_sum_statement(user_code) then
        print("Test Passed 3/3: Sum of a and b is correct")
    else
        print("Test Failed 3/3: Sum statement is missing or incorrect")
    end

    if final_is_not_equal(user_output, expected_output_user) and contains_correct_variables(user_code) and contains_sum_statement(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)
