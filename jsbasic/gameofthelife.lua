local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_hardcoded_number(code)
    -- Interdit d'écrire "768" en dur
    return string.match(code, "[\"']?768[\"']?") ~= nil
end

local function uses_stdout_write(code)
    return string.match(code, "process%.stdout%.write%s*%(") ~= nil
end

local function normalize_output(str)
    return string.gsub(str, "%s+", ""):gsub("[\r\n]", "")
end

local function run_test(user_code, user_output, expected_output_user)
    local all_passed = true

    if contains_console_log(user_code) then
        print("Test 1/5 Failed: console.log is used")
        all_passed = false
    else
        print("Test 1/5 Passed: console.log is not used")
    end

    if contains_hardcoded_number(user_code) then
        print("Test 2/5 Failed: Output '768' is hardcoded")
        all_passed = false
    else
        print("Test 2/5 Passed: No hardcoded result")
    end

    if uses_stdout_write(user_code) then
        print("Test 3/5 Passed: Uses process.stdout.write")
    else
        print("Test 3/5 Failed: Does not use process.stdout.write")
        all_passed = false
    end

    local expected = normalize_output(expected_output_user or "768")
    local actual = normalize_output(user_output or "")

    if expected == actual then
        print("Test 4/5 Passed: Output is correct")
    else
        print("Test 4/5 Failed: Output is not correct")
        all_passed = false
    end

    if all_passed then
        print("Test 5/5 Passed: All checks passed")
    else
        print("Test 5/5 Failed: One or more checks failed")
    end
end

-- Exécution automatique
run_test(user_code, user_output, expected_output_user)
