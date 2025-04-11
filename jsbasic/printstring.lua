local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_function(code)
    return string.match(code, "function%s+printString%s*%(") ~= nil
end

local function calls_print_function(code)
    return string.match(code, "printString%s*%(%s*%)") ~= nil
end

local function normalize_string(str)
    return string.gsub(str, "%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)

    print("DEBUG - Comparing:")
    print("User output     : [" .. normalized_user_output .. "]")
    print("Expected output : [" .. normalized_expected_output .. "]")

    return normalized_user_output == normalized_expected_output
end

local function run_test(user_code, user_output, expected_output_user)
    local tests_passed = true

    if contains_console_log(user_code) then
        print("❌ Test 1/5 Failed: console.log is forbidden.")
        tests_passed = false
    else
        print("✅ Test 1/5 Passed: No console.log used.")
    end

    if contains_function(user_code) then
        print("✅ Test 2/5 Passed: printString function is defined.")
    else
        print("❌ Test 2/5 Failed: printString function is missing.")
        tests_passed = false
    end

    if calls_print_function(user_code) then
        print("✅ Test 3/5 Passed: printString is called.")
    else
        print("❌ Test 3/5 Failed: printString is not called.")
        tests_passed = false
    end

    if final_is_equal(user_output, expected_output_user) then
        print("✅ Test 4/5 Passed: Output matches expected.")
    else
        print("❌ Test 4/5 Failed: Output mismatch.")
        tests_passed = false
    end

    if tests_passed then
        print("🎉 Test 5/5: All tests passed.")
    else
        print("⚠️ Test 5/5: Some tests failed. Check your implementation.")
    end
end

run_test(user_code, user_output, expected_output_user)
