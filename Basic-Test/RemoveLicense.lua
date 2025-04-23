function contains_function_declaration(code)
    return string.match(code, "function%s+ExtractLicense%s*%(%s*[%w_]+%s*%)") ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in string.gmatch(code, "print%s*%(") do
        count = count + 1
    end
    return count == 1
end

function contains_hardcoded_output(code, expected_output)
    local pattern = 'print%s*%(%s*["\']' .. expected_output .. '["\']%s*%)'
    return string.match(code, pattern) ~= nil
end

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 4

    if contains_function_declaration(user_code) then
        print("Test 1/4 Passed: Function 'ExtractLicense' is correctly defined")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Function 'ExtractLicense' is missing or incorrect")
    end

    if contains_single_print(user_code) then
        print("Test 2/4 Passed: Only one print() statement detected")
        passed = passed + 1
    else
        print("Test 2/4 Failed: Too many print() calls (only one allowed)")
    end

    if not contains_hardcoded_output(user_code, expected_output_user) then
        print("Test 3/4 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Output is hardcoded directly in print()")
    end

    if trim(user_output) == trim(expected_output_user) then
        print("Test 4/4 Passed: Output is correct")
        passed = passed + 1
    else
        print(string.format("Test 4/4 Failed: Expected '%s', but got '%s'", expected_output_user, user_output))
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end


run_test(user_code, user_output, expected_output_user)
