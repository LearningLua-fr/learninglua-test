local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function defines_print_function(code)
    return string.match(code, "function%s+printString%s*%(") ~= nil
end

local function uses_process_stdout(code)
    return string.match(code, "process%.stdout%.write%s*%(") ~= nil
end

local function file_exists(filename)
    local file = io.open(filename, "r")
    if file then file:close() return true end
    return false
end

local function read_file(filename)
    local file = io.open(filename, "r")
    if not file then return nil end
    local content = file:read("*a")
    file:close()
    return content
end

local function expected_output_string()
    local str = ""
    for i = 1, 1000 do
        str = str .. i
        if i < 1000 then
            str = str .. ","
        end
    end
    return str
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if contains_console_log(user_code) then
        print("Test 1/6 Failed: console.log is forbidden.")
        passed = false
    else
        print("Test 1/6 Passed: No console.log used.")
    end

    if defines_print_function(user_code) and uses_process_stdout(user_code) then
        print("Test 2/6 Passed: printString is defined and uses process.stdout.write.")
    else
        print("Test 2/6 Failed: printString missing or invalid.")
        passed = false
    end

    if file_exists("numbers.txt") then
        print("Test 3/6 Passed: numbers.txt exists.")
    else
        print("Test 3/6 Failed: numbers.txt not found.")
        passed = false
    end

    local file_content = read_file("numbers.txt")
    local expected = expected_output_string()
    if file_content == expected then
        print("Test 4/6 Passed: File content is correct.")
    else
        print("Test 4/6 Failed: File content is incorrect.")
        passed = false
    end

    if user_output == expected then
        print("Test 5/6 Passed: Output matches expected.")
    else
        print("Test 5/6 Failed: Output does not match expected.")
        passed = false
    end

    if passed then
        print("Test 6/6 Passed: All checks passed.")
    else
        print("Test 6/6 Failed: Some checks failed.")
    end
end

-- Execution
run_test(user_code, user_output, expected_output_user)
