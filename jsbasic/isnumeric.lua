local function contains_is_numeric(code)
    return string.match(code, "function%s+isNumeric%s*%(") ~= nil
end

local function contains_two_returns(code)
    local return_count = 0
    for _ in string.gmatch(code, "return") do
        return_count = return_count + 1
    end
    return return_count == 2
end

local function contains_one_print(code)
    return string.match(code, "console.log%s*%(") ~= nil
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = string.gsub(user_output, "%s+", " ")
    local normalized_expected_output = string.gsub(expected_output_user, "%s+", " ")
    return normalized_user_output == normalized_expected_output
end

local function run_test(user_code, user_output, expected_output_user)
    local tests_passed = true

    if contains_is_numeric(user_code) then
        print("Test Passed 1/4: 'isNumeric' function is defined.")
    else
        print("Test Failed 1/4: 'isNumeric' function is not defined.")
        tests_passed = false
    end

    if contains_two_returns(user_code) then
        print("Test Passed 2/4: 'isNumeric' contains exactly two return statements.")
    else
        print("Test Failed 2/4: 'isNumeric' does not contain exactly two return statements.")
        tests_passed = false
    end

    if contains_one_print(user_code) then
        print("Test Passed 3/4: 'isNumeric' contains exactly one print statement.")
    else
        print("Test Failed 3/4: 'isNumeric' does not contain exactly one print statement.")
        tests_passed = false
    end

    -- Vérification de l'égalité entre user_output et expected_output_user
    if final_is_equal(user_output, expected_output_user) then
        print("Test Passed 4/4: Output is as expected.")
    else
        print(user_output)
        print("Test Failed 4/4: Output is not as expected.")
        tests_passed = false
    end

    if tests_passed then
        print("All tests passed.")
    else
        print("Some tests failed. Please review your code.")
    end
end

run_test(user_code, user_output, expected_output_user)
