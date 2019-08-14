local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

GlobalVar("g_AutoFillMechanizedDepots", {})

function OnMsg.NewHour()
  if CurrentModOptions.Disable then return end

  local UniversalStorageDepots = UICity.labels.UniversalStorageDepot
  if not UniversalStorageDepots then return end
  if not #UniversalStorageDepots then return end

  local MechanizedDepots = UICity.labels.MechanizedDepot
  if not MechanizedDepots then return end
  if not #MechanizedDepots then return end

  local keep_filling_depot = {}
  local g_AutoFillMechanizedDepots = g_AutoFillMechanizedDepots

  local IgnoreUniversal = CurrentModOptions.IgnoreUniversal

  for _, storage in ipairs(UniversalStorageDepots) do
    local storable_resources = storage.storable_resources
    if IgnoreUniversal and #storable_resources > 1 then goto next_storage end
    for _, resource in ipairs(storable_resources) do
      local stored_amount = storage:GetStoredAmount(resource)
      local max_storage = storage:GetMaxStorage(resource)
      if stored_amount > MulDivRound(max_storage, 95, 100) then
        g_AutoFillMechanizedDepots[resource] = true
      end
      if stored_amount > MulDivRound(max_storage, 90, 100) then
        keep_filling_depot[resource] = true
      end
    end
    ::next_storage::
  end

  print("AutoFillMechanizedDepots:", g_AutoFillMechanizedDepots, keep_filling_depot)

  for resource in pairs(g_AutoFillMechanizedDepots) do
    if not keep_filling_depot[resource] then
      g_AutoFillMechanizedDepots[resource] = nil
    end
  end

  orig_print("AutoFillMechanizedDepots:", g_AutoFillMechanizedDepots)

  for _, storage in ipairs(MechanizedDepots) do
    if g_AutoFillMechanizedDepots[storage.resource] then
      storage:SetDesiredAmount(storage:GetMaxStorageForAnyOneResource())
      storage:SetPriority(1)
    else
      storage:SetDesiredAmount(0)
      storage:SetPriority(2)
    end
  end
end

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
