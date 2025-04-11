local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function normalize_string(str)
    local normalized = string.gsub(str, "%s+", " ")
    return string.gsub(normalized, "^%s*(.-)%s*$", "%1")
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if final_is_equal(user_output, expected_output_user) then
        print("✅ Test 1/2 Passed: Output matches expected output.")
    else
        print("❌ Test 1/2 Failed: Output does not match expected output.")
        passed = false
    end

    if contains_console_log(user_code) then
        print("❌ Test 2/2 Failed: console.log is forbidden but found in the code.")
        passed = false
    else
        print("✅ Test 2/2 Passed: console.log is not used.")
    end

    if passed then
        print("🎉 All tests passed.")
    else
        print("⚠️ Some tests failed. Please review your code.")
    end
end

-- Lancement du test
run_test(user_code, user_output, expected_output_user)
