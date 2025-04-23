function contains_function(code)
    return code:match("function%s+isValid")
end

function contains_valid_tests(code)
    return code:match('isValid%s*%(%s*"{%[%(%)]}"%s*%)') and code:match('isValid%s*%(%s*"{%[%(%]%)}"%s*%)')
end

function output_is_correct(output)
    output = output:gsub("\r", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return output == "true\nfalse"
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0

    if contains_function(user_code) then
        print("Test 1/5 Passed: Function 'isValid' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'isValid' is missing")
    end

    if contains_valid_tests(user_code) then
        print("Test 2/5 Passed: Function is called with valid and invalid cases")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Required function calls are missing")
    end

    if not user_code:match("console%.log") then
        print("Test 3/5 Passed: console.log is not used")
        passed = passed + 1
    else
        print("Test 3/5 Failed: console.log is forbidden")
    end

    if not (user_code:match("true") and user_code:match("false") and not user_code:match("isValid")) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
    end

    if output_is_correct(user_output) then
        print("Test 5/5 Passed: Output is correct")
        passed = passed + 1
    else
        print("Test 5/5 Failed: Output is incorrect")
    end

    if passed == 5 then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)