local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_direct_number_output(code)
    -- Empêche l'utilisation directe de nombres dans stdout.write
    return string.match(code, "process%.stdout%.write%s*%(%s*%d+%s*%)") ~= nil
        or string.match(code, "process%.stdout%.write%s*%(%s*['\"]%d+['\"]%s*%)") ~= nil
end

local function uses_stdout_write(code)
    return string.match(code, "process%.stdout%.write%s*%(") ~= nil
end

local function normalize_output(str)
    return (str or ""):gsub("%s+", ""):gsub("[\r\n]", "")
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if contains_console_log(user_code) then
        print("Test 1/5 Failed: console.log is used")
        passed = false
    else
        print("Test 1/5 Passed: console.log is not used")
    end

    if contains_direct_number_output(user_code) then
        print("Test 2/5 Failed: Hardcoded number in output detected")
        passed = false
    else
        print("Test 2/5 Passed: Output is not hardcoded")
    end

    if uses_stdout_write(user_code) then
        print("Test 3/5 Passed: Uses process.stdout.write")
    else
        print("Test 3/5 Failed: Does not use process.stdout.write")
        passed = false
    end

    local expected = normalize_output(expected_output_user)
    local actual = normalize_output(user_output)

    if expected == actual then
        print("Test 4/5 Passed: Output matches expected result")
    else
        print("Test 4/5 Failed: Output does not match expected result")
        passed = false
    end

    -- Résumé
    if passed then
        print("Test 5/5 Passed: All tests passed")
    else
        print("Test 5/5 Failed: One or more tests failed")
    end
end


run_test(user_code, user_output, expected_output_user)
