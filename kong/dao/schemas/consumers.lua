local stringy = require "stringy"
local constants = require "kong.constants"

local function check_custom_id_and_username(value, consumer_t)
  local username = type(consumer_t.username) == "string" and stringy.strip(consumer_t.username) or ""
  local custom_id = type(consumer_t.custom_id) == "string" and stringy.strip(consumer_t.custom_id) or ""

  if custom_id == "" and username == "" then
    return false, "At least a 'custom_id' or a 'username' must be specified"
  end

  return true
end

return {
  id = { type = constants.DATABASE_TYPES.ID },
  custom_id = { type = "string", unique = true, queryable = true, func = check_custom_id_and_username },
  username = { type = "string", unique = true, queryable = true, func = check_custom_id_and_username },
  created_at = { type = constants.DATABASE_TYPES.TIMESTAMP }
}
