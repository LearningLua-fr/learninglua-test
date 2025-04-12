local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_direct_bonjour(code)
    return string.match(code, "[\"']Bonjour[\"']") ~= nil and not string.match(code, "fs%.writeFileSync")
end

local function contains_fs_usage(code)
    return string.match(code, "require%s*%(?['\"]fs['\"]%)?") ~= nil
end

local function creates_input_txt(code)
    return string.match(code, "writeFileSync%s*%(%s*['\"]input%.txt['\"]") ~= nil
end

local function reads_input_txt(code)
    return string.match(code, "readFileSync%s*%(%s*['\"]input%.txt['\"]") ~= nil
end

local function output_correct(user_output, expected_output_user)
    local norm = function(s) return s:gsub("%s+", "") end
    return norm(user_output) == norm(expected_output_user)
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if contains_console_log(user_code) then
        print("Test 1/6 Failed: console.log is forbidden.")
        passed = false
    else
        print("Test 1/6 Passed: No console.log used.")
    end

    if contains_direct_bonjour(user_code) then
        print("Test 2/6 Failed: Direct Bonjour usage not allowed unless used in fs.writeFileSync.")
        passed = false
    else
        print("Test 2/6 Passed: No direct Bonjour found.")
    end

    if not contains_fs_usage(user_code) then
        print("Test 3/6 Failed: fs module not required.")
        passed = false
    else
        print("Test 3/6 Passed: fs module required.")
    end

    if not creates_input_txt(user_code) then
        print("Test 4/6 Failed: input.txt not created.")
        passed = false
    else
        print("Test 4/6 Passed: input.txt is created.")
    end

    if not reads_input_txt(user_code) then
        print("Test 5/6 Failed: input.txt is not read.")
        passed = false
    else
        print("Test 5/6 Passed: input.txt is read.")
    end

    if output_correct(user_output, expected_output_user) then
        print("Test 6/6 Passed: Output is correct.")
    else
        print("Test 6/6 Failed: Output is incorrect.")
        passed = false
    end

    if passed then
        print("All tests passed.")
    else
        print("Some tests failed.")
    end
end

-- Execution
run_test(user_code, user_output, expected_output_user)
