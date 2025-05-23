function contains_function_declaration(code)
    return string.match(code, "function%s+Capitalize%s*%(%s*[%w_]+%s*%)") ~= nil
end

function uses_string_upper(code)
    return string.match(code, "string%.upper%s*%(%s*[%w_]+%s*%)") ~= nil
end

function uses_for_loop(code)
    return string.match(code, "for%s+[%w_]+%s*=.*do") ~= nil and
           string.match(code, "string%.sub%s*%(") ~= nil
end

function contains_valid_logic(code)
    return uses_string_upper(code) or uses_for_loop(code)
end

-- Trim leading/trailing whitespace (including \n and \r)
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 3

    if contains_function_declaration(user_code) then
        print("Test 1/3 Passed: Function 'Capitalize' is correctly defined")
        passed = passed + 1
    else
        print("Test 1/3 Failed: Function 'Capitalize' is missing or incorrect")
    end

    if contains_valid_logic(user_code) then
        print("Test 2/3 Passed: Valid logic used (string.upper or loop with string.sub)")
        passed = passed + 1
    else
        print("Test 2/3 Failed: No valid logic detected (missing string.upper or loop)")
    end

    local trimmed_user_output = trim(user_output)
    local trimmed_expected_output = trim(expected_output_user)

    if trimmed_user_output == trimmed_expected_output then
        print("Test 3/3 Passed: Output is correct")
        passed = passed + 1
    else
        print(string.format("Test 3/3 Failed: Expected '%s', but got '%s'", trimmed_expected_output, trimmed_user_output))
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)
