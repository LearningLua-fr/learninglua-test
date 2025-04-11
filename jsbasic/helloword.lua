local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function final_is_equal(a, b)
    return a:gsub("%s+", " ") == b:gsub("%s+", " ")
end

print("== Début du test ==")

if contains_console_log(user_code) then
    print("console.log utilisé ❌")
else
    print("console.log non utilisé ✅")
end

if final_is_equal(user_output, expected_output_user) then
    print("Sortie correcte ✅")
else
    print("Sortie incorrecte ❌")
end
