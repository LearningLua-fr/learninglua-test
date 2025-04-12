local lfs = require("lfs")

-- Fonction utilitaire
local function normalize_string(str)
    return string.gsub(str, "%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

local function file_exists(filename)
    local f = io.open(filename, "r")
    if f then
        f:close()
        return true
    end
    return false
end

local function read_file(filename)
    local f = io.open(filename, "r")
    if not f then return nil end
    local content = f:read("*all")
    f:close()
    return content
end

-- Vérifie si "fs" est utilisé
local function uses_fs_module(code)
    return string.match(code, "require%s*%(?%s*['\"]fs['\"]%s*%)?") or string.match(code, "fs%.")
end

-- Vérifie si un print("Bonjour") direct est présent
local function has_direct_bonjour_print(code)
    return string.match(code, 'console%.log%s*%(%s*["\']Bonjour["\']%s*%)') ~= nil
end

-- Test principal
local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    -- Test 1 : fs utilisé
    if uses_fs_module(user_code) then
        print("Test Passed 1/5: fs module is used.")
    else
        print("Test Failed 1/5: fs module is not used.")
        passed = false
    end

    -- Test 2 : fichier input.txt existe
    if file_exists("input.txt") then
        print("Test Passed 2/5: input.txt was created.")
    else
        print("Test Failed 2/5: input.txt not found.")
        passed = false
    end

    -- Test 3 : contenu du fichier
    local content = read_file("input.txt")
    if content and normalize_string(content) == "Bonjour" then
        print("Test Passed 3/5: input.txt contains 'Bonjour'.")
    else
        print("Test Failed 3/5: input.txt does not contain 'Bonjour'.")
        passed = false
    end

    -- Test 4 : Pas de console.log direct
    if has_direct_bonjour_print(user_code) then
        print("Test Failed 4/5: Direct console.log('Bonjour') used.")
        passed = false
    else
        print("Test Passed 4/5: No direct console.log('Bonjour').")
    end

    -- Test 5 : output affiché correctement
    if normalize_string(user_output) == "Bonjour" then
        print("Test Passed 5/5: Output is 'Bonjour'.")
    else
        print("Test Failed 5/5: Output is not 'Bonjour'.")
        passed = false
    end

    if passed then
        print("✅ All tests passed.")
    else
        print("❌ Some tests failed.")
    end
end

-- Exécution
run_test(user_code, user_output, expected_output_user)
