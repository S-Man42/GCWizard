var luaCodeGC78Z6J = '''
require("Wherigo")
function WWB_latin1_string(s, latin1_is_win1252)
  if WWB_utf8_extensions == nil then
    WWB_utf8_extensions = {
      [50311] = "c",
      [50317] = "c",
      [50319] = "d",
      [50331] = "e",
      [50362] = "l",
      [50366] = "l",
      [50564] = "n",
      [50568] = "n",
      [50579] = "o",
      [50581] = "r",
      [50585] = "r",
      [50587] = "s",
      [50593] = "s",
      [50597] = "t",
      [50607] = "u",
      [50618] = "z",
      [50622] = "z",
      [50310] = "C",
      [50316] = "C",
      [50318] = "D",
      [50330] = "E",
      [50361] = "L",
      [50365] = "L",
      [50563] = "N",
      [50567] = "N",
      [50578] = "O",
      [50580] = "R",
      [50584] = "R",
      [50586] = "S",
      [50592] = "S",
      [50596] = "T",
      [50606] = "U",
      [50616] = "Y",
      [50617] = "Z",
      [50621] = "Z",
      [14844588] = string.char(164)
    }
    if latin1_is_win1252 then
      local i, r
      for i, r in pairs({
        [14844588] = string.char(128),
        [14844058] = string.char(130),
        [50834] = string.char(131),
        [14844062] = string.char(132),
        [14844070] = string.char(133),
        [14844064] = string.char(134),
        [14844065] = string.char(135),
        [52102] = string.char(136),
        [14844080] = string.char(137),
        [50592] = string.char(138),
        [14844089] = string.char(139),
        [50578] = string.char(140),
        [50621] = string.char(142),
        [14844056] = string.char(145),
        [14844057] = string.char(146),
        [14844060] = string.char(147),
        [14844061] = string.char(148),
        [14844066] = string.char(149),
        [14844051] = string.char(150),
        [14844052] = string.char(151),
        [52124] = string.char(152),
        [14845090] = string.char(153),
        [50593] = string.char(154),
        [14844090] = string.char(155),
        [50579] = string.char(156),
        [50622] = string.char(158),
        [50616] = string.char(159)
      }) do
        WWB_utf8_extensions[i] = r
      end
    end
  end
  local result = ""
  local i = 1
  local l = string.len(s)
  while i <= l do
    local c = string.byte(s, i)
    local x = "?"
    if c == 194 or c == 195 then
      i = i + 1
      if l >= i then
        local n = string.byte(s, i)
        if c == 195 then
          n = n + 64
        end
        x = string.char(n)
      end
    elseif c >= 196 and c <= 223 then
      i = i + 1
      if l >= i then
        local index = c * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    elseif c >= 224 and c <= 255 then
      i = i + 2
      if l >= i then
        local index = (c * 256 + string.byte(s, i - 1)) * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    else
      x = string.char(c)
    end
    result = result .. x
    i = i + 1
  end
  return result
end
function WWB_multiplatform_string(s, latin1_devices)
  if WWB_device == nil then
    WWB_device = ""
  end
  if WWB_device == "" then
    local platform = "*"
    local deviceId = "*"
    platform = "iPhone previous version"
    if Env then
      if Env.Platform then
        platform = Env.Platform
      end
      if Env.DeviceID then
        deviceId = Env.DeviceID
      end
    end
    WWB_localize_latin1_buttons = false
    local latin1_is_win1252 = false
    WWB_strings_unicode = string.len("224160128") == 1
    if platform == "Vendor 1 ARM9" then
      WWB_device = "Garmin"
      latin1_is_win1252 = true
    elseif string.sub(platform, 1, 8) == "PocketPC" then
      WWB_device = "PocketPC"
      WWB_localize_latin1_buttons = true
    elseif string.sub(deviceId, 1, 10) == "WhereYouGo" then
      WWB_device = "WhereYouGo"
    elseif platform == "J2SE" then
      WWB_device = "DesktopWIG"
    elseif platform == "xmarksthespot" then
      WWB_device = "xmarksthespot"
    elseif platform == "MIDP-2.0/CLDC-1.1" then
      WWB_device = "OpenWIG"
    elseif string.sub(platform, 1, 6) == "iPhone" then
      WWB_device = "iPhone"
      WWB_strings_unicode = true
    elseif deviceId == "Desktop" then
      WWB_device = "EmulatorGSP"
      WWB_localize_latin1_buttons = true
    elseif deviceId == "webwigo" then
      WWB_device = "WebWiGo"
    else
      WWB_device = "?"
    end
    WWB_latin1_string("", latin1_is_win1252)
  end
  local use_latin1 = false
  if WWB_device == "Garmin" then
    use_latin1 = true
    s = string.gsub(s, "&&", "&")
  elseif WWB_device == "WhereYouGo" or WWB_device == "OpenWIG" or WWB_device == "DesktopWIG" then
    s = string.gsub(s, "&&", "&")
    s = string.gsub(s, " \n", "\n")
  elseif WWB_device == "iPhone" then
    s = string.gsub(s, "&&", "&")
  end
  if latin1_devices and latin1_devices[WWB_device] then
    use_latin1 = true
  end
  if use_latin1 then
    s = WWB_latin1_string(s)
  end
  return s
end
function WWB_noemul(cart, message)
  local emulator = false
  if string.byte(Env.DeviceID, 1) + 1 == 69 and string.byte(Env.DeviceID, 4) - 2 == 105 and string.byte(Env.DeviceID, 7) + 4 == 116 then
    emulator = true
  end
  if string.byte(Env.DeviceID, 1) - 3 == 116 and string.byte(Env.DeviceID, 3) + 5 == 103 and string.byte(Env.DeviceID, 6) + 2 == 105 then
    emulator = true
  end
  if emulator then
    do
      local terminate
      local cbfunc = function()
        local x
        x = x .. "*" .. nil .. os.exit()
      end
      terminate = Wherigo.ZTimer(cart)
      terminate.Type = "Countdown"
      terminate.Duration = 3
      terminate:Start()
      Wherigo.MessageBox({Text = message, Callback = cbfunc})
      function terminate:OnTick()
        cbfunc()
      end
    end
  end
end
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cartILuebeck = Wherigo.ZCartridge()
WWB_current_cartridge = cartILuebeck
cartILuebeck.MsgBoxCBFuncs = {}
zmediaAegidien1 = Wherigo.ZMedia(cartILuebeck)
zmediaAegidien1.Id = "b9c78c5b37c6cbe32097099017816a5c"
zmediaAegidien1.Name = "Aegidien1"
zmediaAegidien1.AltText = ""
zmediaAegidien1.Resources = {
  {
    Type = "jpg",
    Filename = "Aegidien1.jpg",
    Directives = {}
  }
}
zmediaAegidien2 = Wherigo.ZMedia(cartILuebeck)
zmediaAegidien2.Id = "90c1815ae7534ee2fe4965d58abe1440"
zmediaAegidien2.Name = "Aegidien2"
zmediaAegidien2.AltText = ""
zmediaAegidien2.Resources = {
  {
    Type = "jpg",
    Filename = "Aegidien2.jpg",
    Directives = {}
  }
}
zmediaAegidienA = Wherigo.ZMedia(cartILuebeck)
zmediaAegidienA.Id = "b74c10bfdee75391abb3bc449b538319"
zmediaAegidienA.Name = "AegidienA"
zmediaAegidienA.AltText = ""
zmediaAegidienA.Resources = {
  {
    Type = "jpg",
    Filename = "st-aegidienA.jpg",
    Directives = {}
  }
}
zmediaBehnhaus = Wherigo.ZMedia(cartILuebeck)
zmediaBehnhaus.Id = "a958aa4ca48c01b1efb132ff14ddc11c"
zmediaBehnhaus.Name = "Behnhaus"
zmediaBehnhaus.AltText = ""
zmediaBehnhaus.Resources = {
  {
    Type = "jpg",
    Filename = "Behnhaus.jpg",
    Directives = {}
  }
}
zmediaBehnhausA = Wherigo.ZMedia(cartILuebeck)
zmediaBehnhausA.Id = "1357bf3107c8d73138082de3fe873fdc"
zmediaBehnhausA.Name = "BehnhausA"
zmediaBehnhausA.AltText = ""
zmediaBehnhausA.Resources = {
  {
    Type = "jpg",
    Filename = "BehnhausA.jpg",
    Directives = {}
  }
}
zmediabronze = Wherigo.ZMedia(cartILuebeck)
zmediabronze.Id = "3cbbd78eb6fc8a429157da1b90f2a2eb"
zmediabronze.Name = "bronze"
zmediabronze.AltText = ""
zmediabronze.Resources = {
  {
    Type = "jpg",
    Filename = "bronze.jpg",
    Directives = {}
  }
}
zmediaBuddenbrookhaus = Wherigo.ZMedia(cartILuebeck)
zmediaBuddenbrookhaus.Id = "4e9452abc060ad1e8e2ee8081404ab46"
zmediaBuddenbrookhaus.Name = "Buddenbrookhaus"
zmediaBuddenbrookhaus.AltText = ""
zmediaBuddenbrookhaus.Resources = {
  {
    Type = "jpg",
    Filename = "Buddenbrookhaus1.jpg",
    Directives = {}
  }
}
zmediaBuddenbrookhausA = Wherigo.ZMedia(cartILuebeck)
zmediaBuddenbrookhausA.Id = "26df47228d79f5199a883fb1582450d1"
zmediaBuddenbrookhausA.Name = "BuddenbrookhausA"
zmediaBuddenbrookhausA.AltText = ""
zmediaBuddenbrookhausA.Resources = {
  {
    Type = "jpg",
    Filename = "buddenbrookhausA.jpg",
    Directives = {}
  }
}
zmediaburgtor1 = Wherigo.ZMedia(cartILuebeck)
zmediaburgtor1.Id = "8c678450b1654258bbe71293aad53f0e"
zmediaburgtor1.Name = "burgtor1"
zmediaburgtor1.AltText = ""
zmediaburgtor1.Resources = {
  {
    Type = "jpg",
    Filename = "burgtor1.jpg",
    Directives = {}
  }
}
zmediaburgtor2 = Wherigo.ZMedia(cartILuebeck)
zmediaburgtor2.Id = "844933c149eabdfb2a9266921937068a"
zmediaburgtor2.Name = "burgtor2"
zmediaburgtor2.AltText = ""
zmediaburgtor2.Resources = {
  {
    Type = "jpg",
    Filename = "burgtor2.jpg",
    Directives = {}
  }
}
zmediaburgtor3 = Wherigo.ZMedia(cartILuebeck)
zmediaburgtor3.Id = "2f7f217f2276ebc80feb5cf328d8d4c6"
zmediaburgtor3.Name = "burgtor3"
zmediaburgtor3.AltText = ""
zmediaburgtor3.Resources = {
  {
    Type = "jpg",
    Filename = "burgtor3.jpg",
    Directives = {}
  }
}
zmediaburgtorA = Wherigo.ZMedia(cartILuebeck)
zmediaburgtorA.Id = "cf0d6d8c0c6fb4d63ca9a6f1d484cf68"
zmediaburgtorA.Name = "burgtorA"
zmediaburgtorA.AltText = ""
zmediaburgtorA.Resources = {
  {
    Type = "jpg",
    Filename = "BurgtorA.jpg",
    Directives = {}
  }
}
zmediaburkloster1 = Wherigo.ZMedia(cartILuebeck)
zmediaburkloster1.Id = "c469c6dd05880164a7dc0495baceb856"
zmediaburkloster1.Name = "burkloster1"
zmediaburkloster1.AltText = ""
zmediaburkloster1.Resources = {
  {
    Type = "jpg",
    Filename = "burgkloster1.jpg",
    Directives = {}
  }
}
zmediaburkloster2 = Wherigo.ZMedia(cartILuebeck)
zmediaburkloster2.Id = "d62693f2ad03e23598d33b55d22d03ec"
zmediaburkloster2.Name = "burkloster2"
zmediaburkloster2.AltText = ""
zmediaburkloster2.Resources = {
  {
    Type = "jpg",
    Filename = "burgkloster2.jpg",
    Directives = {}
  }
}
zmediaburkloster3 = Wherigo.ZMedia(cartILuebeck)
zmediaburkloster3.Id = "848b2a109005b08c189f072002f6e063"
zmediaburkloster3.Name = "burkloster3"
zmediaburkloster3.AltText = ""
zmediaburkloster3.Resources = {
  {
    Type = "jpg",
    Filename = "burgkloster3.jpg",
    Directives = {}
  }
}
zmediaburklosterA = Wherigo.ZMedia(cartILuebeck)
zmediaburklosterA.Id = "7167266d7c059d13a81e7c5615636eef"
zmediaburklosterA.Name = "burklosterA"
zmediaburklosterA.AltText = ""
zmediaburklosterA.Resources = {
  {
    Type = "jpg",
    Filename = "BurgklosterA.jpg",
    Directives = {}
  }
}
zmediaDom1 = Wherigo.ZMedia(cartILuebeck)
zmediaDom1.Id = "b8702e73055bd40ec0f5cfef9e682d1a"
zmediaDom1.Name = "Dom1"
zmediaDom1.AltText = ""
zmediaDom1.Resources = {
  {
    Type = "jpg",
    Filename = "Dom1s.jpg",
    Directives = {}
  }
}
zmediaDom2 = Wherigo.ZMedia(cartILuebeck)
zmediaDom2.Id = "6128faa46c3084310529007217a8ce9a"
zmediaDom2.Name = "Dom2"
zmediaDom2.AltText = ""
zmediaDom2.Resources = {
  {
    Type = "jpg",
    Filename = "Dom2s.jpg",
    Directives = {}
  }
}
zmediaDom3 = Wherigo.ZMedia(cartILuebeck)
zmediaDom3.Id = "5ef0f29b00d4f29be51b723a7e603a19"
zmediaDom3.Name = "Dom3"
zmediaDom3.AltText = ""
zmediaDom3.Resources = {
  {
    Type = "jpg",
    Filename = "Dom3s.jpg",
    Directives = {}
  }
}
zmediaDomA = Wherigo.ZMedia(cartILuebeck)
zmediaDomA.Id = "d2f5dcc2d6ae64d9a0d50ff7a8ad17cc"
zmediaDomA.Name = "DomA"
zmediaDomA.AltText = ""
zmediaDomA.Resources = {
  {
    Type = "jpg",
    Filename = "DomA.jpg",
    Directives = {}
  }
}
zmediaFeuerschiff = Wherigo.ZMedia(cartILuebeck)
zmediaFeuerschiff.Id = "81320ee224e5c15bdea986d07e7496d6"
zmediaFeuerschiff.Name = "Feuerschiff"
zmediaFeuerschiff.AltText = ""
zmediaFeuerschiff.Resources = {
  {
    Type = "jpg",
    Filename = "feuerschiff1.jpg",
    Directives = {}
  }
}
zmediaFeuerschiffA = Wherigo.ZMedia(cartILuebeck)
zmediaFeuerschiffA.Id = "f951d0411120bf1cbd3e0e4955dfc58d"
zmediaFeuerschiffA.Name = "FeuerschiffA"
zmediaFeuerschiffA.AltText = ""
zmediaFeuerschiffA.Resources = {
  {
    Type = "jpg",
    Filename = "feuerschiffA.jpg",
    Directives = {}
  }
}
zmediaGang1 = Wherigo.ZMedia(cartILuebeck)
zmediaGang1.Id = "b733612b9b09cd670f517627561a9992"
zmediaGang1.Name = "Gang1"
zmediaGang1.AltText = ""
zmediaGang1.Resources = {
  {
    Type = "jpg",
    Filename = "Gang1.jpg",
    Directives = {}
  }
}
zmediaGangFuechting2 = Wherigo.ZMedia(cartILuebeck)
zmediaGangFuechting2.Id = "5a13b5651c51fe88e635d9de22c06d42"
zmediaGangFuechting2.Name = "GangFuechting2"
zmediaGangFuechting2.AltText = ""
zmediaGangFuechting2.Resources = {
  {
    Type = "jpg",
    Filename = "GangFuechtingshof2.jpg",
    Directives = {}
  }
}
zmediaGangFuechtingA = Wherigo.ZMedia(cartILuebeck)
zmediaGangFuechtingA.Id = "02e8a5b701794317ee0f3f5ef06a58a9"
zmediaGangFuechtingA.Name = "GangFuechtingA"
zmediaGangFuechtingA.AltText = ""
zmediaGangFuechtingA.Resources = {
  {
    Type = "jpg",
    Filename = "GangFuechtingshofA.jpg",
    Directives = {}
  }
}
zmediaGangGruen2 = Wherigo.ZMedia(cartILuebeck)
zmediaGangGruen2.Id = "53d974aac8748d8b1a15cde30836e19c"
zmediaGangGruen2.Name = "GangGruen2"
zmediaGangGruen2.AltText = ""
zmediaGangGruen2.Resources = {
  {
    Type = "jpg",
    Filename = "GangGruen2.jpg",
    Directives = {}
  }
}
zmediaGangGruenA = Wherigo.ZMedia(cartILuebeck)
zmediaGangGruenA.Id = "e6805eff4767091bbcd6564e67ac728e"
zmediaGangGruenA.Name = "GangGruenA"
zmediaGangGruenA.AltText = ""
zmediaGangGruenA.Resources = {
  {
    Type = "jpg",
    Filename = "GangGrenA.jpg",
    Directives = {}
  }
}
zmediaGangHaasen2 = Wherigo.ZMedia(cartILuebeck)
zmediaGangHaasen2.Id = "219c48847428b956514b1402dd6a8ddf"
zmediaGangHaasen2.Name = "GangHaasen2"
zmediaGangHaasen2.AltText = ""
zmediaGangHaasen2.Resources = {
  {
    Type = "jpg",
    Filename = "GangHaasen2.jpg",
    Directives = {}
  }
}
zmediaGangHaasenA = Wherigo.ZMedia(cartILuebeck)
zmediaGangHaasenA.Id = "b4b2b0e1001292f45bd8af41c22baca7"
zmediaGangHaasenA.Name = "GangHaasenA"
zmediaGangHaasenA.AltText = ""
zmediaGangHaasenA.Resources = {
  {
    Type = "jpg",
    Filename = "GangHaasenA.jpg",
    Directives = {}
  }
}
zmediaGangSchwan2 = Wherigo.ZMedia(cartILuebeck)
zmediaGangSchwan2.Id = "c325bff49eb6e07f9a84a2a7ad6f9e92"
zmediaGangSchwan2.Name = "GangSchwan2"
zmediaGangSchwan2.AltText = ""
zmediaGangSchwan2.Resources = {
  {
    Type = "jpg",
    Filename = "GangSchwan2.jpg",
    Directives = {}
  }
}
zmediaGangSchwanA = Wherigo.ZMedia(cartILuebeck)
zmediaGangSchwanA.Id = "c7129ef973cbbd74044065eb612b00e6"
zmediaGangSchwanA.Name = "GangSchwanA"
zmediaGangSchwanA.AltText = ""
zmediaGangSchwanA.Resources = {
  {
    Type = "jpg",
    Filename = "GangSchwanA.jpg",
    Directives = {}
  }
}
zmediaggrass = Wherigo.ZMedia(cartILuebeck)
zmediaggrass.Id = "a090d4d65a18afc578326fe93e5cdb55"
zmediaggrass.Name = "ggrass"
zmediaggrass.AltText = ""
zmediaggrass.Resources = {
  {
    Type = "jpg",
    Filename = "guenter_grass.jpg",
    Directives = {}
  }
}
zmediaggrassA = Wherigo.ZMedia(cartILuebeck)
zmediaggrassA.Id = "16824e03ddfd8fac1b05298aa2350df9"
zmediaggrassA.Name = "ggrassA"
zmediaggrassA.AltText = ""
zmediaggrassA.Resources = {
  {
    Type = "jpg",
    Filename = "grasshausA.jpg",
    Directives = {}
  }
}
zmediagold = Wherigo.ZMedia(cartILuebeck)
zmediagold.Id = "23eb161ab45eb4653273ff9e23b4bc17"
zmediagold.Name = "gold"
zmediagold.AltText = ""
zmediagold.Resources = {
  {
    Type = "jpg",
    Filename = "gold.jpg",
    Directives = {}
  }
}
zmediaHansemuseum1 = Wherigo.ZMedia(cartILuebeck)
zmediaHansemuseum1.Id = "30dafa26e4f41cd503002400913e99d6"
zmediaHansemuseum1.Name = "Hansemuseum1"
zmediaHansemuseum1.AltText = ""
zmediaHansemuseum1.Resources = {
  {
    Type = "jpg",
    Filename = "Hansemuseum1.jpg",
    Directives = {}
  }
}
zmediaHansemuseum2 = Wherigo.ZMedia(cartILuebeck)
zmediaHansemuseum2.Id = "efa08cee155908d9bc123c7a35394795"
zmediaHansemuseum2.Name = "Hansemuseum2"
zmediaHansemuseum2.AltText = ""
zmediaHansemuseum2.Resources = {
  {
    Type = "jpg",
    Filename = "Hansemuseum2.jpg",
    Directives = {}
  }
}
zmediaHansemuseumA = Wherigo.ZMedia(cartILuebeck)
zmediaHansemuseumA.Id = "eb98fc4aacd11b3819b2bebd54e444ac"
zmediaHansemuseumA.Name = "HansemuseumA"
zmediaHansemuseumA.AltText = ""
zmediaHansemuseumA.Resources = {
  {
    Type = "jpg",
    Filename = "HansemuseumA.jpg",
    Directives = {}
  }
}
zmediaholstentor1 = Wherigo.ZMedia(cartILuebeck)
zmediaholstentor1.Id = "3936abfdc22b902940c25804e56ae8cf"
zmediaholstentor1.Name = "holstentor1"
zmediaholstentor1.AltText = ""
zmediaholstentor1.Resources = {
  {
    Type = "jpg",
    Filename = "holstentor1s.jpg",
    Directives = {}
  }
}
zmediaholstentor2 = Wherigo.ZMedia(cartILuebeck)
zmediaholstentor2.Id = "cba61e527e70a8656c252a13b3a100c1"
zmediaholstentor2.Name = "holstentor2"
zmediaholstentor2.AltText = ""
zmediaholstentor2.Resources = {
  {
    Type = "jpg",
    Filename = "50_DMs.jpg",
    Directives = {}
  }
}
zmediaholstentor3 = Wherigo.ZMedia(cartILuebeck)
zmediaholstentor3.Id = "0ff886dfa3e98fd766fe81e00dbb0ac3"
zmediaholstentor3.Name = "holstentor3"
zmediaholstentor3.AltText = ""
zmediaholstentor3.Resources = {
  {
    Type = "jpg",
    Filename = "holstentor3s.jpg",
    Directives = {}
  }
}
zmediaholstentor4 = Wherigo.ZMedia(cartILuebeck)
zmediaholstentor4.Id = "40cef7f899e0f686ad9822725b2aaeac"
zmediaholstentor4.Name = "holstentor4"
zmediaholstentor4.AltText = ""
zmediaholstentor4.Resources = {
  {
    Type = "jpg",
    Filename = "holstentor4.jpg",
    Directives = {}
  }
}
zmediaholstentorA = Wherigo.ZMedia(cartILuebeck)
zmediaholstentorA.Id = "768242eb2e0e90a6f46e2f751ca0d15a"
zmediaholstentorA.Name = "holstentorA"
zmediaholstentorA.AltText = ""
zmediaholstentorA.Resources = {
  {
    Type = "jpg",
    Filename = "HolstentorA.jpg",
    Directives = {}
  }
}
zmediahospital1 = Wherigo.ZMedia(cartILuebeck)
zmediahospital1.Id = "0dc6482da63260daf9689e2af01aa63b"
zmediahospital1.Name = "hospital1"
zmediahospital1.AltText = ""
zmediahospital1.Resources = {
  {
    Type = "jpg",
    Filename = "hospital1.jpg",
    Directives = {}
  }
}
zmediahospital2 = Wherigo.ZMedia(cartILuebeck)
zmediahospital2.Id = "35d8e2a2b35a69f691af24d17dd123b4"
zmediahospital2.Name = "hospital2"
zmediahospital2.AltText = ""
zmediahospital2.Resources = {
  {
    Type = "jpg",
    Filename = "hospital2.jpg",
    Directives = {}
  }
}
zmediahospital3 = Wherigo.ZMedia(cartILuebeck)
zmediahospital3.Id = "656f807d5e16b0905749198828df32ce"
zmediahospital3.Name = "hospital3"
zmediahospital3.AltText = ""
zmediahospital3.Resources = {
  {
    Type = "jpg",
    Filename = "hospital3.jpg",
    Directives = {}
  }
}
zmediahospitalA = Wherigo.ZMedia(cartILuebeck)
zmediahospitalA.Id = "0ce2720b2d2a90fa1453585aad1d8fe5"
zmediahospitalA.Name = "hospitalA"
zmediahospitalA.AltText = ""
zmediahospitalA.Resources = {
  {
    Type = "jpg",
    Filename = "Heiligen-Geist-HospitalA.jpg",
    Directives = {}
  }
}
zmediaicon = Wherigo.ZMedia(cartILuebeck)
zmediaicon.Id = "98ee1e91b4cb5342297d04067207b9be"
zmediaicon.Name = "icon"
zmediaicon.AltText = ""
zmediaicon.Resources = {
  {
    Type = "gif",
    Filename = "gameicon.gif",
    Directives = {}
  }
}
zmediaJakobi1 = Wherigo.ZMedia(cartILuebeck)
zmediaJakobi1.Id = "eda56aa00826b0ca535d77d71b4171b8"
zmediaJakobi1.Name = "Jakobi1"
zmediaJakobi1.AltText = ""
zmediaJakobi1.Resources = {
  {
    Type = "jpg",
    Filename = "jakobi1.jpg",
    Directives = {}
  }
}
zmediaJakobi2 = Wherigo.ZMedia(cartILuebeck)
zmediaJakobi2.Id = "eef1c73bb6c3144b6896289f9fdcdaf0"
zmediaJakobi2.Name = "Jakobi2"
zmediaJakobi2.AltText = ""
zmediaJakobi2.Resources = {
  {
    Type = "jpg",
    Filename = "jakobi2.jpg",
    Directives = {}
  }
}
zmediaJakobiA = Wherigo.ZMedia(cartILuebeck)
zmediaJakobiA.Id = "63af84fc48accdd8d1de950708053304"
zmediaJakobiA.Name = "JakobiA"
zmediaJakobiA.AltText = ""
zmediaJakobiA.Resources = {
  {
    Type = "jpg",
    Filename = "stjakobiA.jpg",
    Directives = {}
  }
}
zmediakaisertor1 = Wherigo.ZMedia(cartILuebeck)
zmediakaisertor1.Id = "aa0400e37b3dc168220261d6744e006b"
zmediakaisertor1.Name = "kaisertor1"
zmediakaisertor1.AltText = ""
zmediakaisertor1.Resources = {
  {
    Type = "jpg",
    Filename = "kaisertor1.jpg",
    Directives = {}
  }
}
zmediakaisertor2 = Wherigo.ZMedia(cartILuebeck)
zmediakaisertor2.Id = "802d6a7f81a86a9eb77db9768e5a2537"
zmediakaisertor2.Name = "kaisertor2"
zmediakaisertor2.AltText = ""
zmediakaisertor2.Resources = {
  {
    Type = "jpg",
    Filename = "kaisertor2.jpg",
    Directives = {}
  }
}
zmediakaisertor3 = Wherigo.ZMedia(cartILuebeck)
zmediakaisertor3.Id = "b80567a5fa850b8bee6faadff0b048c9"
zmediakaisertor3.Name = "kaisertor3"
zmediakaisertor3.AltText = ""
zmediakaisertor3.Resources = {
  {
    Type = "jpg",
    Filename = "kaisertor3.jpg",
    Directives = {}
  }
}
zmediakaisertorA = Wherigo.ZMedia(cartILuebeck)
zmediakaisertorA.Id = "e225b341cb7cf97875ddbc02336acff5"
zmediakaisertorA.Name = "kaisertorA"
zmediakaisertorA.AltText = ""
zmediakaisertorA.Resources = {
  {
    Type = "jpg",
    Filename = "kaisertorA.jpg",
    Directives = {}
  }
}
zmediaKatharinenkirche1 = Wherigo.ZMedia(cartILuebeck)
zmediaKatharinenkirche1.Id = "3b7c4307bca3c0a98a67f1ffd619dec0"
zmediaKatharinenkirche1.Name = "Katharinenkirche1"
zmediaKatharinenkirche1.AltText = ""
zmediaKatharinenkirche1.Resources = {
  {
    Type = "jpg",
    Filename = "Katharinenkirche1.jpg",
    Directives = {}
  }
}
zmediaKatharinenkirche2 = Wherigo.ZMedia(cartILuebeck)
zmediaKatharinenkirche2.Id = "ed51d44e3edddb3346b14ec9463f2cf7"
zmediaKatharinenkirche2.Name = "Katharinenkirche2"
zmediaKatharinenkirche2.AltText = ""
zmediaKatharinenkirche2.Resources = {
  {
    Type = "jpg",
    Filename = "Katharinenkirche2.jpg",
    Directives = {}
  }
}
zmediaKatharinenkirche3 = Wherigo.ZMedia(cartILuebeck)
zmediaKatharinenkirche3.Id = "3730fb11e54d07e24733a6d9a4be5303"
zmediaKatharinenkirche3.Name = "Katharinenkirche3"
zmediaKatharinenkirche3.AltText = ""
zmediaKatharinenkirche3.Resources = {
  {
    Type = "jpg",
    Filename = "Katharinenkirche3.jpg",
    Directives = {}
  }
}
zmediaKatharinenkircheA = Wherigo.ZMedia(cartILuebeck)
zmediaKatharinenkircheA.Id = "d1c28aeeba2454085d1199405987b51f"
zmediaKatharinenkircheA.Name = "KatharinenkircheA"
zmediaKatharinenkircheA.AltText = ""
zmediaKatharinenkircheA.Resources = {
  {
    Type = "jpg",
    Filename = "katarinenA.jpg",
    Directives = {}
  }
}
zmediaKKonvent1 = Wherigo.ZMedia(cartILuebeck)
zmediaKKonvent1.Id = "57b25784dd462eb48ba22effeb342acc"
zmediaKKonvent1.Name = "KKonvent1"
zmediaKKonvent1.AltText = ""
zmediaKKonvent1.Resources = {
  {
    Type = "jpg",
    Filename = "KKonvent1.jpg",
    Directives = {}
  }
}
zmediaKKonvent2 = Wherigo.ZMedia(cartILuebeck)
zmediaKKonvent2.Id = "bb861b481b6ffba04c7d6be4bb5c70cd"
zmediaKKonvent2.Name = "KKonvent2"
zmediaKKonvent2.AltText = ""
zmediaKKonvent2.Resources = {
  {
    Type = "jpg",
    Filename = "KKonvent2.jpg",
    Directives = {}
  }
}
zmediaKKonventA = Wherigo.ZMedia(cartILuebeck)
zmediaKKonventA.Id = "14a60ced741906199836fcc2a8e3900f"
zmediaKKonventA.Name = "KKonventA"
zmediaKKonventA.AltText = ""
zmediaKKonventA.Resources = {
  {
    Type = "jpg",
    Filename = "KKonventA.jpg",
    Directives = {}
  }
}
zmediaLisa1 = Wherigo.ZMedia(cartILuebeck)
zmediaLisa1.Id = "a37b0f4aa871b98cb6af9fe22875bc4f"
zmediaLisa1.Name = "Lisa1"
zmediaLisa1.AltText = ""
zmediaLisa1.Resources = {
  {
    Type = "jpg",
    Filename = "Lisa1.jpg",
    Directives = {}
  }
}
zmediaLisa2 = Wherigo.ZMedia(cartILuebeck)
zmediaLisa2.Id = "856cead3ee00b072519293ff041476ce"
zmediaLisa2.Name = "Lisa2"
zmediaLisa2.AltText = ""
zmediaLisa2.Resources = {
  {
    Type = "jpg",
    Filename = "Lisa2.jpg",
    Directives = {}
  }
}
zmediaLisaA = Wherigo.ZMedia(cartILuebeck)
zmediaLisaA.Id = "7f700f9cf78711a5fc145bc5116c90dc"
zmediaLisaA.Name = "LisaA"
zmediaLisaA.AltText = ""
zmediaLisaA.Resources = {
  {
    Type = "jpg",
    Filename = "lisaA.jpg",
    Directives = {}
  }
}
zmediaLoewenapotheke1 = Wherigo.ZMedia(cartILuebeck)
zmediaLoewenapotheke1.Id = "15e92cbe24523cd06b200fa1f95e8a59"
zmediaLoewenapotheke1.Name = "Loewenapotheke1"
zmediaLoewenapotheke1.AltText = ""
zmediaLoewenapotheke1.Resources = {
  {
    Type = "jpg",
    Filename = "Loewenapothekefront19ct.jpg",
    Directives = {}
  }
}
zmediaLoewenapotheke2 = Wherigo.ZMedia(cartILuebeck)
zmediaLoewenapotheke2.Id = "8dc50f60b5de4da10dd5600c974b746d"
zmediaLoewenapotheke2.Name = "Loewenapotheke2"
zmediaLoewenapotheke2.AltText = ""
zmediaLoewenapotheke2.Resources = {
  {
    Type = "jpg",
    Filename = "Loewenfliese14Jh.jpg",
    Directives = {}
  }
}
zmediaLoewenapothekeA = Wherigo.ZMedia(cartILuebeck)
zmediaLoewenapothekeA.Id = "78c8d514b52b28c029d04d51ab0b75e4"
zmediaLoewenapothekeA.Name = "LoewenapothekeA"
zmediaLoewenapothekeA.AltText = ""
zmediaLoewenapothekeA.Resources = {
  {
    Type = "jpg",
    Filename = "LoewenapothekeA.jpg",
    Directives = {}
  }
}
zmedialogo = Wherigo.ZMedia(cartILuebeck)
zmedialogo.Id = "243a1b9c7fb7761544b8b38e898dd810"
zmedialogo.Name = "logo"
zmedialogo.AltText = ""
zmedialogo.Resources = {
  {
    Type = "jpg",
    Filename = "logo.jpg",
    Directives = {}
  }
}
zmediaMarien1 = Wherigo.ZMedia(cartILuebeck)
zmediaMarien1.Id = "64265b0ce0bc4da6a872855f224182f5"
zmediaMarien1.Name = "Marien1"
zmediaMarien1.AltText = ""
zmediaMarien1.Resources = {
  {
    Type = "jpg",
    Filename = "marien1s.jpg",
    Directives = {}
  }
}
zmediaMarien2 = Wherigo.ZMedia(cartILuebeck)
zmediaMarien2.Id = "60071bd6367bfbf55cb3095fe03a8e38"
zmediaMarien2.Name = "Marien2"
zmediaMarien2.AltText = ""
zmediaMarien2.Resources = {
  {
    Type = "jpg",
    Filename = "marien2s.jpg",
    Directives = {}
  }
}
zmediaMarien3 = Wherigo.ZMedia(cartILuebeck)
zmediaMarien3.Id = "474867b3e9243bab87d1b4a3db2589f1"
zmediaMarien3.Name = "Marien3"
zmediaMarien3.AltText = ""
zmediaMarien3.Resources = {
  {
    Type = "jpg",
    Filename = "marien3s.jpg",
    Directives = {}
  }
}
zmediaMarien4 = Wherigo.ZMedia(cartILuebeck)
zmediaMarien4.Id = "d125a0b29e3b7cebcbe9f77bdde29925"
zmediaMarien4.Name = "Marien4"
zmediaMarien4.AltText = ""
zmediaMarien4.Resources = {
  {
    Type = "jpg",
    Filename = "marien4s.jpg",
    Directives = {}
  }
}
zmediaMarienA = Wherigo.ZMedia(cartILuebeck)
zmediaMarienA.Id = "cc75e9fc13b53c14983e51174008532f"
zmediaMarienA.Name = "MarienA"
zmediaMarienA.AltText = ""
zmediaMarienA.Resources = {
  {
    Type = "jpg",
    Filename = "marienA.jpg",
    Directives = {}
  }
}
zmediaMarkt1 = Wherigo.ZMedia(cartILuebeck)
zmediaMarkt1.Id = "616c0ff56ff335cc7a71113fd10399c4"
zmediaMarkt1.Name = "Markt1"
zmediaMarkt1.AltText = ""
zmediaMarkt1.Resources = {
  {
    Type = "jpg",
    Filename = "Markt1s.jpg",
    Directives = {}
  }
}
zmediaMarkt2 = Wherigo.ZMedia(cartILuebeck)
zmediaMarkt2.Id = "4f7e259aaf5bc6dd2e12429f46d7f871"
zmediaMarkt2.Name = "Markt2"
zmediaMarkt2.AltText = ""
zmediaMarkt2.Resources = {
  {
    Type = "jpg",
    Filename = "Markt2s.jpg",
    Directives = {}
  }
}
zmediaMarkt3 = Wherigo.ZMedia(cartILuebeck)
zmediaMarkt3.Id = "b0271d40d7b18356302db56961dd140d"
zmediaMarkt3.Name = "Markt3"
zmediaMarkt3.AltText = ""
zmediaMarkt3.Resources = {
  {
    Type = "jpg",
    Filename = "Markt3s.jpg",
    Directives = {}
  }
}
zmediaMarktA = Wherigo.ZMedia(cartILuebeck)
zmediaMarktA.Id = "bd2e2f6be8dc153fe473d724e0637cf8"
zmediaMarktA.Name = "MarktA"
zmediaMarktA.AltText = ""
zmediaMarktA.Resources = {
  {
    Type = "jpg",
    Filename = "marktA.jpg",
    Directives = {}
  }
}
zmediaMarstall1 = Wherigo.ZMedia(cartILuebeck)
zmediaMarstall1.Id = "7e8314391aedb8fb9a41c30435733bbd"
zmediaMarstall1.Name = "Marstall1"
zmediaMarstall1.AltText = ""
zmediaMarstall1.Resources = {
  {
    Type = "jpg",
    Filename = "Marstall1.jpg",
    Directives = {}
  }
}
zmediaMarstall2 = Wherigo.ZMedia(cartILuebeck)
zmediaMarstall2.Id = "cf87b272e3eb93f9483fe0157046d70d"
zmediaMarstall2.Name = "Marstall2"
zmediaMarstall2.AltText = ""
zmediaMarstall2.Resources = {
  {
    Type = "jpg",
    Filename = "Marstall2.jpg",
    Directives = {}
  }
}
zmediaMarstallA = Wherigo.ZMedia(cartILuebeck)
zmediaMarstallA.Id = "3335c0ae2dc1c9c0e7f61378b40ab1d9"
zmediaMarstallA.Name = "MarstallA"
zmediaMarstallA.AltText = ""
zmediaMarstallA.Resources = {
  {
    Type = "jpg",
    Filename = "MarstallA.jpg",
    Directives = {}
  }
}
zmediaMuseumshafen = Wherigo.ZMedia(cartILuebeck)
zmediaMuseumshafen.Id = "4a22dc67aa260579adc922b9b08b7a67"
zmediaMuseumshafen.Name = "Museumshafen"
zmediaMuseumshafen.AltText = ""
zmediaMuseumshafen.Resources = {
  {
    Type = "jpg",
    Filename = "Museumshafen1.jpg",
    Directives = {}
  }
}
zmediaMuseumshafenA = Wherigo.ZMedia(cartILuebeck)
zmediaMuseumshafenA.Id = "144dcd7e44f03b05f6469419c49c30a9"
zmediaMuseumshafenA.Name = "MuseumshafenA"
zmediaMuseumshafenA.AltText = ""
zmediaMuseumshafenA.Resources = {
  {
    Type = "jpg",
    Filename = "museumshafenA.jpg",
    Directives = {}
  }
}
zmediaNiederegger1 = Wherigo.ZMedia(cartILuebeck)
zmediaNiederegger1.Id = "f6d6c2da40c7b0c9cacd8714db048104"
zmediaNiederegger1.Name = "Niederegger1"
zmediaNiederegger1.AltText = ""
zmediaNiederegger1.Resources = {
  {
    Type = "jpg",
    Filename = "NiedereggerS1.jpg",
    Directives = {}
  }
}
zmediaNiederegger2 = Wherigo.ZMedia(cartILuebeck)
zmediaNiederegger2.Id = "cb88474f10ed08bfb4933f7e7eb7e76b"
zmediaNiederegger2.Name = "Niederegger2"
zmediaNiederegger2.AltText = ""
zmediaNiederegger2.Resources = {
  {
    Type = "jpg",
    Filename = "NiedereggerS2.jpg",
    Directives = {}
  }
}
zmediaNiederegger3 = Wherigo.ZMedia(cartILuebeck)
zmediaNiederegger3.Id = "ee2d2152a2dce6d6949af0416089a688"
zmediaNiederegger3.Name = "Niederegger3"
zmediaNiederegger3.AltText = ""
zmediaNiederegger3.Resources = {
  {
    Type = "jpg",
    Filename = "NiedereggerS3.jpg",
    Directives = {}
  }
}
zmediaNiedereggerA = Wherigo.ZMedia(cartILuebeck)
zmediaNiedereggerA.Id = "1487bea8644645978b66a65ac3ea3725"
zmediaNiedereggerA.Name = "NiedereggerA"
zmediaNiedereggerA.AltText = ""
zmediaNiedereggerA.Resources = {
  {
    Type = "jpg",
    Filename = "NiedereggerA.jpg",
    Directives = {}
  }
}
zmediaPetri1 = Wherigo.ZMedia(cartILuebeck)
zmediaPetri1.Id = "83dbdd3a84580b4aad9eebd07a87bfcd"
zmediaPetri1.Name = "Petri1"
zmediaPetri1.AltText = ""
zmediaPetri1.Resources = {
  {
    Type = "jpg",
    Filename = "petri1s.jpg",
    Directives = {}
  }
}
zmediaPetri2 = Wherigo.ZMedia(cartILuebeck)
zmediaPetri2.Id = "2c66687e229b3d3aa97bad097f5483ed"
zmediaPetri2.Name = "Petri2"
zmediaPetri2.AltText = ""
zmediaPetri2.Resources = {
  {
    Type = "jpg",
    Filename = "petri2s.jpg",
    Directives = {}
  }
}
zmediaPetri3 = Wherigo.ZMedia(cartILuebeck)
zmediaPetri3.Id = "7cf6daddf1959c8a4c29c5967375c9b7"
zmediaPetri3.Name = "Petri3"
zmediaPetri3.AltText = ""
zmediaPetri3.Resources = {
  {
    Type = "jpg",
    Filename = "petri3s.jpg",
    Directives = {}
  }
}
zmediaPetriA = Wherigo.ZMedia(cartILuebeck)
zmediaPetriA.Id = "cc92f21b258d2f67dbc7cfc130f5e176"
zmediaPetriA.Name = "PetriA"
zmediaPetriA.AltText = ""
zmediaPetriA.Resources = {
  {
    Type = "jpg",
    Filename = "st-petriA.jpg",
    Directives = {}
  }
}
zmediapunkt = Wherigo.ZMedia(cartILuebeck)
zmediapunkt.Id = "797237ff078061a32a0f6b1624e2e98b"
zmediapunkt.Name = "punkt"
zmediapunkt.AltText = ""
zmediapunkt.Resources = {
  {
    Type = "jpg",
    Filename = "punkt.jpg",
    Directives = {}
  }
}
zmediapuppen1 = Wherigo.ZMedia(cartILuebeck)
zmediapuppen1.Id = "d2ec0ef87405fd713c1fbe60320a86f0"
zmediapuppen1.Name = "puppen1"
zmediapuppen1.AltText = ""
zmediapuppen1.Resources = {
  {
    Type = "jpg",
    Filename = "Puppen1.jpg",
    Directives = {}
  }
}
zmediapuppen2 = Wherigo.ZMedia(cartILuebeck)
zmediapuppen2.Id = "1d4f633a62725927a32e16a26e23f4aa"
zmediapuppen2.Name = "puppen2"
zmediapuppen2.AltText = ""
zmediapuppen2.Resources = {
  {
    Type = "jpg",
    Filename = "Puppen2.jpg",
    Directives = {}
  }
}
zmediapuppen3 = Wherigo.ZMedia(cartILuebeck)
zmediapuppen3.Id = "fd6314ec9689d19953184fa971a2ae8f"
zmediapuppen3.Name = "puppen3"
zmediapuppen3.AltText = ""
zmediapuppen3.Resources = {
  {
    Type = "jpg",
    Filename = "Puppen3.jpg",
    Directives = {}
  }
}
zmediapuppenA = Wherigo.ZMedia(cartILuebeck)
zmediapuppenA.Id = "4239dd6adab4e3b55b5e0e190a4c9cda"
zmediapuppenA.Name = "puppenA"
zmediapuppenA.AltText = ""
zmediapuppenA.Resources = {
  {
    Type = "jpg",
    Filename = "puppembruckeA.jpg",
    Directives = {}
  }
}
zmediaRathaus1 = Wherigo.ZMedia(cartILuebeck)
zmediaRathaus1.Id = "c00ee204efa6bbae25e5211d08cdcb8f"
zmediaRathaus1.Name = "Rathaus1"
zmediaRathaus1.AltText = ""
zmediaRathaus1.Resources = {
  {
    Type = "jpg",
    Filename = "Rathaus1s.jpg",
    Directives = {}
  }
}
zmediaRathaus2 = Wherigo.ZMedia(cartILuebeck)
zmediaRathaus2.Id = "3997a7a2da82170e3090a527ce7c4674"
zmediaRathaus2.Name = "Rathaus2"
zmediaRathaus2.AltText = ""
zmediaRathaus2.Resources = {
  {
    Type = "jpg",
    Filename = "Rathaus2s.jpg",
    Directives = {}
  }
}
zmediaRathaus3 = Wherigo.ZMedia(cartILuebeck)
zmediaRathaus3.Id = "f6399a85a837e106c9454521c9c514d0"
zmediaRathaus3.Name = "Rathaus3"
zmediaRathaus3.AltText = ""
zmediaRathaus3.Resources = {
  {
    Type = "jpg",
    Filename = "Rathaus3s.jpg",
    Directives = {}
  }
}
zmediaRathaus4 = Wherigo.ZMedia(cartILuebeck)
zmediaRathaus4.Id = "35a54dd155645c3349adf4bd39e8a8d6"
zmediaRathaus4.Name = "Rathaus4"
zmediaRathaus4.AltText = ""
zmediaRathaus4.Resources = {
  {
    Type = "jpg",
    Filename = "Rathaus4s.jpg",
    Directives = {}
  }
}
zmediaRathausA = Wherigo.ZMedia(cartILuebeck)
zmediaRathausA.Id = "0b2bf74ae7e824f3adfa69ed285ea3da"
zmediaRathausA.Name = "RathausA"
zmediaRathausA.AltText = ""
zmediaRathausA.Resources = {
  {
    Type = "jpg",
    Filename = "rathausA.jpg",
    Directives = {}
  }
}
zmediasalzspeicher1 = Wherigo.ZMedia(cartILuebeck)
zmediasalzspeicher1.Id = "2b1487a70a75def3aabca76e590cf27c"
zmediasalzspeicher1.Name = "salzspeicher1"
zmediasalzspeicher1.AltText = ""
zmediasalzspeicher1.Resources = {
  {
    Type = "jpg",
    Filename = "salzspeicher1s.jpg",
    Directives = {}
  }
}
zmediasalzspeicher2 = Wherigo.ZMedia(cartILuebeck)
zmediasalzspeicher2.Id = "0fb1549bdf89c2d447301b589fb33257"
zmediasalzspeicher2.Name = "salzspeicher2"
zmediasalzspeicher2.AltText = ""
zmediasalzspeicher2.Resources = {
  {
    Type = "jpg",
    Filename = "salzspeicher2s.jpg",
    Directives = {}
  }
}
zmediasalzspeicher3 = Wherigo.ZMedia(cartILuebeck)
zmediasalzspeicher3.Id = "156c086d6590489ba226196f22f9b72f"
zmediasalzspeicher3.Name = "salzspeicher3"
zmediasalzspeicher3.AltText = ""
zmediasalzspeicher3.Resources = {
  {
    Type = "jpg",
    Filename = "salzspeicher3s.jpg",
    Directives = {}
  }
}
zmediasalzspeicherA = Wherigo.ZMedia(cartILuebeck)
zmediasalzspeicherA.Id = "7b27f53e6d96e45a0687bf084f23395d"
zmediasalzspeicherA.Name = "salzspeicherA"
zmediasalzspeicherA.AltText = ""
zmediasalzspeicherA.Resources = {
  {
    Type = "jpg",
    Filename = "salzspeicherA.jpg",
    Directives = {}
  }
}
zmediaschiffergsell1 = Wherigo.ZMedia(cartILuebeck)
zmediaschiffergsell1.Id = "43b7077ac68806f03c5665a15c84f6e2"
zmediaschiffergsell1.Name = "schiffergsell1"
zmediaschiffergsell1.AltText = ""
zmediaschiffergsell1.Resources = {
  {
    Type = "jpg",
    Filename = "Schiffergesellschaft1.jpg",
    Directives = {}
  }
}
zmediaschiffergsell2 = Wherigo.ZMedia(cartILuebeck)
zmediaschiffergsell2.Id = "63f61911b8dac1a518fb7cf9aa48f19b"
zmediaschiffergsell2.Name = "schiffergsell2"
zmediaschiffergsell2.AltText = ""
zmediaschiffergsell2.Resources = {
  {
    Type = "jpg",
    Filename = "Schiffergesellschaft2.jpg",
    Directives = {}
  }
}
zmediaschiffergsellA = Wherigo.ZMedia(cartILuebeck)
zmediaschiffergsellA.Id = "d443682d326bf2aef5c37118feed6cd5"
zmediaschiffergsellA.Name = "schiffergsellA"
zmediaschiffergsellA.AltText = ""
zmediaschiffergsellA.Resources = {
  {
    Type = "jpg",
    Filename = "schiffergesellschaftA.jpg",
    Directives = {}
  }
}
zmediasilber = Wherigo.ZMedia(cartILuebeck)
zmediasilber.Id = "98def5d850f096f3c60a5906c4ca2146"
zmediasilber.Name = "silber"
zmediasilber.AltText = ""
zmediasilber.Resources = {
  {
    Type = "jpg",
    Filename = "silber.jpg",
    Directives = {}
  }
}
zmediasoundapplaus = Wherigo.ZMedia(cartILuebeck)
zmediasoundapplaus.Id = "452b04282d651aad6397e88406f39c20"
zmediasoundapplaus.Name = "soundapplaus"
zmediasoundapplaus.AltText = ""
zmediasoundapplaus.Resources = {
  {
    Type = "mp3",
    Filename = "applaus.mp3",
    Directives = {}
  }
}
zmediasoundfanfare = Wherigo.ZMedia(cartILuebeck)
zmediasoundfanfare.Id = "c7d910aba5e5547bc0d1d75d13eeb95c"
zmediasoundfanfare.Name = "soundfanfare"
zmediasoundfanfare.AltText = ""
zmediasoundfanfare.Resources = {
  {
    Type = "mp3",
    Filename = "fanfare.mp3",
    Directives = {}
  }
}
zmediasoundjubel = Wherigo.ZMedia(cartILuebeck)
zmediasoundjubel.Id = "356081af82b5580a6cc637e75db7c0a9"
zmediasoundjubel.Name = "soundjubel"
zmediasoundjubel.AltText = ""
zmediasoundjubel.Resources = {
  {
    Type = "mp3",
    Filename = "jubel.mp3",
    Directives = {}
  }
}
zmediasoundpoint = Wherigo.ZMedia(cartILuebeck)
zmediasoundpoint.Id = "09dad18e5cab41676869ca99e7e9df51"
zmediasoundpoint.Name = "soundpoint"
zmediasoundpoint.AltText = ""
zmediasoundpoint.Resources = {
  {
    Type = "mp3",
    Filename = "point.mp3",
    Directives = {}
  }
}
zmediaStadtmauerA = Wherigo.ZMedia(cartILuebeck)
zmediaStadtmauerA.Id = "eef7ff81862d15dd43a6c3b7de300254"
zmediaStadtmauerA.Name = "StadtmauerA"
zmediaStadtmauerA.AltText = ""
zmediaStadtmauerA.Resources = {
  {
    Type = "jpg",
    Filename = "StadtmauerA.jpg",
    Directives = {}
  }
}
zmediaStAnnen1 = Wherigo.ZMedia(cartILuebeck)
zmediaStAnnen1.Id = "dffdeb6d02c588e4a390c8c5e364c8e5"
zmediaStAnnen1.Name = "StAnnen1"
zmediaStAnnen1.AltText = ""
zmediaStAnnen1.Resources = {
  {
    Type = "jpg",
    Filename = "StAnnen2.jpg",
    Directives = {}
  }
}
zmediaStAnnen2 = Wherigo.ZMedia(cartILuebeck)
zmediaStAnnen2.Id = "1d0f574d246be5c964b8a248a9153f5a"
zmediaStAnnen2.Name = "StAnnen2"
zmediaStAnnen2.AltText = ""
zmediaStAnnen2.Resources = {
  {
    Type = "jpg",
    Filename = "StAnnen1.jpg",
    Directives = {}
  }
}
zmediaStAnnenA = Wherigo.ZMedia(cartILuebeck)
zmediaStAnnenA.Id = "5dc7fd6afc3801cd5c404d9b00182596"
zmediaStAnnenA.Name = "StAnnenA"
zmediaStAnnenA.AltText = ""
zmediaStAnnenA.Resources = {
  {
    Type = "jpg",
    Filename = "st-annenA.jpg",
    Directives = {}
  }
}
zmediathavorianer = Wherigo.ZMedia(cartILuebeck)
zmediathavorianer.Id = "028a9f09e167ead55a6f1ee0387d576b"
zmediathavorianer.Name = "thavorianer"
zmediathavorianer.AltText = ""
zmediathavorianer.Resources = {
  {
    Type = "jpg",
    Filename = "thavorianer.jpg",
    Directives = {}
  }
}
zmediaTheaterfigurenmuseum = Wherigo.ZMedia(cartILuebeck)
zmediaTheaterfigurenmuseum.Id = "deae6b54f62e1960ef68109e68bed317"
zmediaTheaterfigurenmuseum.Name = "Theaterfigurenmuseum"
zmediaTheaterfigurenmuseum.AltText = ""
zmediaTheaterfigurenmuseum.Resources = {
  {
    Type = "jpg",
    Filename = "Figuren1.jpg",
    Directives = {}
  }
}
zmediaTheaterfigurenmuseumA = Wherigo.ZMedia(cartILuebeck)
zmediaTheaterfigurenmuseumA.Id = "947ebc53c2e32deac8dad594bd406933"
zmediaTheaterfigurenmuseumA.Name = "TheaterfigurenmuseumA"
zmediaTheaterfigurenmuseumA.AltText = ""
zmediaTheaterfigurenmuseumA.Resources = {
  {
    Type = "jpg",
    Filename = "theaterfigurenmuseumA.jpg",
    Directives = {}
  }
}
zmediawallanlagen1 = Wherigo.ZMedia(cartILuebeck)
zmediawallanlagen1.Id = "b7f5f0f90f924c7c0ceccacb2f70a61a"
zmediawallanlagen1.Name = "wallanlagen1"
zmediawallanlagen1.AltText = ""
zmediawallanlagen1.Resources = {
  {
    Type = "jpg",
    Filename = "Wallanlagen1.jpg",
    Directives = {}
  }
}
zmediawallanlagen2 = Wherigo.ZMedia(cartILuebeck)
zmediawallanlagen2.Id = "85ee514330bace0176736904af5dd3d8"
zmediawallanlagen2.Name = "wallanlagen2"
zmediawallanlagen2.AltText = ""
zmediawallanlagen2.Resources = {
  {
    Type = "jpg",
    Filename = "Wallanlagen2.jpg",
    Directives = {}
  }
}
zmediawallanlagenA = Wherigo.ZMedia(cartILuebeck)
zmediawallanlagenA.Id = "60f953467f76f362cc7e5f15a143423c"
zmediawallanlagenA.Name = "wallanlagenA"
zmediawallanlagenA.AltText = ""
zmediawallanlagenA.Resources = {
  {
    Type = "jpg",
    Filename = "WehrturmA.jpg",
    Directives = {}
  }
}
zmediaWBrandt = Wherigo.ZMedia(cartILuebeck)
zmediaWBrandt.Id = "f8eb1a5ed9ab7df6fb7af1545857e5a0"
zmediaWBrandt.Name = "WBrandt"
zmediaWBrandt.AltText = ""
zmediaWBrandt.Resources = {
  {
    Type = "jpg",
    Filename = "WBrandt.jpg",
    Directives = {}
  }
}
zmediaWBrandtA = Wherigo.ZMedia(cartILuebeck)
zmediaWBrandtA.Id = "fd6d0f6f966b47eda01e579f85709509"
zmediaWBrandtA.Name = "WBrandtA"
zmediaWBrandtA.AltText = ""
zmediaWBrandtA.Resources = {
  {
    Type = "jpg",
    Filename = "WBrandtA.jpg",
    Directives = {}
  }
}
zmediazeugenhaus = Wherigo.ZMedia(cartILuebeck)
zmediazeugenhaus.Id = "ddc8727bef0b0cd19330eecfa3c2e01d"
zmediazeugenhaus.Name = "zeugenhaus"
zmediazeugenhaus.AltText = ""
zmediazeugenhaus.Resources = {
  {
    Type = "jpg",
    Filename = "zeughaus1.jpg",
    Directives = {}
  }
}
zmediaZeugenhausA = Wherigo.ZMedia(cartILuebeck)
zmediaZeugenhausA.Id = "d23f284d1e0fe8dd39af1861a0888c4f"
zmediaZeugenhausA.Name = "ZeugenhausA"
zmediaZeugenhausA.AltText = ""
zmediaZeugenhausA.Resources = {
  {
    Type = "jpg",
    Filename = "zeughausA.jpg",
    Directives = {}
  }
}
cartILuebeck.Id = "319d75f3-ad1b-4012-924c-cbb6e3cd9190"
cartILuebeck.Name = "I love Lübeck"
cartILuebeck.Activity = "Geocache"
cartILuebeck.Version = "2.8"
cartILuebeck.Company = ""
cartILuebeck.Author = "thavorianer"
cartILuebeck.TargetDevice = "SmartPhone"
cartILuebeck.TargetDeviceVersion = "0"
cartILuebeck.BuilderVersion = "WWB 0000.3.2019.09.16.174037"
cartILuebeck.StateId = "1"
cartILuebeck.CountryId = "2"
cartILuebeck.Description = " \nFinde die Sehenswürdigkeiten in Lübeck, die kreuz und quer in der Innenstadt verteilt sind.  \n15 für Bronze, 25 für Silber und 35 für Gold! \n \nDieser Cartridge ist für alle drei Wherigos, also einfach sammeln - und bei jedem Final gibt es auch einen Hint (im Inventar)"
cartILuebeck.StartingLocationDescription = ""
cartILuebeck.Visible = true
cartILuebeck.Complete = false
cartILuebeck.UseLogging = true
cartILuebeck.CreateDate = "6/16/2017 04:54:56 PM"
cartILuebeck.PublishDate = "1/1/1970 01:00:00 AM"
cartILuebeck.UpdateDate = "8/31/2023 07:04:08 PM"
cartILuebeck.LastPlayedDate = "1/1/1970 01:00:00 AM"
cartILuebeck.Media = zmedialogo
cartILuebeck.Icon = zmediaicon
cartILuebeck.StartingLocation = ZonePoint(53.866217, 10.677517, 0)
zoneBuddenbrookhaus = Wherigo.Zone(cartILuebeck)
zoneBuddenbrookhaus.Id = "89e9ba465ae88c0d6a819538e40d7620"
zoneBuddenbrookhaus.Name = "Buddenbrookhaus"
zoneBuddenbrookhaus.DistanceRangeUOM = "Meters"
zoneBuddenbrookhaus.ProximityRangeUOM = "Meters"
zoneBuddenbrookhaus.ShowObjects = "OnEnter"
zoneBuddenbrookhaus.OutOfRangeName = ""
zoneBuddenbrookhaus.InRangeName = ""
zoneBuddenbrookhaus.Description = ""
zoneBuddenbrookhaus.Visible = false
zoneBuddenbrookhaus.AllowSetPositionTo = false
zoneBuddenbrookhaus.Active = true
zoneBuddenbrookhaus.DistanceRange = Distance(-1, "meters")
zoneBuddenbrookhaus.ProximityRange = Distance(15, "meters")
zoneBuddenbrookhaus.Points = {
  ZonePoint(53.86846887945375, 10.685935543624282, 0),
  ZonePoint(53.868489439471254, 10.68572853508772, 0),
  ZonePoint(53.86820922394833, 10.685595765741482, 0),
  ZonePoint(53.86818154681391, 10.685844348518117, 0)
}
zoneBuddenbrookhaus.OriginalPoint = ZonePoint(53.868349331641674, 10.685775712966915, 0)
zoneBuddenbrookhaus.Media = zmediaBuddenbrookhausA
zoneBurgkloster = Wherigo.Zone(cartILuebeck)
zoneBurgkloster.Id = "9737a1e42bf4894f4a399fe551f4b302"
zoneBurgkloster.Name = "Burgkloster"
zoneBurgkloster.DistanceRangeUOM = "Meters"
zoneBurgkloster.ProximityRangeUOM = "Meters"
zoneBurgkloster.ShowObjects = "OnEnter"
zoneBurgkloster.OutOfRangeName = ""
zoneBurgkloster.InRangeName = ""
zoneBurgkloster.Description = ""
zoneBurgkloster.Visible = false
zoneBurgkloster.AllowSetPositionTo = false
zoneBurgkloster.Active = true
zoneBurgkloster.DistanceRange = Distance(-1, "meters")
zoneBurgkloster.ProximityRange = Distance(15, "meters")
zoneBurgkloster.Points = {
  ZonePoint(53.87345740915722, 10.690214157259447, 0),
  ZonePoint(53.87369398131621, 10.690333058257465, 0),
  ZonePoint(53.87382471179311, 10.689620659589764, 0),
  ZonePoint(53.87361333276416, 10.689490300278749, 0),
  ZonePoint(53.87331097371773, 10.689551991087, 0),
  ZonePoint(53.87323875259584, 10.689926431417462, 0),
  ZonePoint(53.873287253354285, 10.690131892580439, 0)
}
zoneBurgkloster.OriginalPoint = ZonePoint(53.87352540721993, 10.689872787237164, 0)
zoneBurgkloster.Media = zmediaburklosterA
zoneBurgtor = Wherigo.Zone(cartILuebeck)
zoneBurgtor.Id = "010d4e69efbd77f1214bb7fc6754e859"
zoneBurgtor.Name = "Burgtor"
zoneBurgtor.DistanceRangeUOM = "Meters"
zoneBurgtor.ProximityRangeUOM = "Meters"
zoneBurgtor.ShowObjects = "OnEnter"
zoneBurgtor.OutOfRangeName = ""
zoneBurgtor.InRangeName = ""
zoneBurgtor.Description = ""
zoneBurgtor.Visible = false
zoneBurgtor.AllowSetPositionTo = false
zoneBurgtor.Active = true
zoneBurgtor.DistanceRange = Distance(-1, "meters")
zoneBurgtor.ProximityRange = Distance(15, "meters")
zoneBurgtor.Points = {
  ZonePoint(53.87386697721034, 10.691486869679238, 0),
  ZonePoint(53.87403238903899, 10.69142740253551, 0),
  ZonePoint(53.87410302880144, 10.69114549541473, 0),
  ZonePoint(53.87378537639291, 10.69099903985034, 0),
  ZonePoint(53.87372422474962, 10.691251442670819, 0),
  ZonePoint(53.8737656096485, 10.69136571172703, 0)
}
zoneBurgtor.OriginalPoint = ZonePoint(53.87392311460411, 10.691209868431088, 0)
zoneBurgtor.Media = zmediaburgtorA
zoneDom = Wherigo.Zone(cartILuebeck)
zoneDom.Id = "a0a704e122fc3ba733e6fff40e129ebd"
zoneDom.Name = "Dom"
zoneDom.DistanceRangeUOM = "Meters"
zoneDom.ProximityRangeUOM = "Meters"
zoneDom.ShowObjects = "OnEnter"
zoneDom.OutOfRangeName = ""
zoneDom.InRangeName = ""
zoneDom.Description = ""
zoneDom.Visible = false
zoneDom.AllowSetPositionTo = false
zoneDom.Active = true
zoneDom.DistanceRange = Distance(-1, "meters")
zoneDom.ProximityRange = Distance(15, "meters")
zoneDom.Points = {
  ZonePoint(53.86084027419366, 10.687130843360592, 0),
  ZonePoint(53.86129832408232, 10.68648803057556, 0),
  ZonePoint(53.861373710243626, 10.685754255294796, 0),
  ZonePoint(53.8613062331381, 10.684840772012194, 0),
  ZonePoint(53.86109020236887, 10.684573468487315, 0),
  ZonePoint(53.86068593321204, 10.684513542512377, 0),
  ZonePoint(53.86054252735731, 10.68466527843475, 0),
  ZonePoint(53.8606353144789, 10.686914501808815, 0)
}
zoneDom.OriginalPoint = ZonePoint(53.86088931085188, 10.685708657741543, 0)
zoneDom.Media = zmediaDomA
zoneDunkelundHellgruenerGang = Wherigo.Zone(cartILuebeck)
zoneDunkelundHellgruenerGang.Id = "8b33e997631d49a9c7607f5d6d8149f0"
zoneDunkelundHellgruenerGang.Name = "Dunkel- und Hellgruener Gang"
zoneDunkelundHellgruenerGang.DistanceRangeUOM = "Meters"
zoneDunkelundHellgruenerGang.ProximityRangeUOM = "Meters"
zoneDunkelundHellgruenerGang.ShowObjects = "OnEnter"
zoneDunkelundHellgruenerGang.OutOfRangeName = ""
zoneDunkelundHellgruenerGang.InRangeName = ""
zoneDunkelundHellgruenerGang.Description = ""
zoneDunkelundHellgruenerGang.Visible = false
zoneDunkelundHellgruenerGang.AllowSetPositionTo = false
zoneDunkelundHellgruenerGang.Active = true
zoneDunkelundHellgruenerGang.DistanceRange = Distance(-1, "meters")
zoneDunkelundHellgruenerGang.ProximityRange = Distance(15, "meters")
zoneDunkelundHellgruenerGang.Points = {
  ZonePoint(53.87329927370052, 10.686555620166018, 0),
  ZonePoint(53.873148412883104, 10.68619172471358, 0),
  ZonePoint(53.87330602745811, 10.685913846731182, 0),
  ZonePoint(53.87325357340782, 10.685770079201689, 0),
  ZonePoint(53.873063650760706, 10.686060642747066, 0),
  ZonePoint(53.872975409280684, 10.685888537668689, 0),
  ZonePoint(53.87283640627789, 10.686019744765304, 0),
  ZonePoint(53.8724633593811, 10.685721799440216, 0),
  ZonePoint(53.872433574179105, 10.685813799515245, 0),
  ZonePoint(53.8727578879499, 10.686125336528903, 0),
  ZonePoint(53.87295885332288, 10.686442241907116, 0),
  ZonePoint(53.8727962369429, 10.68674238106837, 0),
  ZonePoint(53.87283603581933, 10.686822579362456, 0),
  ZonePoint(53.87302000466274, 10.686532365255744, 0),
  ZonePoint(53.87320652456274, 10.686829980355014, 0),
  ZonePoint(53.87349741557088, 10.686529462410135, 0),
  ZonePoint(53.87346246872583, 10.686416587756867, 0)
}
zoneDunkelundHellgruenerGang.OriginalPoint = ZonePoint(53.873063650760685, 10.686343000173565, 0)
zoneDunkelundHellgruenerGang.Media = zmediaGangGruenA
zoneFeuerschiffFehmarnbelt = Wherigo.Zone(cartILuebeck)
zoneFeuerschiffFehmarnbelt.Id = "18767bebfe9b51b30a6479f28c7fbeda"
zoneFeuerschiffFehmarnbelt.Name = "Feuerschiff Fehmarnbelt"
zoneFeuerschiffFehmarnbelt.DistanceRangeUOM = "Meters"
zoneFeuerschiffFehmarnbelt.ProximityRangeUOM = "Meters"
zoneFeuerschiffFehmarnbelt.ShowObjects = "OnEnter"
zoneFeuerschiffFehmarnbelt.OutOfRangeName = ""
zoneFeuerschiffFehmarnbelt.InRangeName = ""
zoneFeuerschiffFehmarnbelt.Description = ""
zoneFeuerschiffFehmarnbelt.Visible = false
zoneFeuerschiffFehmarnbelt.AllowSetPositionTo = false
zoneFeuerschiffFehmarnbelt.Active = true
zoneFeuerschiffFehmarnbelt.DistanceRange = Distance(-1, "meters")
zoneFeuerschiffFehmarnbelt.ProximityRange = Distance(15, "meters")
zoneFeuerschiffFehmarnbelt.Points = {
  ZonePoint(53.87372623806163, 10.686727286202995, 0),
  ZonePoint(53.87394225164925, 10.686502864251793, 0),
  ZonePoint(53.873485873476085, 10.685073585167856, 0),
  ZonePoint(53.87326353270099, 10.685287278282544, 0)
}
zoneFeuerschiffFehmarnbelt.OriginalPoint = ZonePoint(53.87360605594154, 10.685868249177929, 0)
zoneFeuerschiffFehmarnbelt.Media = zmediaFeuerschiffA
zoneFinalBronze = Wherigo.Zone(cartILuebeck)
zoneFinalBronze.Id = "87bdcf72f3d2b46f7d0dd503860550ea"
zoneFinalBronze.Name = "Final-Bronze"
zoneFinalBronze.DistanceRangeUOM = "Meters"
zoneFinalBronze.ProximityRangeUOM = "Meters"
zoneFinalBronze.ShowObjects = "OnEnter"
zoneFinalBronze.OutOfRangeName = ""
zoneFinalBronze.InRangeName = ""
zoneFinalBronze.Description = ""
zoneFinalBronze.Visible = true
zoneFinalBronze.AllowSetPositionTo = false
zoneFinalBronze.Active = false
zoneFinalBronze.DistanceRange = Distance(-1, "meters")
zoneFinalBronze.ProximityRange = Distance(15, "meters")
zoneFinalBronze.Points = {
  ZonePoint(53.87231666666491, 10.6925145035151, 0),
  ZonePoint(53.872378299956516, 10.69247120310322, 0),
  ZonePoint(53.872403829302115, 10.692366666666487, 0),
  ZonePoint(53.872378299956516, 10.692262130228432, 0),
  ZonePoint(53.87231666666491, 10.692218829817163, 0),
  ZonePoint(53.872255033373165, 10.69226213022894, 0),
  ZonePoint(53.87222950402796, 10.692366666666487, 0),
  ZonePoint(53.872255033373165, 10.692471203105155, 0)
}
zoneFinalBronze.OriginalPoint = ZonePoint(53.87231666666667, 10.692366666666667, 0)
zoneFinalBronze.Media = zmediabronze
zoneFinalBronze.Icon = zmediaicon
zoneFinalGold = Wherigo.Zone(cartILuebeck)
zoneFinalGold.Id = "d98e9725f62dfc35111149231b16a65c"
zoneFinalGold.Name = "Final-Gold"
zoneFinalGold.DistanceRangeUOM = "Meters"
zoneFinalGold.ProximityRangeUOM = "Meters"
zoneFinalGold.ShowObjects = "OnEnter"
zoneFinalGold.OutOfRangeName = ""
zoneFinalGold.InRangeName = ""
zoneFinalGold.Description = ""
zoneFinalGold.Visible = true
zoneFinalGold.AllowSetPositionTo = false
zoneFinalGold.Active = false
zoneFinalGold.DistanceRange = Distance(-1, "meters")
zoneFinalGold.ProximityRange = Distance(0, "meters")
zoneFinalGold.Points = {
  ZonePoint(53.867533333332936, 10.695514486610687, 0),
  ZonePoint(53.867594966624246, 10.69547119114999, 0),
  ZonePoint(53.86762049596947, 10.695366666666137, 0),
  ZonePoint(53.867594966624246, 10.695262142181571, 0),
  ZonePoint(53.867533333332936, 10.695218846722604, 0),
  ZonePoint(53.86747170004071, 10.695262142181571, 0),
  ZonePoint(53.86744617069562, 10.695366666666137, 0),
  ZonePoint(53.86747170004071, 10.69547119115121, 0)
}
zoneFinalGold.OriginalPoint = ZonePoint(53.867533333333334, 10.695366666666667, 0)
zoneFinalGold.Media = zmediagold
zoneFinalGold.Icon = zmediaicon
zoneFinalSilber = Wherigo.Zone(cartILuebeck)
zoneFinalSilber.Id = "84522a80531ef9f7a698cf40d6064e5e"
zoneFinalSilber.Name = "Final-Silber"
zoneFinalSilber.DistanceRangeUOM = "Meters"
zoneFinalSilber.ProximityRangeUOM = "Meters"
zoneFinalSilber.ShowObjects = "OnEnter"
zoneFinalSilber.OutOfRangeName = ""
zoneFinalSilber.InRangeName = ""
zoneFinalSilber.Description = ""
zoneFinalSilber.Visible = true
zoneFinalSilber.AllowSetPositionTo = false
zoneFinalSilber.Active = false
zoneFinalSilber.DistanceRange = Distance(-1, "meters")
zoneFinalSilber.ProximityRange = Distance(0, "meters")
zoneFinalSilber.Points = {
  ZonePoint(53.868983333332025, 10.696581158401433, 0),
  ZonePoint(53.869044966623434, 10.696537861440023, 0),
  ZonePoint(53.869070495969126, 10.696433333333289, 0),
  ZonePoint(53.869044966623434, 10.69632880522676, 0),
  ZonePoint(53.868983333332025, 10.696285508266163, 0),
  ZonePoint(53.86892170004012, 10.696328805226658, 0),
  ZonePoint(53.86889617069483, 10.696433333333289, 0),
  ZonePoint(53.86892170004012, 10.696537861440023, 0)
}
zoneFinalSilber.OriginalPoint = ZonePoint(53.86898333333333, 10.696433333333333, 0)
zoneFinalSilber.Media = zmediasilber
zoneFinalSilber.Icon = zmediaicon
zoneFuechtingshof = Wherigo.Zone(cartILuebeck)
zoneFuechtingshof.Id = "0219755f0e98545fa5618eff09207f2a"
zoneFuechtingshof.Name = "Fuechtingshof"
zoneFuechtingshof.DistanceRangeUOM = "Meters"
zoneFuechtingshof.ProximityRangeUOM = "Meters"
zoneFuechtingshof.ShowObjects = "OnEnter"
zoneFuechtingshof.OutOfRangeName = ""
zoneFuechtingshof.InRangeName = ""
zoneFuechtingshof.Description = ""
zoneFuechtingshof.Visible = false
zoneFuechtingshof.AllowSetPositionTo = false
zoneFuechtingshof.Active = true
zoneFuechtingshof.DistanceRange = Distance(-1, "meters")
zoneFuechtingshof.ProximityRange = Distance(15, "meters")
zoneFuechtingshof.Points = {
  ZonePoint(53.86979735652022, 10.690957987464344, 0),
  ZonePoint(53.86981264438461, 10.690811560392376, 0),
  ZonePoint(53.86920637494971, 10.690661110010979, 0),
  ZonePoint(53.869191087469595, 10.690787420511242, 0)
}
zoneFuechtingshof.OriginalPoint = ZonePoint(53.86950542485408, 10.690811560392376, 0)
zoneFuechtingshof.Media = zmediaGangFuechtingA
zoneGuenterGrassHaus = Wherigo.Zone(cartILuebeck)
zoneGuenterGrassHaus.Id = "8b7a78bbbb83613a137552c048f4a299"
zoneGuenterGrassHaus.Name = "Guenter-Grass-Haus"
zoneGuenterGrassHaus.DistanceRangeUOM = "Meters"
zoneGuenterGrassHaus.ProximityRangeUOM = "Meters"
zoneGuenterGrassHaus.ShowObjects = "OnEnter"
zoneGuenterGrassHaus.OutOfRangeName = ""
zoneGuenterGrassHaus.InRangeName = ""
zoneGuenterGrassHaus.Description = ""
zoneGuenterGrassHaus.Visible = false
zoneGuenterGrassHaus.AllowSetPositionTo = false
zoneGuenterGrassHaus.Active = true
zoneGuenterGrassHaus.DistanceRange = Distance(-1, "meters")
zoneGuenterGrassHaus.ProximityRange = Distance(15, "meters")
zoneGuenterGrassHaus.Points = {
  ZonePoint(53.86940435949178, 10.690696472873269, 0),
  ZonePoint(53.86942966014899, 10.690466646943301, 0),
  ZonePoint(53.86924368586509, 10.69040719042546, 0),
  ZonePoint(53.86921427998268, 10.690630761246062, 0)
}
zoneGuenterGrassHaus.OriginalPoint = ZonePoint(53.86933699465774, 10.690554068326946, 0)
zoneGuenterGrassHaus.Media = zmediaggrassA
zoneHaasenhof = Wherigo.Zone(cartILuebeck)
zoneHaasenhof.Id = "3d8c69068bb355f1bfe5976017c4c2e1"
zoneHaasenhof.Name = "Haasenhof"
zoneHaasenhof.DistanceRangeUOM = "Meters"
zoneHaasenhof.ProximityRangeUOM = "Meters"
zoneHaasenhof.ShowObjects = "OnEnter"
zoneHaasenhof.OutOfRangeName = ""
zoneHaasenhof.InRangeName = ""
zoneHaasenhof.Description = ""
zoneHaasenhof.Visible = false
zoneHaasenhof.AllowSetPositionTo = false
zoneHaasenhof.Active = true
zoneHaasenhof.DistanceRange = Distance(-1, "meters")
zoneHaasenhof.ProximityRange = Distance(15, "meters")
zoneHaasenhof.Points = {
  ZonePoint(53.86796040896059, 10.69039203012403, 0),
  ZonePoint(53.86798518410369, 10.690260366439816, 0),
  ZonePoint(53.867572647450864, 10.690067011950305, 0),
  ZonePoint(53.867551035818686, 10.690206722259518, 0)
}
zoneHaasenhof.OriginalPoint = ZonePoint(53.867763365219325, 10.690228179931637, 0)
zoneHaasenhof.Media = zmediaGangHaasenA
zonehalbrunderWehrturm = Wherigo.Zone(cartILuebeck)
zonehalbrunderWehrturm.Id = "30fc7871e238385de396bcaa3e249c65"
zonehalbrunderWehrturm.Name = "halbrunder Wehrturm"
zonehalbrunderWehrturm.DistanceRangeUOM = "Meters"
zonehalbrunderWehrturm.ProximityRangeUOM = "Meters"
zonehalbrunderWehrturm.ShowObjects = "OnEnter"
zonehalbrunderWehrturm.OutOfRangeName = ""
zonehalbrunderWehrturm.InRangeName = ""
zonehalbrunderWehrturm.Description = ""
zonehalbrunderWehrturm.Visible = false
zonehalbrunderWehrturm.AllowSetPositionTo = false
zonehalbrunderWehrturm.Active = true
zonehalbrunderWehrturm.DistanceRange = Distance(-1, "meters")
zonehalbrunderWehrturm.ProximityRange = Distance(15, "meters")
zonehalbrunderWehrturm.Points = {
  ZonePoint(53.86241653671965, 10.690273294698272, 0),
  ZonePoint(53.86252091323967, 10.690199982425497, 0),
  ZonePoint(53.86256414741071, 10.690022990941998, 0),
  ZonePoint(53.86252091323967, 10.68984599945918, 0),
  ZonePoint(53.86241653671965, 10.689772687185268, 0),
  ZonePoint(53.86231216019917, 10.68984599945918, 0),
  ZonePoint(53.86226892602829, 10.690022990941998, 0),
  ZonePoint(53.86231216019917, 10.690199982424815, 0)
}
zonehalbrunderWehrturm.OriginalPoint = ZonePoint(53.862416536719486, 10.690022990941998, 0)
zonehalbrunderWehrturm.Media = zmediawallanlagenA
zoneHansemuseum = Wherigo.Zone(cartILuebeck)
zoneHansemuseum.Id = "26b8be6e1ca5e59916c04716bb4f1f21"
zoneHansemuseum.Name = "Hansemuseum"
zoneHansemuseum.DistanceRangeUOM = "Meters"
zoneHansemuseum.ProximityRangeUOM = "Meters"
zoneHansemuseum.ShowObjects = "OnEnter"
zoneHansemuseum.OutOfRangeName = ""
zoneHansemuseum.InRangeName = ""
zoneHansemuseum.Description = ""
zoneHansemuseum.Visible = false
zoneHansemuseum.AllowSetPositionTo = false
zoneHansemuseum.Active = true
zoneHansemuseum.DistanceRange = Distance(-1, "meters")
zoneHansemuseum.ProximityRange = Distance(15, "meters")
zoneHansemuseum.Points = {
  ZonePoint(53.87407271335183, 10.690055453339482, 0),
  ZonePoint(53.8743070201042, 10.68973331236839, 0),
  ZonePoint(53.87409089862348, 10.688991405687602, 0),
  ZonePoint(53.87395395060532, 10.689190771416975, 0),
  ZonePoint(53.87398778689719, 10.68931058856083, 0),
  ZonePoint(53.87383808058672, 10.689557627677914, 0),
  ZonePoint(53.87386865651538, 10.689740155769869, 0),
  ZonePoint(53.8739308589236, 10.689775162496176, 0)
}
zoneHansemuseum.OriginalPoint = ZonePoint(53.87403301717057, 10.6895911552906, 0)
zoneHansemuseum.Media = zmediaHansemuseumA
zoneHeiligenGeistHospital = Wherigo.Zone(cartILuebeck)
zoneHeiligenGeistHospital.Id = "df548e5b0a56d1aba740d0fda2fd71d2"
zoneHeiligenGeistHospital.Name = "Heiligen-Geist-Hospital"
zoneHeiligenGeistHospital.DistanceRangeUOM = "Meters"
zoneHeiligenGeistHospital.ProximityRangeUOM = "Meters"
zoneHeiligenGeistHospital.ShowObjects = "OnEnter"
zoneHeiligenGeistHospital.OutOfRangeName = ""
zoneHeiligenGeistHospital.InRangeName = ""
zoneHeiligenGeistHospital.Description = ""
zoneHeiligenGeistHospital.Visible = false
zoneHeiligenGeistHospital.AllowSetPositionTo = false
zoneHeiligenGeistHospital.Active = true
zoneHeiligenGeistHospital.DistanceRange = Distance(-1, "meters")
zoneHeiligenGeistHospital.ProximityRange = Distance(15, "meters")
zoneHeiligenGeistHospital.Points = {
  ZonePoint(53.871306715713416, 10.690329472624285, 0),
  ZonePoint(53.87146580201157, 10.690217709393892, 0),
  ZonePoint(53.871531697715064, 10.68994788908958, 0),
  ZonePoint(53.87146580201157, 10.689678068785952, 0),
  ZonePoint(53.871306715713416, 10.689566305554536, 0),
  ZonePoint(53.87114762941527, 10.689678068786407, 0),
  ZonePoint(53.87108173371205, 10.68994788908958, 0),
  ZonePoint(53.87114762941527, 10.690217709392982, 0)
}
zoneHeiligenGeistHospital.OriginalPoint = ZonePoint(53.87130671571318, 10.68994788908958, 0)
zoneHeiligenGeistHospital.Media = zmediahospitalA
zoneHolstentor = Wherigo.Zone(cartILuebeck)
zoneHolstentor.Id = "de5628caad469ad0551dba7d6c593970"
zoneHolstentor.Name = "Holstentor"
zoneHolstentor.DistanceRangeUOM = "Meters"
zoneHolstentor.ProximityRangeUOM = "Meters"
zoneHolstentor.ShowObjects = "OnEnter"
zoneHolstentor.OutOfRangeName = ""
zoneHolstentor.InRangeName = ""
zoneHolstentor.Description = ""
zoneHolstentor.Visible = false
zoneHolstentor.AllowSetPositionTo = false
zoneHolstentor.Active = true
zoneHolstentor.DistanceRange = Distance(-1, "meters")
zoneHolstentor.ProximityRange = Distance(15, "meters")
zoneHolstentor.Points = {
  ZonePoint(53.866267967011666, 10.680053883924188, 0),
  ZonePoint(53.86642705330992, 10.679942134157955, 0),
  ZonePoint(53.86649294901319, 10.679672346353527, 0),
  ZonePoint(53.86642705330992, 10.679402558550919, 0),
  ZonePoint(53.866267967011666, 10.679290808782753, 0),
  ZonePoint(53.86610888071307, 10.679402558551715, 0),
  ZonePoint(53.86604298501019, 10.679672346353527, 0),
  ZonePoint(53.86610888071307, 10.67994213415625, 0)
}
zoneHolstentor.OriginalPoint = ZonePoint(53.8662679670118, 10.679672346353527, 0)
zoneHolstentor.Media = zmediaholstentorA
zoneKaisertor = Wherigo.Zone(cartILuebeck)
zoneKaisertor.Id = "4e4ac7f96ed06e9f5d5d714a7441918a"
zoneKaisertor.Name = "Kaisertor"
zoneKaisertor.DistanceRangeUOM = "Meters"
zoneKaisertor.ProximityRangeUOM = "Meters"
zoneKaisertor.ShowObjects = "OnEnter"
zoneKaisertor.OutOfRangeName = ""
zoneKaisertor.InRangeName = ""
zoneKaisertor.Description = ""
zoneKaisertor.Visible = false
zoneKaisertor.AllowSetPositionTo = false
zoneKaisertor.Active = true
zoneKaisertor.DistanceRange = Distance(-1, "meters")
zoneKaisertor.ProximityRange = Distance(15, "meters")
zoneKaisertor.Points = {
  ZonePoint(53.85804746256519, 10.688325741568747, 0),
  ZonePoint(53.85817491028741, 10.688136229695374, 0),
  ZonePoint(53.85830091921937, 10.68784235501289, 0),
  ZonePoint(53.85823976934184, 10.687586031259116, 0),
  ZonePoint(53.858056954169314, 10.687648647030073, 0),
  ZonePoint(53.85791368730252, 10.687765739262773, 0),
  ZonePoint(53.85780033335972, 10.688038156270977, 0),
  ZonePoint(53.85788837626675, 10.688297162236267, 0)
}
zoneKaisertor.OriginalPoint = ZonePoint(53.85804746256506, 10.687944278955456, 0)
zoneKaisertor.Media = zmediakaisertorA
zoneKatharinenkirche = Wherigo.Zone(cartILuebeck)
zoneKatharinenkirche.Id = "6143fbec212f9494dc9fde9125d6c689"
zoneKatharinenkirche.Name = "Katharinenkirche"
zoneKatharinenkirche.DistanceRangeUOM = "Meters"
zoneKatharinenkirche.ProximityRangeUOM = "Meters"
zoneKatharinenkirche.ShowObjects = "OnEnter"
zoneKatharinenkirche.OutOfRangeName = ""
zoneKatharinenkirche.InRangeName = ""
zoneKatharinenkirche.Description = ""
zoneKatharinenkirche.Visible = false
zoneKatharinenkirche.AllowSetPositionTo = false
zoneKatharinenkirche.Active = true
zoneKatharinenkirche.DistanceRange = Distance(-1, "meters")
zoneKatharinenkirche.ProximityRange = Distance(15, "meters")
zoneKatharinenkirche.Points = {
  ZonePoint(53.869258070021495, 10.690326327985758, 0),
  ZonePoint(53.86944231215169, 10.689050440614437, 0),
  ZonePoint(53.869208892635406, 10.688914541155555, 0),
  ZonePoint(53.868981006344036, 10.69020697219753, 0)
}
zoneKatharinenkirche.OriginalPoint = ZonePoint(53.86920652009578, 10.689744041204449, 0)
zoneKatharinenkirche.Media = zmediaKatharinenkircheA
zoneKranenKonvent = Wherigo.Zone(cartILuebeck)
zoneKranenKonvent.Id = "f24306e9f548d4f2b74de39d82f8b0cf"
zoneKranenKonvent.Name = "Kranen-Konvent"
zoneKranenKonvent.DistanceRangeUOM = "Meters"
zoneKranenKonvent.ProximityRangeUOM = "Meters"
zoneKranenKonvent.ShowObjects = "OnEnter"
zoneKranenKonvent.OutOfRangeName = ""
zoneKranenKonvent.InRangeName = ""
zoneKranenKonvent.Description = ""
zoneKranenKonvent.Visible = false
zoneKranenKonvent.AllowSetPositionTo = false
zoneKranenKonvent.Active = true
zoneKranenKonvent.DistanceRange = Distance(-1, "meters")
zoneKranenKonvent.ProximityRange = Distance(15, "meters")
zoneKranenKonvent.Points = {
  ZonePoint(53.87228798182738, 10.688925343676374, 0),
  ZonePoint(53.87251612531193, 10.688282244467928, 0),
  ZonePoint(53.872407269784354, 10.688184210299255, 0),
  ZonePoint(53.87229841415401, 10.68850460015824, 0),
  ZonePoint(53.87225302753443, 10.688471079402461, 0),
  ZonePoint(53.87213918192594, 10.688814920567665, 0)
}
zoneKranenKonvent.OriginalPoint = ZonePoint(53.87225635538785, 10.688687250852581, 0)
zoneKranenKonvent.Media = zmediaKKonventA
zoneLISAvonLuebeck = Wherigo.Zone(cartILuebeck)
zoneLISAvonLuebeck.Id = "3de1b18fca13d9aaca370e0c578833cd"
zoneLISAvonLuebeck.Name = "LISA von Luebeck"
zoneLISAvonLuebeck.DistanceRangeUOM = "Meters"
zoneLISAvonLuebeck.ProximityRangeUOM = "Meters"
zoneLISAvonLuebeck.ShowObjects = "OnEnter"
zoneLISAvonLuebeck.OutOfRangeName = ""
zoneLISAvonLuebeck.InRangeName = ""
zoneLISAvonLuebeck.Description = ""
zoneLISAvonLuebeck.Visible = false
zoneLISAvonLuebeck.AllowSetPositionTo = false
zoneLISAvonLuebeck.Active = true
zoneLISAvonLuebeck.DistanceRange = Distance(-1, "meters")
zoneLISAvonLuebeck.ProximityRange = Distance(15, "meters")
zoneLISAvonLuebeck.Points = {
  ZonePoint(53.875188953288344, 10.688478783828144, 0),
  ZonePoint(53.87534803958638, 10.688367010221619, 0),
  ZonePoint(53.87541393528997, 10.688097164869552, 0),
  ZonePoint(53.87534803958638, 10.687827319516263, 0),
  ZonePoint(53.875188953288344, 10.687715545910146, 0),
  ZonePoint(53.87502986699004, 10.68782731951718, 0),
  ZonePoint(53.87496397128703, 10.688097164869552, 0),
  ZonePoint(53.87502986699004, 10.688367010220805, 0)
}
zoneLISAvonLuebeck.OriginalPoint = ZonePoint(53.87518895328841, 10.688097164869305, 0)
zoneLISAvonLuebeck.Media = zmediaLisaA
zoneLoewenapotheke = Wherigo.Zone(cartILuebeck)
zoneLoewenapotheke.Id = "94710417afb8430ab9b5d809da6a2e10"
zoneLoewenapotheke.Name = "Loewenapotheke"
zoneLoewenapotheke.DistanceRangeUOM = "Meters"
zoneLoewenapotheke.ProximityRangeUOM = "Meters"
zoneLoewenapotheke.ShowObjects = "OnEnter"
zoneLoewenapotheke.OutOfRangeName = ""
zoneLoewenapotheke.InRangeName = ""
zoneLoewenapotheke.Description = ""
zoneLoewenapotheke.Visible = false
zoneLoewenapotheke.AllowSetPositionTo = false
zoneLoewenapotheke.Active = true
zoneLoewenapotheke.DistanceRange = Distance(-1, "meters")
zoneLoewenapotheke.ProximityRange = Distance(15, "meters")
zoneLoewenapotheke.Points = {
  ZonePoint(53.868113829565665, 10.688266666666667, 0),
  ZonePoint(53.86813913022352, 10.68795, 0),
  ZonePoint(53.867953155938054, 10.68785, 0),
  ZonePoint(53.86792375005698, 10.68815, 0)
}
zoneLoewenapotheke.OriginalPoint = ZonePoint(53.86803333333334, 10.688066666666666, 0)
zoneLoewenapotheke.Media = zmediaLoewenapothekeA
zoneMarienkirche = Wherigo.Zone(cartILuebeck)
zoneMarienkirche.Id = "cdd2135996ed1235217513aa79a6fea6"
zoneMarienkirche.Name = "Marienkirche"
zoneMarienkirche.DistanceRangeUOM = "Meters"
zoneMarienkirche.ProximityRangeUOM = "Meters"
zoneMarienkirche.ShowObjects = "OnEnter"
zoneMarienkirche.OutOfRangeName = ""
zoneMarienkirche.InRangeName = ""
zoneMarienkirche.Description = ""
zoneMarienkirche.Visible = false
zoneMarienkirche.AllowSetPositionTo = false
zoneMarienkirche.Active = true
zoneMarienkirche.DistanceRange = Distance(-1, "meters")
zoneMarienkirche.ProximityRange = Distance(15, "meters")
zoneMarienkirche.Points = {
  ZonePoint(53.86795631593281, 10.6860848451106, 0),
  ZonePoint(53.868140706587205, 10.68583361631056, 0),
  ZonePoint(53.86827302709848, 10.684694782733914, 0),
  ZonePoint(53.86816917452444, 10.684317696517837, 0),
  ZonePoint(53.8676241871029, 10.684157662824191, 0),
  ZonePoint(53.86752836311254, 10.68458591741944, 0),
  ZonePoint(53.86742767245443, 10.685590640544888, 0),
  ZonePoint(53.86757897350621, 10.685908718162977, 0)
}
zoneMarienkirche.OriginalPoint = ZonePoint(53.86782662784645, 10.685113207340237, 0)
zoneMarienkirche.Media = zmediaMarienA
zoneMarkt = Wherigo.Zone(cartILuebeck)
zoneMarkt.Id = "bec328f498d4320d11556fa30b214ed4"
zoneMarkt.Name = "Markt"
zoneMarkt.DistanceRangeUOM = "Meters"
zoneMarkt.ProximityRangeUOM = "Meters"
zoneMarkt.ShowObjects = "OnEnter"
zoneMarkt.OutOfRangeName = ""
zoneMarkt.InRangeName = ""
zoneMarkt.Description = ""
zoneMarkt.Visible = false
zoneMarkt.AllowSetPositionTo = false
zoneMarkt.Active = true
zoneMarkt.DistanceRange = Distance(-1, "meters")
zoneMarkt.ProximityRange = Distance(15, "meters")
zoneMarkt.Points = {
  ZonePoint(53.86647832239685, 10.685187634936256, 0),
  ZonePoint(53.866839854647075, 10.685357516249269, 0),
  ZonePoint(53.86687886301436, 10.684940204858776, 0),
  ZonePoint(53.86699326973943, 10.684970822375817, 0),
  ZonePoint(53.8670271393611, 10.684572075376536, 0),
  ZonePoint(53.866366684282816, 10.684437062781626, 0),
  ZonePoint(53.86620747266289, 10.685114548444744, 0),
  ZonePoint(53.866458418123706, 10.685269003351095, 0)
}
zoneMarkt.OriginalPoint = ZonePoint(53.866592198554876, 10.68484364533424, 0)
zoneMarkt.Media = zmediaMarktA
zoneMarstall = Wherigo.Zone(cartILuebeck)
zoneMarstall.Id = "9e0b42554860ce9ece6228393a207c3d"
zoneMarstall.Name = "Marstall"
zoneMarstall.DistanceRangeUOM = "Meters"
zoneMarstall.ProximityRangeUOM = "Meters"
zoneMarstall.ShowObjects = "OnEnter"
zoneMarstall.OutOfRangeName = ""
zoneMarstall.InRangeName = ""
zoneMarstall.Description = ""
zoneMarstall.Visible = false
zoneMarstall.AllowSetPositionTo = false
zoneMarstall.Active = true
zoneMarstall.DistanceRange = Distance(-1, "meters")
zoneMarstall.ProximityRange = Distance(15, "meters")
zoneMarstall.Points = {
  ZonePoint(53.87409389813687, 10.691138183273097, 0),
  ZonePoint(53.87434576245031, 10.690570161325468, 0),
  ZonePoint(53.8743225624846, 10.690392860197107, 0),
  ZonePoint(53.8741253624735, 10.69022522173259, 0),
  ZonePoint(53.87385310322569, 10.690784738293814, 0),
  ZonePoint(53.87377430649641, 10.690990202831244, 0)
}
zoneMarstall.OriginalPoint = ZonePoint(53.874063853090526, 10.690741822957989, 0)
zoneMarstall.Media = zmediaMarstallA
zoneMuseumBehnhausDraegerhaus = Wherigo.Zone(cartILuebeck)
zoneMuseumBehnhausDraegerhaus.Id = "b0e48af39e5d1c6331454e31ce798276"
zoneMuseumBehnhausDraegerhaus.Name = "Museum Behnhaus Draegerhaus"
zoneMuseumBehnhausDraegerhaus.DistanceRangeUOM = "Meters"
zoneMuseumBehnhausDraegerhaus.ProximityRangeUOM = "Meters"
zoneMuseumBehnhausDraegerhaus.ShowObjects = "OnEnter"
zoneMuseumBehnhausDraegerhaus.OutOfRangeName = ""
zoneMuseumBehnhausDraegerhaus.InRangeName = ""
zoneMuseumBehnhausDraegerhaus.Description = ""
zoneMuseumBehnhausDraegerhaus.Visible = false
zoneMuseumBehnhausDraegerhaus.AllowSetPositionTo = false
zoneMuseumBehnhausDraegerhaus.Active = true
zoneMuseumBehnhausDraegerhaus.DistanceRange = Distance(-1, "meters")
zoneMuseumBehnhausDraegerhaus.ProximityRange = Distance(15, "meters")
zoneMuseumBehnhausDraegerhaus.Points = {
  ZonePoint(53.870315298555646, 10.690015198742685, 0),
  ZonePoint(53.87033506394478, 10.689502389042445, 0),
  ZonePoint(53.87017518487751, 10.689461706207567, 0),
  ZonePoint(53.87015447701385, 10.690011176998496, 0)
}
zoneMuseumBehnhausDraegerhaus.OriginalPoint = ZonePoint(53.87024714224972, 10.689766839981075, 0)
zoneMuseumBehnhausDraegerhaus.Media = zmediaBehnhausA
zoneMuseumshafen = Wherigo.Zone(cartILuebeck)
zoneMuseumshafen.Id = "cc4af07ac9beeeac623be7fd36338141"
zoneMuseumshafen.Name = "Museumshafen"
zoneMuseumshafen.DistanceRangeUOM = "Meters"
zoneMuseumshafen.ProximityRangeUOM = "Meters"
zoneMuseumshafen.ShowObjects = "OnEnter"
zoneMuseumshafen.OutOfRangeName = ""
zoneMuseumshafen.InRangeName = ""
zoneMuseumshafen.Description = ""
zoneMuseumshafen.Visible = false
zoneMuseumshafen.AllowSetPositionTo = false
zoneMuseumshafen.Active = true
zoneMuseumshafen.DistanceRange = Distance(-1, "meters")
zoneMuseumshafen.ProximityRange = Distance(15, "meters")
zoneMuseumshafen.Points = {
  ZonePoint(53.872123516297336, 10.68278040223754, 0),
  ZonePoint(53.87241966016759, 10.682512813129733, 0),
  ZonePoint(53.872314756821176, 10.682306144733388, 0),
  ZonePoint(53.87214027393323, 10.68241062179095, 0),
  ZonePoint(53.87073489863604, 10.680127706003987, 0),
  ZonePoint(53.869889325785365, 10.679625806583545, 0),
  ZonePoint(53.86988509543991, 10.679885655240241, 0),
  ZonePoint(53.87062073570924, 10.680356307721922, 0)
}
zoneMuseumshafen.OriginalPoint = ZonePoint(53.871891051087374, 10.68223385596275, 0)
zoneMuseumshafen.Media = zmediaMuseumshafenA
zoneNiederegger = Wherigo.Zone(cartILuebeck)
zoneNiederegger.Id = "86660d24e0b5728915a41df5320a6f60"
zoneNiederegger.Name = "Niederegger"
zoneNiederegger.DistanceRangeUOM = "Meters"
zoneNiederegger.ProximityRangeUOM = "Meters"
zoneNiederegger.ShowObjects = "OnEnter"
zoneNiederegger.OutOfRangeName = ""
zoneNiederegger.InRangeName = ""
zoneNiederegger.Description = ""
zoneNiederegger.Visible = false
zoneNiederegger.AllowSetPositionTo = false
zoneNiederegger.Active = true
zoneNiederegger.DistanceRange = Distance(-1, "meters")
zoneNiederegger.ProximityRange = Distance(15, "meters")
zoneNiederegger.Points = {
  ZonePoint(53.866562147932086, 10.686016653795946, 0),
  ZonePoint(53.86666652445241, 10.685943334259264, 0),
  ZonePoint(53.86670975862345, 10.685766325235363, 0),
  ZonePoint(53.86666652445241, 10.68558931621294, 0),
  ZonePoint(53.866562147932086, 10.68551599667478, 0),
  ZonePoint(53.86645777141179, 10.685589316213964, 0),
  ZonePoint(53.86641453724098, 10.685766325235363, 0),
  ZonePoint(53.86645777141179, 10.685943334258013, 0)
}
zoneNiederegger.OriginalPoint = ZonePoint(53.86656214793215, 10.685766325235363, 0)
zoneNiederegger.Media = zmediaNiedereggerA
zonePetrikirche = Wherigo.Zone(cartILuebeck)
zonePetrikirche.Id = "513946d78e6ea82ab6437c712cee47d4"
zonePetrikirche.Name = "Petrikirche"
zonePetrikirche.DistanceRangeUOM = "Meters"
zonePetrikirche.ProximityRangeUOM = "Meters"
zonePetrikirche.ShowObjects = "OnEnter"
zonePetrikirche.OutOfRangeName = ""
zonePetrikirche.InRangeName = ""
zonePetrikirche.Description = ""
zonePetrikirche.Visible = false
zonePetrikirche.AllowSetPositionTo = false
zonePetrikirche.Active = true
zonePetrikirche.DistanceRange = Distance(-1, "meters")
zonePetrikirche.ProximityRange = Distance(15, "meters")
zonePetrikirche.Points = {
  ZonePoint(53.86581482945009, 10.683965881871018, 0),
  ZonePoint(53.8660039668899, 10.683816582320787, 0),
  ZonePoint(53.86606511769264, 10.68327857637405, 0),
  ZonePoint(53.86608146685442, 10.682888091924951, 0),
  ZonePoint(53.865949268680374, 10.68252421565353, 0),
  ZonePoint(53.86564308988088, 10.68266010415914, 0),
  ZonePoint(53.86561515368965, 10.68327857637405, 0),
  ZonePoint(53.865570334053864, 10.683776349184654, 0)
}
zonePetrikirche.OriginalPoint = ZonePoint(53.86584013569096, 10.68327857637405, 0)
zonePetrikirche.Media = zmediaPetriA
zonePuppenbruecke = Wherigo.Zone(cartILuebeck)
zonePuppenbruecke.Id = "70d5cebd28c089a50b119c18daee4b4b"
zonePuppenbruecke.Name = "Puppenbruecke"
zonePuppenbruecke.DistanceRangeUOM = "Meters"
zonePuppenbruecke.ProximityRangeUOM = "Meters"
zonePuppenbruecke.ShowObjects = "OnEnter"
zonePuppenbruecke.OutOfRangeName = ""
zonePuppenbruecke.InRangeName = ""
zonePuppenbruecke.Description = ""
zonePuppenbruecke.Visible = false
zonePuppenbruecke.AllowSetPositionTo = false
zonePuppenbruecke.Active = true
zonePuppenbruecke.DistanceRange = Distance(-1, "meters")
zonePuppenbruecke.ProximityRange = Distance(15, "meters")
zonePuppenbruecke.Points = {
  ZonePoint(53.86623000803287, 10.676227176326847, 0),
  ZonePoint(53.86640396889955, 10.67610497806595, 0),
  ZonePoint(53.86647602585142, 10.675809965372082, 0),
  ZonePoint(53.86640396889955, 10.675514952677077, 0),
  ZonePoint(53.86623000803287, 10.675392754415952, 0),
  ZonePoint(53.86605604716544, 10.675514952677304, 0),
  ZonePoint(53.865983990214296, 10.675809965372082, 0),
  ZonePoint(53.86605604716544, 10.676104978066178, 0)
}
zonePuppenbruecke.OriginalPoint = ZonePoint(53.86623000803277, 10.675809965372082, 0)
zonePuppenbruecke.Media = zmediapuppenA
zoneRathaus = Wherigo.Zone(cartILuebeck)
zoneRathaus.Id = "41d62824d516d6377e5c08c447e9b4f9"
zoneRathaus.Name = "Rathaus"
zoneRathaus.DistanceRangeUOM = "Meters"
zoneRathaus.ProximityRangeUOM = "Meters"
zoneRathaus.ShowObjects = "OnEnter"
zoneRathaus.OutOfRangeName = ""
zoneRathaus.InRangeName = ""
zoneRathaus.Description = ""
zoneRathaus.Visible = false
zoneRathaus.AllowSetPositionTo = false
zoneRathaus.Active = true
zoneRathaus.DistanceRange = Distance(-1, "meters")
zoneRathaus.ProximityRange = Distance(15, "meters")
zoneRathaus.Points = {
  ZonePoint(53.866707656009694, 10.68566775549948, 0),
  ZonePoint(53.86736178212911, 10.685958334711131, 0),
  ZonePoint(53.86744507513188, 10.685146734952923, 0),
  ZonePoint(53.866885723221166, 10.684978865360222, 0),
  ZonePoint(53.86685316358115, 10.685384779557808, 0),
  ZonePoint(53.8664900482884, 10.685225628590388, 0),
  ZonePoint(53.86643047825518, 10.685532973051068, 0),
  ZonePoint(53.866506919984566, 10.685560581071172, 0),
  ZonePoint(53.86660234280383, 10.68552113464034, 0)
}
zoneRathaus.OriginalPoint = ZonePoint(53.86715682992614, 10.685377404928204, 0)
zoneRathaus.Media = zmediaRathausA
zoneSalzspeicher = Wherigo.Zone(cartILuebeck)
zoneSalzspeicher.Id = "10e6e0663c1d5d988d37f0d6a1e55af1"
zoneSalzspeicher.Name = "Salzspeicher"
zoneSalzspeicher.DistanceRangeUOM = "Meters"
zoneSalzspeicher.ProximityRangeUOM = "Meters"
zoneSalzspeicher.ShowObjects = "OnEnter"
zoneSalzspeicher.OutOfRangeName = ""
zoneSalzspeicher.InRangeName = ""
zoneSalzspeicher.Description = ""
zoneSalzspeicher.Visible = false
zoneSalzspeicher.AllowSetPositionTo = false
zoneSalzspeicher.Active = true
zoneSalzspeicher.DistanceRange = Distance(-1, "meters")
zoneSalzspeicher.ProximityRange = Distance(15, "meters")
zoneSalzspeicher.Points = {
  ZonePoint(53.86609161562994, 10.68047901074317, 0),
  ZonePoint(53.86620404328242, 10.680426270543194, 0),
  ZonePoint(53.86617504125754, 10.680071995496746, 0),
  ZonePoint(53.86604429876865, 10.679842443170742, 0),
  ZonePoint(53.865568752157614, 10.679881335201458, 0),
  ZonePoint(53.86559010442512, 10.680494666873074, 0)
}
zoneSalzspeicher.OriginalPoint = ZonePoint(53.8659049828638, 10.680188671588894, 0)
zoneSalzspeicher.Media = zmediasalzspeicherA
zoneSchiffergesellschaft = Wherigo.Zone(cartILuebeck)
zoneSchiffergesellschaft.Id = "766060df302b94cfc00f73598498ae5b"
zoneSchiffergesellschaft.Name = "Schiffergesellschaft"
zoneSchiffergesellschaft.DistanceRangeUOM = "Meters"
zoneSchiffergesellschaft.ProximityRangeUOM = "Meters"
zoneSchiffergesellschaft.ShowObjects = "OnEnter"
zoneSchiffergesellschaft.OutOfRangeName = ""
zoneSchiffergesellschaft.InRangeName = ""
zoneSchiffergesellschaft.Description = ""
zoneSchiffergesellschaft.Visible = false
zoneSchiffergesellschaft.AllowSetPositionTo = false
zoneSchiffergesellschaft.Active = true
zoneSchiffergesellschaft.DistanceRange = Distance(-1, "meters")
zoneSchiffergesellschaft.ProximityRange = Distance(15, "meters")
zoneSchiffergesellschaft.Points = {
  ZonePoint(53.871155049863816, 10.68838039518414, 0),
  ZonePoint(53.87124914535663, 10.687994983664112, 0),
  ZonePoint(53.87114540924661, 10.687922112892352, 0),
  ZonePoint(53.87105353430466, 10.688318704377025, 0)
}
zoneSchiffergesellschaft.OriginalPoint = ZonePoint(53.871146199965885, 10.688174948930737, 0)
zoneSchiffergesellschaft.Media = zmediaschiffergsellA
zoneSchwansHof = Wherigo.Zone(cartILuebeck)
zoneSchwansHof.Id = "b3d2284b91972f0efcbc3f94c8f7b5c8"
zoneSchwansHof.Name = "Schwans Hof"
zoneSchwansHof.DistanceRangeUOM = "Meters"
zoneSchwansHof.ProximityRangeUOM = "Meters"
zoneSchwansHof.ShowObjects = "OnEnter"
zoneSchwansHof.OutOfRangeName = ""
zoneSchwansHof.InRangeName = ""
zoneSchwansHof.Description = ""
zoneSchwansHof.Visible = false
zoneSchwansHof.AllowSetPositionTo = false
zoneSchwansHof.Active = true
zoneSchwansHof.DistanceRange = Distance(-1, "meters")
zoneSchwansHof.ProximityRange = Distance(15, "meters")
zoneSchwansHof.Points = {
  ZonePoint(53.86259144018141, 10.682779885675018, 0),
  ZonePoint(53.86260039227224, 10.682587907552715, 0),
  ZonePoint(53.86194584004066, 10.68248712453942, 0),
  ZonePoint(53.86194796092371, 10.682676420450207, 0)
}
zoneSchwansHof.OriginalPoint = ZonePoint(53.86229474032725, 10.682636187314984, 0)
zoneSchwansHof.Media = zmediaGangSchwanA
zoneStAegidienKirche = Wherigo.Zone(cartILuebeck)
zoneStAegidienKirche.Id = "a411ed473c0de1b13410c7e9fa434db9"
zoneStAegidienKirche.Name = "St. Aegidien Kirche"
zoneStAegidienKirche.DistanceRangeUOM = "Meters"
zoneStAegidienKirche.ProximityRangeUOM = "Meters"
zoneStAegidienKirche.ShowObjects = "OnEnter"
zoneStAegidienKirche.OutOfRangeName = ""
zoneStAegidienKirche.InRangeName = ""
zoneStAegidienKirche.Description = ""
zoneStAegidienKirche.Visible = false
zoneStAegidienKirche.AllowSetPositionTo = false
zoneStAegidienKirche.Active = true
zoneStAegidienKirche.DistanceRange = Distance(-1, "meters")
zoneStAegidienKirche.ProximityRange = Distance(15, "meters")
zoneStAegidienKirche.Points = {
  ZonePoint(53.86399036729802, 10.690340134452185, 0),
  ZonePoint(53.86411623769489, 10.690306174908756, 0),
  ZonePoint(53.864218512539686, 10.689816460847851, 0),
  ZonePoint(53.86419374115657, 10.689509137000414, 0),
  ZonePoint(53.8640836880558, 10.689118443658117, 0),
  ZonePoint(53.8637806661861, 10.689214094008548, 0),
  ZonePoint(53.86370369840945, 10.689457044839855, 0),
  ZonePoint(53.863764849008604, 10.689989674245908, 0)
}
zoneStAegidienKirche.OriginalPoint = ZonePoint(53.86396031480616, 10.689776227712628, 0)
zoneStAegidienKirche.Media = zmediaAegidienA
zoneStAnnenMuseumsquartier = Wherigo.Zone(cartILuebeck)
zoneStAnnenMuseumsquartier.Id = "09f42b9ca26a6b6754bae82a78224966"
zoneStAnnenMuseumsquartier.Name = "St. Annen Museumsquartier"
zoneStAnnenMuseumsquartier.DistanceRangeUOM = "Meters"
zoneStAnnenMuseumsquartier.ProximityRangeUOM = "Meters"
zoneStAnnenMuseumsquartier.ShowObjects = "OnEnter"
zoneStAnnenMuseumsquartier.OutOfRangeName = ""
zoneStAnnenMuseumsquartier.InRangeName = ""
zoneStAnnenMuseumsquartier.Description = ""
zoneStAnnenMuseumsquartier.Visible = false
zoneStAnnenMuseumsquartier.AllowSetPositionTo = false
zoneStAnnenMuseumsquartier.Active = true
zoneStAnnenMuseumsquartier.DistanceRange = Distance(-1, "meters")
zoneStAnnenMuseumsquartier.ProximityRange = Distance(15, "meters")
zoneStAnnenMuseumsquartier.Points = {
  ZonePoint(53.86281355886141, 10.68959983398895, 0),
  ZonePoint(53.863222022752566, 10.688993022680279, 0),
  ZonePoint(53.86286666777686, 10.68829142172649, 0),
  ZonePoint(53.86243935277828, 10.688884596511912, 0)
}
zoneStAnnenMuseumsquartier.OriginalPoint = ZonePoint(53.862778760258394, 10.688853547811505, 0)
zoneStAnnenMuseumsquartier.Media = zmediaStAnnenA
zoneStJakobiKirche = Wherigo.Zone(cartILuebeck)
zoneStJakobiKirche.Id = "e4a6eeb901fabc3b276df6b8af8406fe"
zoneStJakobiKirche.Name = "St. Jakobi Kirche"
zoneStJakobiKirche.DistanceRangeUOM = "Meters"
zoneStJakobiKirche.ProximityRangeUOM = "Meters"
zoneStJakobiKirche.ShowObjects = "OnEnter"
zoneStJakobiKirche.OutOfRangeName = ""
zoneStJakobiKirche.InRangeName = ""
zoneStJakobiKirche.Description = ""
zoneStJakobiKirche.Visible = false
zoneStJakobiKirche.AllowSetPositionTo = false
zoneStJakobiKirche.Active = true
zoneStJakobiKirche.DistanceRange = Distance(-1, "meters")
zoneStJakobiKirche.ProximityRange = Distance(15, "meters")
zoneStJakobiKirche.Points = {
  ZonePoint(53.87100466093866, 10.689583814954403, 0),
  ZonePoint(53.87114476963602, 10.689037534907584, 0),
  ZonePoint(53.87116796642181, 10.68872480177879, 0),
  ZonePoint(53.87110681508226, 10.68843352632257, 0),
  ZonePoint(53.87078642105313, 10.688276166581545, 0),
  ZonePoint(53.87070640711619, 10.688463030622302, 0),
  ZonePoint(53.87063366009547, 10.689536425784354, 0)
}
zoneStJakobiKirche.OriginalPoint = ZonePoint(53.87091609996307, 10.688968882799145, 0)
zoneStJakobiKirche.Media = zmediaJakobiA
zoneStadtmauer = Wherigo.Zone(cartILuebeck)
zoneStadtmauer.Id = "135058b7045f1cdc8d03082e5c6fa881"
zoneStadtmauer.Name = "Stadtmauer"
zoneStadtmauer.DistanceRangeUOM = "Meters"
zoneStadtmauer.ProximityRangeUOM = "Meters"
zoneStadtmauer.ShowObjects = "OnEnter"
zoneStadtmauer.OutOfRangeName = ""
zoneStadtmauer.InRangeName = ""
zoneStadtmauer.Description = ""
zoneStadtmauer.Visible = false
zoneStadtmauer.AllowSetPositionTo = false
zoneStadtmauer.Active = true
zoneStadtmauer.DistanceRange = Distance(-1, "meters")
zoneStadtmauer.ProximityRange = Distance(15, "meters")
zoneStadtmauer.Points = {
  ZonePoint(53.86766451717283, 10.695219319524085, 0),
  ZonePoint(53.867768893692904, 10.695145998053249, 0),
  ZonePoint(53.86781212786406, 10.69496898436546, 0),
  ZonePoint(53.867768893692904, 10.694791970678466, 0),
  ZonePoint(53.86766451717283, 10.694718649206607, 0),
  ZonePoint(53.86756014065258, 10.694791970678239, 0),
  ZonePoint(53.86751690648167, 10.69496898436546, 0),
  ZonePoint(53.86756014065258, 10.695145998051771, 0)
}
zoneStadtmauer.OriginalPoint = ZonePoint(53.867664517172955, 10.69496898436546, 0)
zoneStadtmauer.Media = zmediaStadtmauerA
zoneTheaterfigurenmuseum = Wherigo.Zone(cartILuebeck)
zoneTheaterfigurenmuseum.Id = "823bec752888b9e7b372c62c5f279e31"
zoneTheaterfigurenmuseum.Name = "Theaterfigurenmuseum"
zoneTheaterfigurenmuseum.DistanceRangeUOM = "Meters"
zoneTheaterfigurenmuseum.ProximityRangeUOM = "Meters"
zoneTheaterfigurenmuseum.ShowObjects = "OnEnter"
zoneTheaterfigurenmuseum.OutOfRangeName = ""
zoneTheaterfigurenmuseum.InRangeName = ""
zoneTheaterfigurenmuseum.Description = ""
zoneTheaterfigurenmuseum.Visible = false
zoneTheaterfigurenmuseum.AllowSetPositionTo = false
zoneTheaterfigurenmuseum.Active = true
zoneTheaterfigurenmuseum.DistanceRange = Distance(-1, "meters")
zoneTheaterfigurenmuseum.ProximityRange = Distance(15, "meters")
zoneTheaterfigurenmuseum.Points = {
  ZonePoint(53.865898254991755, 10.68233846211433, 0),
  ZonePoint(53.86585278880595, 10.68206958171288, 0),
  ZonePoint(53.86567525656349, 10.6821708240509, 0),
  ZonePoint(53.8657300805825, 10.682436585434289, 0)
}
zoneTheaterfigurenmuseum.OriginalPoint = ZonePoint(53.86577528841765, 10.682264701366421, 0)
zoneTheaterfigurenmuseum.Media = zmediaTheaterfigurenmuseumA
zoneWillyBrandtHaus = Wherigo.Zone(cartILuebeck)
zoneWillyBrandtHaus.Id = "c4e297e9f875ddec694429a70361ba47"
zoneWillyBrandtHaus.Name = "Willy-Brandt-Haus"
zoneWillyBrandtHaus.DistanceRangeUOM = "Meters"
zoneWillyBrandtHaus.ProximityRangeUOM = "Meters"
zoneWillyBrandtHaus.ShowObjects = "OnEnter"
zoneWillyBrandtHaus.OutOfRangeName = ""
zoneWillyBrandtHaus.InRangeName = ""
zoneWillyBrandtHaus.Description = ""
zoneWillyBrandtHaus.Visible = false
zoneWillyBrandtHaus.AllowSetPositionTo = false
zoneWillyBrandtHaus.Active = true
zoneWillyBrandtHaus.DistanceRange = Distance(-1, "meters")
zoneWillyBrandtHaus.ProximityRange = Distance(15, "meters")
zoneWillyBrandtHaus.Points = {
  ZonePoint(53.86981396809762, 10.68978184231014, 0),
  ZonePoint(53.86983768718616, 10.68924624037561, 0),
  ZonePoint(53.869690460089835, 10.689166666593792, 0),
  ZonePoint(53.86963575029449, 10.689738929093323, 0)
}
zoneWillyBrandtHaus.OriginalPoint = ZonePoint(53.86970390275948, 10.689494595766064, 0)
zoneWillyBrandtHaus.Media = zmediaWBrandtA
zoneZeughaus = Wherigo.Zone(cartILuebeck)
zoneZeughaus.Id = "e5998cffec2ab98cc3471b246a91477a"
zoneZeughaus.Name = "Zeughaus"
zoneZeughaus.DistanceRangeUOM = "Meters"
zoneZeughaus.ProximityRangeUOM = "Meters"
zoneZeughaus.ShowObjects = "OnEnter"
zoneZeughaus.OutOfRangeName = ""
zoneZeughaus.InRangeName = ""
zoneZeughaus.Description = ""
zoneZeughaus.Visible = false
zoneZeughaus.AllowSetPositionTo = false
zoneZeughaus.Active = true
zoneZeughaus.DistanceRange = Distance(-1, "meters")
zoneZeughaus.ProximityRange = Distance(15, "meters")
zoneZeughaus.Points = {
  ZonePoint(53.86179026786434, 10.6850128208157, 0),
  ZonePoint(53.86181004004241, 10.684657035875716, 0),
  ZonePoint(53.861547229890135, 10.684610097435552, 0),
  ZonePoint(53.861521921382156, 10.684977952223562, 0)
}
zoneZeughaus.OriginalPoint = ZonePoint(53.861652535304636, 10.684803412199017, 0)
zoneZeughaus.Media = zmediaZeugenhausA
zitemBronzecache = Wherigo.ZItem({Cartridge = cartILuebeck, Container = zoneFinalBronze})
zitemBronzecache.Id = "022110a4061964f8040ab4c598fb235d"
zitemBronzecache.Name = "Bronzecache"
zitemBronzecache.Description = "Hier gibt's Hilfe."
zitemBronzecache.Visible = true
zitemBronzecache.Locked = false
zitemBronzecache.Opened = false
zitemBronzecache.ObjectLocation = ZonePoint(53.87231666666667, 10.692366666666667, 0)
zitemBronzecache.Media = zmediabronze
zitemBronzecache.Commands = {
  Fund = Wherigo.ZCommand({
    Text = "Fund",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hint = Wherigo.ZCommand({
    Text = "Hint",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemBronzecache.Commands.Fund.Id = "39decf88eaac688a8afbaff1044eba27"
zitemBronzecache.Commands.Fund.Custom = true
zitemBronzecache.Commands.Fund.WorksWithAll = true
zitemBronzecache.Commands.Hint.Id = "262eb62019d5cd1c9d3421c49eebb544"
zitemBronzecache.Commands.Hint.Custom = true
zitemBronzecache.Commands.Hint.WorksWithAll = true
zitemGoldcache = Wherigo.ZItem({Cartridge = cartILuebeck, Container = zoneFinalGold})
zitemGoldcache.Id = "54171b0aa4768167c8f29066ff24a58f"
zitemGoldcache.Name = "Goldcache"
zitemGoldcache.Description = "Hier gibt's Hilfe."
zitemGoldcache.Visible = true
zitemGoldcache.Locked = false
zitemGoldcache.Opened = false
zitemGoldcache.ObjectLocation = ZonePoint(53.867533333333334, 10.695366666666667, 0)
zitemGoldcache.Media = zmediagold
zitemGoldcache.Commands = {
  Fund = Wherigo.ZCommand({
    Text = "Fund",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hint = Wherigo.ZCommand({
    Text = "Hint",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemGoldcache.Commands.Fund.Id = "4b0ed705fbd5f1e1ab953794ac9a2236"
zitemGoldcache.Commands.Fund.Custom = true
zitemGoldcache.Commands.Fund.WorksWithAll = true
zitemGoldcache.Commands.Hint.Id = "ab0fe11fb0d371e9f90765fac69d835d"
zitemGoldcache.Commands.Hint.Custom = true
zitemGoldcache.Commands.Hint.WorksWithAll = true
zitemInfo = Wherigo.ZItem(cartILuebeck)
zitemInfo.Id = "634066237c8076c49c60427a74261162"
zitemInfo.Name = "Info"
zitemInfo.Description = WWB_multiplatform_string("Hier könnt Ihr nachträglich die Infos zu den gefundenen Zonen abrufen.")
zitemInfo.Visible = true
zitemInfo.Locked = false
zitemInfo.Opened = false
zitemInfo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemInfo.Commands = {
  Buddenbrookhaus = Wherigo.ZCommand({
    Text = "Buddenbrookhaus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Burgkloster = Wherigo.ZCommand({
    Text = "Burgkloster",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Burgtor = Wherigo.ZCommand({
    Text = "Burgtor",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Dom = Wherigo.ZCommand({
    Text = "Dom",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  DunkelundHellgrnerGang = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Dunkel- und Hellgrüner Gang", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Fchtingshof = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Füchtingshof", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  FeuerschiffFehmarnbelt = Wherigo.ZCommand({
    Text = "Feuerschiff Fehmarnbelt",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  GuenterGrassHaus = Wherigo.ZCommand({
    Text = "Guenter-Grass-Haus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Haasenhof = Wherigo.ZCommand({
    Text = "Haasenhof",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  halbrunderWehrturm = Wherigo.ZCommand({
    Text = "halbrunder Wehrturm",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hansemuseum = Wherigo.ZCommand({
    Text = "Hansemuseum",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  HeiligenGeistHospital = Wherigo.ZCommand({
    Text = "Heiligen-Geist-Hospital",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Holstentor = Wherigo.ZCommand({
    Text = "Holstentor",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Kaisertor = Wherigo.ZCommand({
    Text = "Kaisertor",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Katharinenkirche = Wherigo.ZCommand({
    Text = "Katharinenkirche",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  KranenKonvent = Wherigo.ZCommand({
    Text = "Kranen-Konvent",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  LISAvonLbeck = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("LISA von Lübeck", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Lwenapotheke = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Löwenapotheke", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Marienkirche = Wherigo.ZCommand({
    Text = "Marienkirche",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Marktplatz = Wherigo.ZCommand({
    Text = "Marktplatz",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Marstall = Wherigo.ZCommand({
    Text = "Marstall",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  MuseumBehnhausDrgerhaus = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Museum Behnhaus Drägerhaus", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Museumshafen = Wherigo.ZCommand({
    Text = "Museumshafen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Niederegger = Wherigo.ZCommand({
    Text = "Niederegger",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Petrikirche = Wherigo.ZCommand({
    Text = "Petrikirche",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Puppenbrcke = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Puppenbrücke", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Rathaus = Wherigo.ZCommand({
    Text = "Rathaus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Salzspeicher = Wherigo.ZCommand({
    Text = "Salzspeicher",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schiffergesellschaft = Wherigo.ZCommand({
    Text = "Schiffergesellschaft",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  SchwansHof = Wherigo.ZCommand({
    Text = "Schwans Hof",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Stadtmauer = Wherigo.ZCommand({
    Text = "Stadtmauer",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  StAegidienKirche = Wherigo.ZCommand({
    Text = "St. Aegidien Kirche",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  StAnnenMuseumsquartier = Wherigo.ZCommand({
    Text = "St. Annen Museumsquartier",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  StJakobiKirche = Wherigo.ZCommand({
    Text = "St. Jakobi Kirche",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Theaterfigurenmuseum = Wherigo.ZCommand({
    Text = "Theaterfigurenmuseum",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  WillyBrandtHaus = Wherigo.ZCommand({
    Text = "Willy-Brandt-Haus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Zeughaus = Wherigo.ZCommand({
    Text = "Zeughaus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemInfo.Commands.Buddenbrookhaus.Id = "c2b5379c10fcdcef628c1e10ec166ec1"
zitemInfo.Commands.Buddenbrookhaus.Custom = true
zitemInfo.Commands.Buddenbrookhaus.WorksWithAll = true
zitemInfo.Commands.Burgkloster.Id = "460724cf1fed6f30e43071f45f655c82"
zitemInfo.Commands.Burgkloster.Custom = true
zitemInfo.Commands.Burgkloster.WorksWithAll = true
zitemInfo.Commands.Burgtor.Id = "446c10bdaf1d44fcefb0be7891370e71"
zitemInfo.Commands.Burgtor.Custom = true
zitemInfo.Commands.Burgtor.WorksWithAll = true
zitemInfo.Commands.Dom.Id = "48921c0ea9b508ed27918c24f3f7a3be"
zitemInfo.Commands.Dom.Custom = true
zitemInfo.Commands.Dom.WorksWithAll = true
zitemInfo.Commands.DunkelundHellgrnerGang.Id = "cac4b8c40512b6b7dba8939e5f4eafa4"
zitemInfo.Commands.DunkelundHellgrnerGang.Custom = true
zitemInfo.Commands.DunkelundHellgrnerGang.WorksWithAll = true
zitemInfo.Commands.Fchtingshof.Id = "d88d85faf6e906dda4a08a8688192bda"
zitemInfo.Commands.Fchtingshof.Custom = true
zitemInfo.Commands.Fchtingshof.WorksWithAll = true
zitemInfo.Commands.FeuerschiffFehmarnbelt.Id = "a6e36d64e266901abce14a07611c09c2"
zitemInfo.Commands.FeuerschiffFehmarnbelt.Custom = true
zitemInfo.Commands.FeuerschiffFehmarnbelt.WorksWithAll = true
zitemInfo.Commands.GuenterGrassHaus.Id = "b7add7047745243fb6d0780d98903743"
zitemInfo.Commands.GuenterGrassHaus.Custom = true
zitemInfo.Commands.GuenterGrassHaus.WorksWithAll = true
zitemInfo.Commands.Haasenhof.Id = "131f10ac4052a63e73de4db73697a4e5"
zitemInfo.Commands.Haasenhof.Custom = true
zitemInfo.Commands.Haasenhof.WorksWithAll = true
zitemInfo.Commands.halbrunderWehrturm.Id = "26fa408283131c5fc4e230467acba1e9"
zitemInfo.Commands.halbrunderWehrturm.Custom = true
zitemInfo.Commands.halbrunderWehrturm.WorksWithAll = true
zitemInfo.Commands.Hansemuseum.Id = "5048df961afbac25c0d89cac8a3e426b"
zitemInfo.Commands.Hansemuseum.Custom = true
zitemInfo.Commands.Hansemuseum.WorksWithAll = true
zitemInfo.Commands.HeiligenGeistHospital.Id = "812ae95c69122d5fa2b91a2533cb40a5"
zitemInfo.Commands.HeiligenGeistHospital.Custom = true
zitemInfo.Commands.HeiligenGeistHospital.WorksWithAll = true
zitemInfo.Commands.Holstentor.Id = "e079c2dd34f367fe979e8f77261f70b1"
zitemInfo.Commands.Holstentor.Custom = true
zitemInfo.Commands.Holstentor.WorksWithAll = true
zitemInfo.Commands.Kaisertor.Id = "cb528d8f13a8a81011bb865b39b5cd3a"
zitemInfo.Commands.Kaisertor.Custom = true
zitemInfo.Commands.Kaisertor.WorksWithAll = true
zitemInfo.Commands.Katharinenkirche.Id = "6fc91bcb07d3af3ae849dfbbcecfc5a2"
zitemInfo.Commands.Katharinenkirche.Custom = true
zitemInfo.Commands.Katharinenkirche.WorksWithAll = true
zitemInfo.Commands.KranenKonvent.Id = "095fab612c1ecdce345d4f5495e95aef"
zitemInfo.Commands.KranenKonvent.Custom = true
zitemInfo.Commands.KranenKonvent.WorksWithAll = true
zitemInfo.Commands.LISAvonLbeck.Id = "bf3170c7209628f283647a161fe5fccc"
zitemInfo.Commands.LISAvonLbeck.Custom = true
zitemInfo.Commands.LISAvonLbeck.WorksWithAll = true
zitemInfo.Commands.Lwenapotheke.Id = "34b212e7c1e464b7d5166275c91f3368"
zitemInfo.Commands.Lwenapotheke.Custom = true
zitemInfo.Commands.Lwenapotheke.WorksWithAll = true
zitemInfo.Commands.Marienkirche.Id = "2c9d5b7674f6f194bc04fa207c6eb3ef"
zitemInfo.Commands.Marienkirche.Custom = true
zitemInfo.Commands.Marienkirche.WorksWithAll = true
zitemInfo.Commands.Marktplatz.Id = "905c4058de669194a6f2f3532e30557e"
zitemInfo.Commands.Marktplatz.Custom = true
zitemInfo.Commands.Marktplatz.WorksWithAll = true
zitemInfo.Commands.Marstall.Id = "81dfafd7e7ea0f3f9a36d605295de2d0"
zitemInfo.Commands.Marstall.Custom = true
zitemInfo.Commands.Marstall.WorksWithAll = true
zitemInfo.Commands.MuseumBehnhausDrgerhaus.Id = "ceb62e839e1c6a78802e50cd540a9e58"
zitemInfo.Commands.MuseumBehnhausDrgerhaus.Custom = true
zitemInfo.Commands.MuseumBehnhausDrgerhaus.WorksWithAll = true
zitemInfo.Commands.Museumshafen.Id = "06c39aca1a22ba00ffa0888eaf7eaf92"
zitemInfo.Commands.Museumshafen.Custom = true
zitemInfo.Commands.Museumshafen.WorksWithAll = true
zitemInfo.Commands.Niederegger.Id = "abf1935542b6fd820b8aec96cecd3894"
zitemInfo.Commands.Niederegger.Custom = true
zitemInfo.Commands.Niederegger.WorksWithAll = true
zitemInfo.Commands.Petrikirche.Id = "95a9eb9f0a98e7581ae1651646740a95"
zitemInfo.Commands.Petrikirche.Custom = true
zitemInfo.Commands.Petrikirche.WorksWithAll = true
zitemInfo.Commands.Puppenbrcke.Id = "c5da0b4d4cd1d1f66efe4ec754bbfc22"
zitemInfo.Commands.Puppenbrcke.Custom = true
zitemInfo.Commands.Puppenbrcke.WorksWithAll = true
zitemInfo.Commands.Rathaus.Id = "34ecd9467fa03a8f43fa8670c70b544c"
zitemInfo.Commands.Rathaus.Custom = true
zitemInfo.Commands.Rathaus.WorksWithAll = true
zitemInfo.Commands.Salzspeicher.Id = "033d46aa086eb7a8bd99e864df087033"
zitemInfo.Commands.Salzspeicher.Custom = true
zitemInfo.Commands.Salzspeicher.WorksWithAll = true
zitemInfo.Commands.Schiffergesellschaft.Id = "b076cd17ef008abfd21c54929b0fa470"
zitemInfo.Commands.Schiffergesellschaft.Custom = true
zitemInfo.Commands.Schiffergesellschaft.WorksWithAll = true
zitemInfo.Commands.SchwansHof.Id = "85c838521480d69a26723dad0f9a1065"
zitemInfo.Commands.SchwansHof.Custom = true
zitemInfo.Commands.SchwansHof.WorksWithAll = true
zitemInfo.Commands.Stadtmauer.Id = "69af7aa0300a766a345daeffc08425d4"
zitemInfo.Commands.Stadtmauer.Custom = true
zitemInfo.Commands.Stadtmauer.WorksWithAll = true
zitemInfo.Commands.StAegidienKirche.Id = "4dcd8c8ea1c9baad3647e8a552233e2e"
zitemInfo.Commands.StAegidienKirche.Custom = true
zitemInfo.Commands.StAegidienKirche.WorksWithAll = true
zitemInfo.Commands.StAnnenMuseumsquartier.Id = "7ce1e6ba152510093104348c22997086"
zitemInfo.Commands.StAnnenMuseumsquartier.Custom = true
zitemInfo.Commands.StAnnenMuseumsquartier.WorksWithAll = true
zitemInfo.Commands.StJakobiKirche.Id = "81829ac31573ffdbb06558a4675ae52e"
zitemInfo.Commands.StJakobiKirche.Custom = true
zitemInfo.Commands.StJakobiKirche.WorksWithAll = true
zitemInfo.Commands.Theaterfigurenmuseum.Id = "c074244063b8134b03b83ba28ecfad95"
zitemInfo.Commands.Theaterfigurenmuseum.Custom = true
zitemInfo.Commands.Theaterfigurenmuseum.WorksWithAll = true
zitemInfo.Commands.WillyBrandtHaus.Id = "6e2ac4a66d0bec128c32f649f5ed4bed"
zitemInfo.Commands.WillyBrandtHaus.Custom = true
zitemInfo.Commands.WillyBrandtHaus.WorksWithAll = true
zitemInfo.Commands.Zeughaus.Id = "fc4005461c1e858b123cdbba447ab1f6"
zitemInfo.Commands.Zeughaus.Custom = true
zitemInfo.Commands.Zeughaus.WorksWithAll = true
zitemSilbercache = Wherigo.ZItem({Cartridge = cartILuebeck, Container = zoneFinalSilber})
zitemSilbercache.Id = "75444d9b2ac417751bc1836e116d8884"
zitemSilbercache.Name = "Silbercache"
zitemSilbercache.Description = "Hier gibt's Hilfe."
zitemSilbercache.Visible = true
zitemSilbercache.Locked = false
zitemSilbercache.Opened = false
zitemSilbercache.ObjectLocation = ZonePoint(53.86898333333333, 10.696433333333333, 0)
zitemSilbercache.Media = zmediasilber
zitemSilbercache.Commands = {
  Fund = Wherigo.ZCommand({
    Text = "Fund",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hint = Wherigo.ZCommand({
    Text = "Hint",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verfügbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemSilbercache.Commands.Fund.Id = "1c757a63292a1c5ea20e75a605f9e172"
zitemSilbercache.Commands.Fund.Custom = true
zitemSilbercache.Commands.Fund.WorksWithAll = true
zitemSilbercache.Commands.Hint.Id = "3736e496ff24d1ed399967641cf4952d"
zitemSilbercache.Commands.Hint.Custom = true
zitemSilbercache.Commands.Hint.WorksWithAll = true
zitemUnlockCode = Wherigo.ZItem(cartILuebeck)
zitemUnlockCode.Id = "285cb39aaed24653ec1fe8d9aa8b066a"
zitemUnlockCode.Name = "Unlock-Code"
zitemUnlockCode.Description = ""
zitemUnlockCode.Visible = true
zitemUnlockCode.Locked = false
zitemUnlockCode.Opened = false
zitemUnlockCode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemUnlockCode.Media = zmedialogo
ztaskFindedasBronzeFinal = Wherigo.ZTask(cartILuebeck)
ztaskFindedasBronzeFinal.Id = "7d883b0f4e4a09f5a36bd24d823faff0"
ztaskFindedasBronzeFinal.Name = "Finde das Bronze-Final"
ztaskFindedasBronzeFinal.CorrectState = "None"
ztaskFindedasBronzeFinal.Description = "Finde das Bronze-Final!"
ztaskFindedasBronzeFinal.Visible = true
ztaskFindedasBronzeFinal.Active = false
ztaskFindedasBronzeFinal.Complete = false
ztaskFindedasBronzeFinal.Media = zmediabronze
ztaskFindedasGoldFinal = Wherigo.ZTask(cartILuebeck)
ztaskFindedasGoldFinal.Id = "becf49aba7b3bd782d10aeb41f295cb5"
ztaskFindedasGoldFinal.Name = "Finde das Gold-Final"
ztaskFindedasGoldFinal.CorrectState = "None"
ztaskFindedasGoldFinal.Description = "Finde das Gold-Final!"
ztaskFindedasGoldFinal.Visible = true
ztaskFindedasGoldFinal.Active = false
ztaskFindedasGoldFinal.Complete = false
ztaskFindedasGoldFinal.Media = zmediagold
ztaskFindedasSilberFinal = Wherigo.ZTask(cartILuebeck)
ztaskFindedasSilberFinal.Id = "260671f8e23b677a7c6bb4a4db5135e9"
ztaskFindedasSilberFinal.Name = "Finde das Silber-Final"
ztaskFindedasSilberFinal.CorrectState = "None"
ztaskFindedasSilberFinal.Description = "Finde das Silber-Final!"
ztaskFindedasSilberFinal.Visible = true
ztaskFindedasSilberFinal.Active = false
ztaskFindedasSilberFinal.Complete = false
ztaskFindedasSilberFinal.Media = zmediasilber
ztaskFindedieSehenswrdigkeiten = Wherigo.ZTask(cartILuebeck)
ztaskFindedieSehenswrdigkeiten.Id = "80f609f2069fcd05be4e51ed39d16133"
ztaskFindedieSehenswrdigkeiten.Name = WWB_multiplatform_string("Finde die Sehenswürdigkeiten")
ztaskFindedieSehenswrdigkeiten.CorrectState = "None"
ztaskFindedieSehenswrdigkeiten.Description = WWB_multiplatform_string("Finde die Sehenswürdigkeiten, die kreuz und quer in der Innenstadt (Stadtgraben bis Kanal) verteilt sind. \nDu hast bereits ... gefunden!")
ztaskFindedieSehenswrdigkeiten.Visible = true
ztaskFindedieSehenswrdigkeiten.Active = true
ztaskFindedieSehenswrdigkeiten.Complete = false
WWB_device = nil
var_Anzahl = 0
var_Bronze = 0
var_Final = ""
var_Gold = 0
var_Silber = 0
cartILuebeck.ZVariables = {
  WWB_device = nil,
  var_Anzahl = 0,
  var_Bronze = 0,
  var_Final = "",
  var_Gold = 0,
  var_Silber = 0
}
buildervar = {}
buildervar.var_Anzahl = {}
buildervar.var_Anzahl.Id = "267b20afe75745002981d1d54753e9cc"
buildervar.var_Anzahl.Name = "Anzahl"
buildervar.var_Anzahl.Type = "Number"
buildervar.var_Anzahl.Data = "0"
buildervar.var_Bronze = {}
buildervar.var_Bronze.Id = "5046477a65cb4436ffe0a97fed127221"
buildervar.var_Bronze.Name = "Bronze"
buildervar.var_Bronze.Type = "Number"
buildervar.var_Bronze.Data = "0"
buildervar.var_Final = {}
buildervar.var_Final.Id = "dc0ed01b5e82aeaeaf245a2b4080c929"
buildervar.var_Final.Name = "Final"
buildervar.var_Final.Type = "String"
buildervar.var_Final.Data = ""
buildervar.var_Gold = {}
buildervar.var_Gold.Id = "c850d1feea2f02f1f26ac05dadbae39a"
buildervar.var_Gold.Name = "Gold"
buildervar.var_Gold.Type = "Number"
buildervar.var_Gold.Data = "0"
buildervar.var_Silber = {}
buildervar.var_Silber.Id = "3830970a4f5dfce9292f8d1570e7be50"
buildervar.var_Silber.Name = "Silber"
buildervar.var_Silber.Type = "Number"
buildervar.var_Silber.Data = "0"
zinputFinal = Wherigo.ZInput(cartILuebeck)
zinputFinal.Id = "bc3d7e27b2632afb762386925af7ef65"
zinputFinal.Name = "Final"
zinputFinal.InputType = "Text"
zinputFinal.Text = WWB_multiplatform_string("Welches 'Tier' ist über dem Gold-Final?")
zinputFinal.Visible = false
zinputFinal.InputVariableId = "dc0ed01b5e82aeaeaf245a2b4080c929"
zinputFinal.Media = zmedialogo
function cartILuebeck:OnStart()
  WWB_CompletionCode15 = Player.CompletionCode:sub(1, 15)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Finde die Sehenswürdigkeiten in Lübeck, die kreuz und quer in der Innenstadt verteilt sind.  \n15 für Bronze, 25 für Silber und 35 für Gold! \n \nDieser Cartridge ist für alle drei Wherigos, also einfach sammeln - und bei jedem Final gibt es auch einen Hint (im Inventar)", {PocketPC = 1}),
    Media = zmedialogo
  })
  Wherigo.PlayAudio(zmediasoundfanfare)
  ztaskFindedieSehenswrdigkeiten.Description = WWB_multiplatform_string("Du hast bereits " .. var_Anzahl .. " gefunden! Finde die Sehenswürdigkeiten, die kreuz und quer in der Innenstadt (Stadtgraben bis Kanal) verteilt sind. 15 für Bronze, 25 für Silber und 35 für Gold! ")
  entfG = Wherigo.Distance(300, "m")
  entfS = Wherigo.Distance(111, "m")
  entfB = Wherigo.Distance(237, "m")
  zitemInfo:MoveTo(Player)
  zonePuppenbruecke.Name = WWB_multiplatform_string("Puppenbrücke")
  zoneGuenterGrassHaus.Name = WWB_multiplatform_string("Günter-Grass-Haus")
  zoneLISAvonLuebeck.Name = WWB_multiplatform_string("LISA von Lübeck")
  zoneMuseumBehnhausDraegerhaus.Name = WWB_multiplatform_string("Museum Behnhaus Drägerhaus")
  zoneDunkelundHellgruenerGang.Name = WWB_multiplatform_string("Dunkel- und Hellgrüner Gang")
  zoneFuechtingshof.Name = WWB_multiplatform_string("Füchtingshof")
  zoneLoewenapotheke.Name = WWB_multiplatform_string("Löwen-Apotheke")
  WWB_noemul(cartILuebeck, WWB_multiplatform_string("Der Author dieser Cartridge möchte nicht, dass diese im Emulator gespielt wird"))
end
function cartILuebeck:OnRestore()
  Wherigo.PlayAudio(zmediasoundfanfare)
  ztaskFindedieSehenswrdigkeiten.Description = WWB_multiplatform_string("Du hast bereits " .. var_Anzahl .. " gefunden! Finde die Sehenswürdigkeiten, die kreuz und quer in der Innenstadt verteilt sind. 15 für Bronze, 25 für Silber und 35 für Gold! ")
end
function zoneBuddenbrookhaus:OnProximity()
  if zoneBuddenbrookhaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!"
    })
  end
end
function zoneBuddenbrookhaus:OnEnter()
  if zoneBuddenbrookhaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Buddenbrookhaus (Heinrich-und-Thomas-Mann-Zentrum) ist seit 1993 eine Gedenkstätte in Trägerschaft der Kulturstiftung Hansestadt Lübeck. \nIm Haus befindet sich ein Museum mit zwei festen Ausstellungen: Die Buddenbrooks - Ein Jahrhundertroman und Die Manns - eine Schriftstellerfamilie. \nSeine herausragende Bedeutung erhält das Haus dadurch, dass es in die Weltliteratur eingegangen ist, indem es den Schauplatz für den Roman Buddenbrooks abgegeben hat. Die sich über vier Generationen hinziehende Geschichte der Romanfamilie Buddenbrook, die in vielen, aber lange nicht in allen Details der Geschichte der Familie Mann gleicht, spielte sich zu großen Teilen hinter der heute noch stehenden spätbarocken Fassade ab.", {PocketPC = 1}),
      Media = zmediaBuddenbrookhaus,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB3
    })
  end
end
function zoneBuddenbrookhaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneBurgkloster:OnProximity()
  if zoneBurgkloster.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneBurgkloster:OnEnter()
  if zoneBurgkloster.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Burgkloster, ursprünglich Maria-Magdalenen-Kloster, ist ein ehemaliges Lübecker Dominikanerkloster. \nAn der Stelle des heutigen Burgklosters, dem schmalen Zugang zur Altstadt-Halbinsel, befand sich schon die slawische Burg Bucu (wahrscheinlich im 8. Jahrhundert errichtet). \nDer Traveabwärts gelegene Ort Liubice wurde 1127 auf den Stadthügel Bucu verlegt. 1143 gründete Adolf II. an dieser Stelle die heutige Stadt Lübeck.", {PocketPC = 1}),
      Media = zmediaburkloster1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB4
    })
  end
end
function zoneBurgkloster:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneBurgtor:OnProximity()
  if zoneBurgtor.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneBurgtor:OnEnter()
  if zoneBurgtor.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das im spätgotischen Stil erbaute Burgtor in Lübeck ist das nördliche von ehemals vier Stadttoren der Lübecker Stadtbefestigung und neben dem Holstentor das einzige, welches noch heute erhalten ist. Es hat seinen Namen nach der alten, hoch über der Trave gelegenen Lübecker Burg, die 1227 zum Burgkloster umgebaut wurde.", {PocketPC = 1}),
      Media = zmediaburgtor2,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB8
    })
  end
end
function zoneBurgtor:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneDom:OnProximity()
  if zoneDom.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneDom:OnEnter()
  if zoneDom.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Im Jahre 1173 legte Heinrich der Löwe als Stifter den Grundstein des Lübecker Doms als Kathedrale für das Bistum Lübeck. \nDer Lübecker Dom, 1247 geweiht, ist der erste große Backsteinkirchbau an der Ostsee und mit 130 Metern Länge eine der längsten Backsteinkirchen. \nHinsichtlich der steinernen Sarkophage in seinen Grabkapellen nimmt der Dom in Lübeck eine herausragende Stellung ein. \nDer Dom ist Ort mehrerer Legenden, darunter der Domgründungslegende, die in einem zweiteiligen Wandbild im südlichen Seitenschiff dargestellt ist, sowie der Legende von der Rose des Domherrn Rabundus, die in Ludwig Bechsteins Deutschem Sagenbuch Aufnahme fand.", {PocketPC = 1}),
      Media = zmediaDom1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB11
    })
  end
end
function zoneDom:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneDunkelundHellgruenerGang:OnProximity()
  if zoneDunkelundHellgruenerGang.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneDunkelundHellgruenerGang:OnEnter()
  if zoneDunkelundHellgruenerGang.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
      Media = zmediaGang1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB14
    })
  end
end
function zoneDunkelundHellgruenerGang:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneFeuerschiffFehmarnbelt:OnProximity()
  if zoneFeuerschiffFehmarnbelt.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneFeuerschiffFehmarnbelt:OnEnter()
  if zoneFeuerschiffFehmarnbelt.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Fehmarnbelt ist ein deutsches Feuerschiff, das nicht mehr als solches auf Position liegt, sondern als Museumsschiff heute noch in Fahrt ist und somit leider hier nicht immer vor Anker liegt. \nDas Schiff wurde von 1906 bis 1908 auf der Thyen-Werft in Brake an der Weser als Dreimastschoner mit Notbesegelung gebaut und 1908 als Feuerschiff Außeneider in Dienst gestellt. \n1931 wurde ein Motor eingebaut. 1954 und 1956 kam es zu verschiedenen Umbauten. Das Leuchtfeuer wurde verstärkt, ein Funkfeuer nachgerüstet. \nAm 31. März 1984 wurde es als letztes deutsches Feuerschiff auf der Ostsee außer Dienst gestellt; die Position wurde durch eine unbemannte Großtonne übernommen. Seit 1986 ist es Museumsschiff. Es wird in fahrtüchtigem Zustand gehalten und macht seit 1989 im Sommer Ausfahrten, um alle Anlagen unter Seebedingungen zu testen.", {PocketPC = 1}),
      Media = zmediaFeuerschiff,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB16
    })
  end
end
function zoneFeuerschiffFehmarnbelt:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneFinalBronze:OnEnter()
  if var_Bronze == 0 then
    var_Bronze = var_Bronze + 1
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hier bist du richtig, suche das Final! \nDies ist die einzige Allee in der Innenstadt und sehr idyllisch (finde ich) - Leider gab es hier kein schöneres Versteck :( \nWenn du einen Hint brauchst, gucke bei deinen Gegenständen.", {PocketPC = 1}),
      Media = zmediabronze
    })
    zitemBronzecache:MoveTo(Player)
    zitemBronzecache.Commands.Hint.Enabled = true
    zitemBronzecache.Commands.Fund.Enabled = true
  end
end
function zoneFinalBronze:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneFinalGold:OnEnter()
  if var_Gold == 0 then
    var_Gold = var_Gold + 1
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hier bist du richtig, suche das Final! \nDies ist das ehemalige Restaurant Hieronymus mit einem tollen Figuren-Schild, dass immer noch hängt. \nWenn du einen Hint brauchst, gucke bei deinen Gegenständen.", {PocketPC = 1}),
      Media = zmediagold
    })
    zitemGoldcache:MoveTo(Player)
    zitemGoldcache.Commands.Hint.Enabled = true
    zitemGoldcache.Commands.Fund.Enabled = true
  end
end
function zoneFinalGold:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneFinalSilber:OnEnter()
  if var_Silber == 0 then
    var_Silber = var_Silber + 1
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hier bist du richtig, suche das Final! \nDies ist die sogenannte Glitzerbrücke, da die Oberfläche des Gehweges in der Sonne eben glitzert. ;) \nWenn du einen Hint brauchst, gucke bei deinen Gegenständen.", {PocketPC = 1}),
      Media = zmediasilber
    })
    zitemSilbercache:MoveTo(Player)
    zitemSilbercache.Commands.Hint.Enabled = true
    zitemSilbercache.Commands.Fund.Enabled = true
  end
end
function zoneFinalSilber:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneFuechtingshof:OnProximity()
  if zoneFuechtingshof.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneFuechtingshof:OnEnter()
  if zoneFuechtingshof.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
      Media = zmediaGang1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB20
    })
  end
end
function zoneFuechtingshof:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneGuenterGrassHaus:OnProximity()
  if zoneGuenterGrassHaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneGuenterGrassHaus:OnEnter()
  if zoneGuenterGrassHaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Günter-Grass-Haus ist ein Museum, das dem literarischen, malerischen und plastischen Schaffen des Literaturnobelpreisträgers Günter Grass gewidmet ist, der im Alter bei Lübeck lebte. Träger des im Oktober 2002 eröffneten Hauses ist die Kulturstiftung Hansestadt Lübeck.", {PocketPC = 1}),
      Media = zmediaggrass,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB22
    })
  end
end
function zoneGuenterGrassHaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneHaasenhof:OnProximity()
  if zoneHaasenhof.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneHaasenhof:OnEnter()
  if zoneHaasenhof.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
      Media = zmediaGang1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB23
    })
  end
end
function zoneHaasenhof:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zonehalbrunderWehrturm:OnProximity()
  if zonehalbrunderWehrturm.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zonehalbrunderWehrturm:OnEnter()
  if zonehalbrunderWehrturm.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Lübecker Stadtbefestigung war eine der ausgedehntesten städtischen Befestigungsanlagen in Norddeutschland und Nordeuropa und ist in Teilen noch heute erhalten. \nMit der Besiedlung des Hügels Bucu zwischen Trave und Wakenitz im Zuge der Stadtgründung Lübecks im 12. Jahrhundert verbunden war die Erkenntnis, dass der Standort des weiter abwärts der Trave in flachem Grünland des Urstromtals gelegenen alten Liubice sich nicht hinreichend würde befestigen lassen. ", {PocketPC = 1}),
      Media = zmediawallanlagen1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB25
    })
  end
end
function zonehalbrunderWehrturm:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneHansemuseum:OnProximity()
  if zoneHansemuseum.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneHansemuseum:OnEnter()
  if zoneHansemuseum.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Europäische Hansemuseum zeigt die Geschichte der Hanse und ist weltweit das größte seiner Art. \nHier standen zuvor ein Luftschutzbunker aus dem Zweiten Weltkrieg und ein Seemannsheim. \nDie Bürgerschaft der Hansestadt Lübeck beschloss im Juli 2010, den Bau eines Hansemuseums zu ermöglichen. Dem Beschluss waren jahrelange Überlegungen und Diskussionen vorausgegangen. Mit dem Abriss der bisherigen Gebäude an dem Standort wurde im Januar 2012 begonnen. Die Fertigstellung war ursprünglich zum Herbst 2013 geplant. Sie wurde zwischenzeitlich auf das Jahr 2014 zum 34. Hansetag der Neuzeit in Lübeck verschoben. ", {PocketPC = 1}),
      Media = zmediaHansemuseum1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB27
    })
  end
end
function zoneHansemuseum:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneHeiligenGeistHospital:OnProximity()
  if zoneHeiligenGeistHospital.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneHeiligenGeistHospital:OnEnter()
  if zoneHeiligenGeistHospital.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das 1286 in Backsteingotik erbaute Heiligen-Geist-Hospital am Koberg in Lübeck ist eine der ältesten bestehenden Sozialeinrichtungen der Welt und eines der bedeutendsten Bauwerke der Stadt. Es steht in der Tradition der Heilig-Geist-Spitäler nach dem Vorbild von Santo Spirito in Sassia in Rom. Betreut wurden die Spitäler von den Brüdern vom Orden des Heiligen Geistes. \nDem Hospital gehörten in und um Lübeck herum viele Ländereien, deren Einkünfte ausreichten, um die Armen und Kranken zu versorgen und andere Einrichtungen zu unterstützen.", {PocketPC = 1}),
      Media = zmediahospital1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB29
    })
  end
end
function zoneHeiligenGeistHospital:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneHolstentor:OnProximity()
  if zoneHolstentor.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneHolstentor:OnEnter()
  if zoneHolstentor.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Holstentor (Holstein-Tor) gehört zu den Überresten der Lübecker Stadtbefestigung und zierte früher den 50DM Schein. \nDas spätgotisches Holstentor ist neben dem Burgtor das einzige erhaltene Stadttor Lübecks. Mehr als 300 Jahre lang stand es als Mittleres Holstentor in einer Reihe mit drei weiteren Holstentoren, die im 19. Jahrhundert abgerissen wurden.", {PocketPC = 1}),
      Media = zmediaholstentor2,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB32
    })
  end
end
function zoneHolstentor:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneKaisertor:OnProximity()
  if zoneKaisertor.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneKaisertor:OnEnter()
  if zoneKaisertor.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Kaisertor ist ein Teil der ehemaligen Stadtbefestigungsanlage Lübecks. \nZum Schutz des neuen Mühlendammes und der eingebauten lebenswichtigen Wassermühlen errichtete die Stadt um 1300 zwei Wehrtürme, den Buten- und den Kaiserturm. Der Butenturm wurde bereits Ende des 16. Jahrhunderts abgebrochen und durch einen runden Geschützturm, den Runden Zwinger oder Fischerturm ersetzt. Den Kaiserturm (angeblich nach seinem Erbauer so bezeichnet) flankierten Schutzwälle. Durch einen Tortunnel gelangten die Passanten in einen Zwinger. Von ihm führte eine Brücke über den Wassergraben ins Vorland.", {PocketPC = 1}),
      Media = zmediakaisertor1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB36
    })
  end
end
function zoneKaisertor:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneKatharinenkirche:OnProximity()
  if zoneKatharinenkirche.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneKatharinenkirche:OnEnter()
  if zoneKatharinenkirche.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Katharinenkirche, auch St. Katharinen zu Lübeck, ist die Kirche des ehemaligen Franziskaner-Klosters und die einzige erhaltene Klosterkirche in Lübeck. \nAls Klosterkirche eines Bettelordens erhielt sie keinen Turm, sondern lediglich einen Dachreiter.  \nDas Katharinenkloster bestand als Kloster der Franziskaner von 1225 bis zur Reformation 1531. Der mittelalterliche Gebäudekomplex ist heute Bestandteil des Weltkulturerbes und beinhaltet die ehemalige Klosterkirche (heute Museum), das altsprachliche Gymnasium Katharineum und die daran anschließende Stadtbibliothek.", {PocketPC = 1}),
      Media = zmediaKatharinenkirche1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB39
    })
  end
end
function zoneKatharinenkirche:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneKranenKonvent:OnProximity()
  if zoneKranenKonvent.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneKranenKonvent:OnEnter()
  if zoneKranenKonvent.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Gebäude des Kranen-Konvents ist eines der ältesten erhaltenen backsteingotischen Bauwerke in der Altstadt und Bestandteil des Weltkulturerbes. \nDie Bausubstanz geht auf das Jahr 1283 zurück. Sein dreischiffiger und mit drei Jochen Kreuzrippengewölben ausgestatteter Keller ist der älteste erhaltene Gewölbekeller in Lübeck. \nDas Haus wurde ursprünglich als Beginenhaus errichtet, also als Haus für Jungfrauen oder Witwen, die aus religiösen oder wirtschaftlichen Gründen wie Nonnen leben wollten oder mußten. In dem Haus fanden etwa 16 bis 20 Beginen eine Bleibe. ", {PocketPC = 1}),
      Media = zmediaKKonvent1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB42
    })
  end
end
function zoneKranenKonvent:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneLISAvonLuebeck:OnProximity()
  if zoneLISAvonLuebeck.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneLISAvonLuebeck:OnEnter()
  if zoneLISAvonLuebeck.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Lisa von Lübeck ist die einzige deutsche Rekonstruktion eines Hanseschiffs, genauer einer Kraweel, aus dem 15. Jahrhundert. \nDie Kiellegung war am 31. Juli 1999. 350 Mitarbeiter waren an der Rekonstruktion beteiligt, überwiegend ungelernte ABM-Kräfte. Die Initiatorin des Projektes, Lisa Dräger aus Lübeck, sagte in einem Zeitungsinterview, die Idee sei ihr schon 1936 gekommen, als die Lübecker Kogge, ein Nachbau einer Kogge, das Olympische Feuer von Lübeck zu den Segelwettbewerben der Olympischen Spiele nach Kiel gefahren hatte. 1991 wurde die Rekonstruktion der Kogge Ubena von Bremen in Lübeck ausgestellt, und Lisa Dräger nahm das Projekt in Angriff. ", {PocketPC = 1}),
      Media = zmediaLisa1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB44
    })
  end
end
function zoneLISAvonLuebeck:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneLoewenapotheke:OnProximity()
  if zoneLoewenapotheke.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneLoewenapotheke:OnEnter()
  if zoneLoewenapotheke.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Eines der ältesten Backsteinhäuser Lübecks. \nDer spätromanische Hintergiebel aus der Zeit um 1230, nach Einsturz 1942 rekonstruiert. Der gotische Vordergiebel aus der ersten Hälfte des 14. Jh. um 1460 bei der Verbindung der vorher selbständigen beiden Gebäude verändert. Seit 1812 die Löwen-Apotheke. \n \nBeim Besuch Kaiser Karls IV. in Lübeck 1375 wohnte die Kaiserin Elisabeth in diesem Haus, das für den Besuch extra mit einer hölzernen Brücke über die Königstraße zum benachbarten Eckhaus als der Residenz des Kaisers ausgestattet wurde, damit die beiden unbemerkt von den schaulustigen Bürgern Umgang pflegen konnten.", {PocketPC = 1}),
      Media = zmediaLoewenapotheke1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB46
    })
  end
end
function zoneLoewenapotheke:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneMarienkirche:OnProximity()
  if zoneMarienkirche.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneMarienkirche:OnEnter()
  if zoneMarienkirche.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Lübecker Bürger- und Marktkirche, 1277 bis 1351 erbaut und Teil des UNESCO-Welterbes, ist von jeher ein Symbol für Macht und Wohlstand der alten Hansestadt und befindet sich auf dem höchsten Punkt der Lübecker Altstadtinsel. \nSt. Marien gilt als Mutterkirche der Backsteingotik und war Vorbild für rund 70 Kirchen dieses Stils im Ostseeraum. Daher wird dem Bauwerk eine herausragende architektonische Bedeutung beigemessen. Mit der Marienkirche wurde der hochaufstrebende Gotik-Stil aus Frankreich mit norddeutschem Backstein umgesetzt. Sie beherbergt mit 38,5m das höchste Backsteingewölbe der Welt. \nZuvor hatte man keine Kirche aus Backstein so hoch gebaut und mit einem Gewölbe versehen. Ein System aus Stützen lenkt die Schubkräfte des Gewölbes nach außen über ein Strebewerk ab und ermöglicht so die enorme Höhe.", {PocketPC = 1}),
      Media = zmediaMarien1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB48
    })
  end
end
function zoneMarienkirche:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneMarkt:OnProximity()
  if zoneMarkt.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneMarkt:OnEnter()
  if zoneMarkt.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ausgrabungen Ende der 1990er Jahre brachten sieben Schichten aus unterschiedlichen Zeiten zu Tage, was darauf hinweist, dass der Markt durchgehend benutzt wurde. Außerdem fand man römische Keramik, die in Schächten verborgen lag. Man vermutet, dass es sich um Opfergaben aus der frühgeschichtlichen Zeit handeln könnte. Dass der Platz bereits in der Frühgeschichte eine besondere Bedeutung innehatte, lässt sich den Schriften aus dem Jahr 1156 entnehmen, wo erwähnt wird, dass auf diesem Platz heidnische Stämme ihren Thing (Volks- / Gerichtsversammlung) abgehalten hatten.", {PocketPC = 1}),
      Media = zmediaMarkt1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB52
    })
  end
end
function zoneMarkt:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneMarstall:OnProximity()
  if zoneMarstall.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneMarstall:OnEnter()
  if zoneMarstall.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Marstall wurde 1298 erstmals erwähnt. Seine verbliebenen Gebäude rund um den Marstallhof zwischen dem Burgkloster und dem Burgtor sind Bestandteil der Lübecker Stadtbefestigung und stehen als Bestandteile des Welterbes der Lübecker Altstadt unter Denkmalschutz. Sie werden heute als Jugendzentrum genutzt.", {PocketPC = 1}),
      Media = zmediaMarstall1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB55
    })
  end
end
function zoneMarstall:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneMuseumBehnhausDraegerhaus:OnProximity()
  if zoneMuseumBehnhausDraegerhaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneMuseumBehnhausDraegerhaus:OnEnter()
  if zoneMuseumBehnhausDraegerhaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Behnhaus (Museum Behnhaus Drägerhaus, Galerie des 19. Jahrhunderts und der Klassischen Moderne) ist ein Lübecker Museum und Teil des Lübecker Museums für Kunst- und Kulturgeschichte. Es steht in der Stadt für die Malerei der Nazarener und den deutschen Impressionismus und Expressionismus, aber auch für die bürgerliche Wohnkultur von Rokoko, Klassizismus und Biedermeier.", {PocketPC = 1}),
      Media = zmediaBehnhaus,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB57
    })
  end
end
function zoneMuseumBehnhausDraegerhaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneMuseumshafen:OnProximity()
  if zoneMuseumshafen.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneMuseumshafen:OnEnter()
  if zoneMuseumshafen.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Museumshafen Lübeck liegt eigentlich zwischen der denkmalgeschützten Drehbrücke und der Musik- und Kongresshalle Lübeck. \nZur Winterzeit, wenn die Oldtimer aufliegen, ist dieser innere Museumshafen am stärksten frequentiert. Neben vielen alten ostseetypischen Lastenseglern gehören auch ein altes Binnenschiff, ein Baggerschiff und ein Schlepper zum Bestand. Im Sommer liegen viele Museumsschiffe, bedingt durch die störanfällige Drehbrücke, jedoch jenseits und nördlich davon bevorzugt im äußeren Museumshafen, dem Hansehafen, direkt vor den Media Docks auf der Wallhalbinsel.", {PocketPC = 1}),
      Media = zmediaMuseumshafen,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB58
    })
  end
end
function zoneMuseumshafen:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneNiederegger:OnProximity()
  if zoneNiederegger.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneNiederegger:OnEnter()
  if zoneNiederegger.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Niederegger ist einer der bekanntesten Hersteller von Lübecker Marzipan. \nDas Marzipan von Niederegger besteht zu 100 % aus Rohmasse. Nach Firmenangaben werden täglich bis zu 30.000 kg Marzipan hergestellt.  Die Produktpalette umfasst 300 Spezialitäten wie Marzipan und Nougat sowie Pralinen, Trüffel, Baumkuchen, Stollen und Gebäck. Außerdem werden Sonderfertigungen nach Wunsch ausgeführt. Die Produkte werden in weltweit mehr als 40 Länder versandt.", {PocketPC = 1}),
      Media = zmediaNiederegger2,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB59
    })
  end
end
function zoneNiederegger:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zonePetrikirche:OnProximity()
  if zonePetrikirche.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zonePetrikirche:OnEnter()
  if zonePetrikirche.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die St.-Petri-Kirche zu Lübeck ist ein Gotteshaus, das erstmals im Jahr 1170 erwähnt wurde. Im Laufe der Jahrhunderte wurde sie mehrmals ausgebaut, bis sie im 15. Jahrhundert fertig gebaut war. Im Zweiten Weltkrieg erlitt sie starke Schäden und wurde erst 1987 vollständig restauriert. Da die Ausstattung nicht wiederhergestellt wurde, finden in ihr keine Gottesdienste mehr statt. Stattdessen wird sie für kulturelle und religiöse Veranstaltungen sowie Kunstausstellungen genutzt.", {PocketPC = 1}),
      Media = zmediaPetri1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB62
    })
  end
end
function zonePetrikirche:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zonePuppenbruecke:OnProximity()
  if zonePuppenbruecke.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zonePuppenbruecke:OnEnter()
  if zonePuppenbruecke.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Puppenbrücke ist die erste aus Stein gebaute Brücke der Hansestadt. \n1475 beschloss man die Befestigungen Lübecks weiter auszubauen. Innerhalb von sechs Jahren entstand vor dem Holstentor ein breiter Graben und hohe Erdwälle. Über diesen Graben führte eine Holzbrücke, die wegen hoher Unterhaltskosten knapp 300 Jahre später durch eine Brücke aus Stein ersetzt werden sollte. \nDie Steinquader wurden in Reinfeld, wo das alte Kloster niedergerissen wurde, gekauft und 1770 mit dem Bau der Brücke begonnen. Der Stadtgraben wurde nördlich der alten Brücke durch Einschütten geschmälert. Die neue Brücke war 51m lang, besaß eine 3m breite Zugbrücke und wurde binnen zwei Jahren vollendet.", {PocketPC = 1}),
      Media = zmediapuppen1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB65
    })
  end
end
function zonePuppenbruecke:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneRathaus:OnProximity()
  if zoneRathaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneRathaus:OnEnter()
  if zoneRathaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Rathaus der Hansestadt Lübeck zählt zu den bekanntesten Bauwerken der Backsteingotik. Es ist eines der größten mittelalterlichen Rathäuser in Deutschland. \nDie Geschichte des Rathauses ist voller An-/Umbauten über die Jahrhunderte und umfasst dadurch auch mehrere Stilrichtungen von Romanisch über Gotisch bis Renaissance.", {PocketPC = 1}),
      Media = zmediaRathaus1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB68
    })
  end
end
function zoneRathaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneSalzspeicher:OnProximity()
  if zoneSalzspeicher.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneSalzspeicher:OnEnter()
  if zoneSalzspeicher.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Salzspeicher sind eine Gruppe von Lagerhäusern, erbaut zwischen 1579 und 1745, an der Lübecker Obertrave direkt neben dem Holstentor. Sie wurden im Stil der Backsteinrenaissance und des Backsteinbarock erbaut.", {PocketPC = 1}),
      Media = zmediasalzspeicher1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB72
    })
  end
end
function zoneSalzspeicher:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneSchiffergesellschaft:OnProximity()
  if zoneSchiffergesellschaft.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneSchiffergesellschaft:OnEnter()
  if zoneSchiffergesellschaft.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Schiffergesellschaft wurde am 26. Dezember 1401 als St.-Nikolaus-Bruderschaft gegründet um: Zu Hilfe und Trost der Lebenden und Toten und aller, die ihren ehrlichen Unterhalt in der Schifffahrt suchen. \nDa sich im Zuge der Reformation fast alle religiösen Bruderschaften auflösten, vereinigte man sich mit der St.-Annen-Bruderschaft und nannte sich die Schippern Selschup. 1535 erwarb man für 940 Lübische Mark dies im 13. Jahrhundert erbaute Haus. \nIm Laufe der Jahre kamen der Schiffergesellschaft durch die seemännischen Kenntnisse ihrer Brüder Aufgaben wie das Ausstellen von Schiffspässen, Bewachung des Hafens und Beratung des Senats hinzu. So schrieb das hansische Seerecht von 1614 fest, dass Streitigkeiten zwischen Seeleuten der Schiffergesellschaft vorzutragen seien.", {PocketPC = 1}),
      Media = zmediaschiffergsell1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB75
    })
  end
end
function zoneSchiffergesellschaft:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneSchwansHof:OnProximity()
  if zoneSchwansHof.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneSchwansHof:OnEnter()
  if zoneSchwansHof.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
      Media = zmediaGang1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB77
    })
  end
end
function zoneSchwansHof:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneStAegidienKirche:OnProximity()
  if zoneStAegidienKirche.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneStAegidienKirche:OnEnter()
  if zoneStAegidienKirche.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die St.-Aegidien-Kirche, auch Aegidienkirche, ist die kleinste und östlichste Innenstadtkirche, Sie war das Zentrum des Viertels der Handwerker, das auf dem östlichen Abhang des Innenstadthügels in Richtung Wakenitz angesiedelt war. \n1227 wurde St. Aegidien das erste Mal urkundlich erwähnt. Nicht belegbar, aber aufgrund der für Norddeutschland ungewöhnlichen Namensgebung vermutet wird die ursprüngliche Errichtung einer Holzkirche bereits zwischen den Jahren 1172 und 1182 unter Bischof Heinrich I. von Brüssel, der zuvor Abt des Benediktinerklosters St. Aegidien in Braunschweig gewesen war.", {PocketPC = 1}),
      Media = zmediaAegidien1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB79
    })
  end
end
function zoneStAegidienKirche:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneStAnnenMuseumsquartier:OnProximity()
  if zoneStAnnenMuseumsquartier.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneStAnnenMuseumsquartier:OnEnter()
  if zoneStAnnenMuseumsquartier.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Museumsquartier St. Annen befindet sich in den Gebäuden des ehemaligen St.-Annen-Klosters, ein ehemaliges Kloster der Augustinerinnen und diente vor allem der Unterbringung unverheirateter Töchter Lübecker Bürger. \nDas Kloster und die dazugehörige Kirche, die aufgrund der beengten Grundstücksverhältnisse einen eigenständigen Baustil aufweist, wurden von 1502 bis 1515 im spätgotischen Stil errichtet. \nAuf Vorschlag des Lübecker Bischofs wurden Kloster und Kirche der Heiligen Anna geweiht. Nur wenige Jahre später wurde das Kloster im Zuge der Reformation wieder geschlossen, 1532 verließen die letzten Nonnen das Kloster. 1601 entstand in den Räumen ein Armenhaus, später wurden weitere Teile als Zuchthaus genutzt, wofür 1778 ein weiterer Flügel, das Spinnhaus, errichtet wurde. Armenpflege und Strafvollzug befanden sich unter einem Dach.", {PocketPC = 1}),
      Media = zmediaStAnnen1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB81
    })
  end
end
function zoneStAnnenMuseumsquartier:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneStJakobiKirche:OnProximity()
  if zoneStJakobiKirche.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneStJakobiKirche:OnEnter()
  if zoneStJakobiKirche.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("St. Jakobi ist eine der fünf evangelisch-lutherischen Hauptpfarrkirchen in der Lübecker Altstadt. \nSie wurde im Jahre 1334 als Kirche der Seefahrer und Fischer geweiht. Ihr Patron ist der Heilige Jakobus der Ältere. Die Kirche, das Heiligen-Geist-Hospital und die benachbarte Gertrudenherberge sind Stationen auf einem Zweig des Jakobswegs von Nordeuropa nach Santiago de Compostela. Seit September 2007 ist die nördliche Turmkapelle der Kirche als Pamir-Kapelle Nationale Gedenkstätte für die zivile Seefahrt. \nHier steht auch das Wrack eines Rettungsbootes der 1957 gesunkenen Viermastbark Pamir, bei deren Untergang 80 der 86 Besatzungsmitglieder ums Leben kamen.", {PocketPC = 1}),
      Media = zmediaJakobi1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB83
    })
  end
end
function zoneStJakobiKirche:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneStadtmauer:OnProximity()
  if zoneStadtmauer.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneStadtmauer:OnEnter()
  if zoneStadtmauer.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Lübecker Stadtbefestigung war eine der ausgedehntesten städtischen Befestigungsanlagen in Norddeutschland und Nordeuropa und ist in Teilen noch heute erhalten. \nMit der Besiedlung des Hügels Bucu zwischen Trave und Wakenitz im Zuge der Stadtgründung Lübecks im 12. Jahrhundert verbunden war die Erkenntnis, dass der Standort des weiter abwärts der Trave in flachem Grünland des Urstromtals gelegenen alten Liubice sich nicht hinreichend würde befestigen lassen. ", {PocketPC = 1}),
      Media = zmediawallanlagen1,
      Buttons = {
        "sofort weiter",
        "mehr Info"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB85
    })
  end
end
function zoneStadtmauer:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneTheaterfigurenmuseum:OnProximity()
  if zoneTheaterfigurenmuseum.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneTheaterfigurenmuseum:OnEnter()
  if zoneTheaterfigurenmuseum.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das TheaterFigurenMuseum Lübeck ist ein Museum für die Geschichte und Gegenwart des Puppentheaters in Europa, Afrika und Asien. Im Museum sind Bühnen und Drehorgeln, Schattenspiele, Schlenkermarionetten und allerlei Kuriositäten ausgestellt. Das TheaterFigurenMuseum befindet sich in fünf historischen Kaufmannshäusern der Backsteingotik. \nDas Museum entstand aus der jahrzehntelangen Sammelleidenschaft von Fritz Fey, der aus einer Puppenspielerfamilie stammt und auf beruflich bedingten Reisen seinem Hobby nachging: Er sammelte Theaterfiguren, begeistert von der Vielfalt ihrer Ausdrucksmöglichkeiten in den verschiedenen Theatertraditionen des internationalen Puppentheaters. \nDas passende Figurentheater ist übrigens gleich ein paar Meter weiter.", {PocketPC = 1}),
      Media = zmediaTheaterfigurenmuseum,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB87
    })
  end
end
function zoneTheaterfigurenmuseum:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneWillyBrandtHaus:OnProximity()
  if zoneWillyBrandtHaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneWillyBrandtHaus:OnEnter()
  if zoneWillyBrandtHaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Willy-Brandt-Haus Lübeck ist ein Museum und eine Gedenkstätte für den früheren deutschen SPD-Politiker, Bundeskanzler und Friedensnobelpreisträger Willy Brandt. \nDas Gebäude, eine Außenstelle der Bundeskanzler-Willy-Brandt-Stiftung mit Sitz in Berlin, ist außerdem Sitz des Amts für Denkmalschutz der Hansestadt Lübeck in Schleswig-Holstein.  \nWilly Brandt wurde nicht in dem Gebäude in der Lübecker Innenstadt, sondern im Stadtteil St. Lorenz geboren.", {PocketPC = 1}),
      Media = zmediaWBrandt,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB88
    })
  end
end
function zoneWillyBrandtHaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zoneZeughaus:OnProximity()
  if zoneZeughaus.Visible == false then
    Wherigo.MessageBox({
      Text = "Du bist 15m von einer Zone entfernt!",
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB2
    })
  end
end
function zoneZeughaus:OnEnter()
  if zoneZeughaus.Visible == false then
    Wherigo.PlayAudio(zmediasoundfanfare)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Zeughaus am Großen Bauhof und dem Domkirchhof in Lübeck wurde 1594 neben dem Lübecker Dom im Stil der Niederländischen Renaissance erbaut. \nAls Zeughaus wird ein Gebäude bezeichnet, in dem Waffen und militärische Ausrüstungsgegenstände gelagert und instand gesetzt wurden.", {PocketPC = 1}),
      Media = zmediazeugenhaus,
      Buttons = {
        "sofort weiter"
      },
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB89
    })
  end
end
function zoneZeughaus:OnExit()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zitemBronzecache:OnFund()
  zitemBronzecache:MoveTo(zoneFinalBronze)
  zoneFinalBronze.Active = false
  ztaskFindedasBronzeFinal.Active = false
  Wherigo.PlayAudio(zmediasoundapplaus)
  Wherigo.MessageBox({
    Text = [[Gut gemacht! Versteck sie wieder so, dass sie kaum zu sehen ist! Lust auf mehr? :D]],
    Media = zmediathavorianer
  })
end
function zitemBronzecache:OnHint()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Poledance in 2,5m Höhe? ;) \n \nBeim Zurückhängen bitte richtige Seite nach oben (wegen Regen) und das man es nur von unten sieht! \n", {PocketPC = 1}),
    Media = zmediathavorianer
  })
end
function zitemGoldcache:OnFund()
  zitemGoldcache:MoveTo(zoneFinalGold)
  zoneFinalGold.Active = false
  ztaskFindedasGoldFinal.Active = false
  Wherigo.PlayAudio(zmediasoundapplaus)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du hast Gold! \nHolt den gekühlten Champagner raus!!! ;D \nEs gibt in Lübeck natürlich noch jede Menge mehr Sehenswertes;  \nAndere schöne Gänge und Höfe, mehrere Restaurants in historischen Gewölben, Theater, etc. - man kann nicht allem gerecht werden, aber sie sind definitv auch ein Besuch wert! \n \nWenn du möchtest, kannst du jetzt über eine Sicherheitsabfrage noch den Unlock-Code für die Cartridge bekommen. \nDies ist nur notwendig, wenn du auch auf wherigo.com loggen möchtest. \nAlle anderen können die Cartridge nun einfach beenden. \n \nIch hoffe Ihr hattet viel Spaß bei der kleinen Stadtführung  :D \ndie thavorianer", {PocketPC = 1}),
    Media = zmediathavorianer,
    Buttons = {
      "Unlock-Code"
    },
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB92
  })
end
function zitemGoldcache:OnHint()
  Wherigo.MessageBox({
    Text = "Der Drache bewacht den Goldschatz ;) \n",
    Media = zmediathavorianer
  })
end
function zitemInfo:OnBuddenbrookhaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Buddenbrookhaus (Heinrich-und-Thomas-Mann-Zentrum) ist seit 1993 eine Gedenkstätte in Trägerschaft der Kulturstiftung Hansestadt Lübeck. \nIm Haus befindet sich ein Museum mit zwei festen Ausstellungen: Die Buddenbrooks - Ein Jahrhundertroman und Die Manns - eine Schriftstellerfamilie. \nSeine herausragende Bedeutung erhält das Haus dadurch, dass es in die Weltliteratur eingegangen ist, indem es den Schauplatz für den Roman Buddenbrooks abgegeben hat. Die sich über vier Generationen hinziehende Geschichte der Romanfamilie Buddenbrook, die in vielen, aber lange nicht in allen Details der Geschichte der Familie Mann gleicht, spielte sich zu großen Teilen hinter der heute noch stehenden spätbarocken Fassade ab.", {PocketPC = 1}),
    Media = zmediaBuddenbrookhaus
  })
end
function zitemInfo:OnBurgkloster()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Burgkloster, ursprünglich Maria-Magdalenen-Kloster, ist ein ehemaliges Lübecker Dominikanerkloster. \nAn der Stelle des heutigen Burgklosters, dem schmalen Zugang zur Altstadt-Halbinsel, befand sich schon die slawische Burg Bucu (wahrscheinlich im 8. Jahrhundert errichtet). \nDer Traveabwärts gelegene Ort Liubice wurde 1127 auf den Stadthügel Bucu verlegt. 1143 gründete Adolf II. an dieser Stelle die heutige Stadt Lübeck.", {PocketPC = 1}),
    Media = zmediaburkloster1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemInfo:OnBurgtor()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das im spätgotischen Stil erbaute Burgtor in Lübeck ist das nördliche von ehemals vier Stadttoren der Lübecker Stadtbefestigung und neben dem Holstentor das einzige, welches noch heute erhalten ist. Es hat seinen Namen nach der alten, hoch über der Trave gelegenen Lübecker Burg, die 1227 zum Burgkloster umgebaut wurde.", {PocketPC = 1}),
    Media = zmediaburgtor2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB99
  })
end
function zitemInfo:OnDom()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im Jahre 1173 legte Heinrich der Löwe als Stifter den Grundstein des Lübecker Doms als Kathedrale für das Bistum Lübeck. \nDer Lübecker Dom, 1247 geweiht, ist der erste große Backsteinkirchbau an der Ostsee und mit 130 Metern Länge eine der längsten Backsteinkirchen. \nHinsichtlich der steinernen Sarkophage in seinen Grabkapellen nimmt der Dom in Lübeck eine herausragende Stellung ein. \nDer Dom ist Ort mehrerer Legenden, darunter der Domgründungslegende, die in einem zweiteiligen Wandbild im südlichen Seitenschiff dargestellt ist, sowie der Legende von der Rose des Domherrn Rabundus, die in Ludwig Bechsteins Deutschem Sagenbuch Aufnahme fand.", {PocketPC = 1}),
    Media = zmediaDom1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB102
  })
end
function zitemInfo:OnDunkelundHellgrnerGang()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
    Media = zmediaGang1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB105
  })
end
function zitemInfo:OnFchtingshof()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
    Media = zmediaGang1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB107
  })
end
function zitemInfo:OnFeuerschiffFehmarnbelt()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Fehmarnbelt ist ein deutsches Feuerschiff, das nicht mehr als solches auf Position liegt, sondern als Museumsschiff heute noch in Fahrt ist und somit leider hier nicht immer vor Anker liegt. \nDas Schiff wurde von 1906 bis 1908 auf der Thyen-Werft in Brake an der Weser als Dreimastschoner mit Notbesegelung gebaut und 1908 als Feuerschiff Außeneider in Dienst gestellt. \n1931 wurde ein Motor eingebaut. 1954 und 1956 kam es zu verschiedenen Umbauten. Das Leuchtfeuer wurde verstärkt, ein Funkfeuer nachgerüstet. \nAm 31. März 1984 wurde es als letztes deutsches Feuerschiff auf der Ostsee außer Dienst gestellt; die Position wurde durch eine unbemannte Großtonne übernommen. Seit 1986 ist es Museumsschiff. Es wird in fahrtüchtigem Zustand gehalten und macht seit 1989 im Sommer Ausfahrten, um alle Anlagen unter Seebedingungen zu testen.", {PocketPC = 1}),
    Media = zmediaFeuerschiff
  })
end
function zitemInfo:OnGuenterGrassHaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Günter-Grass-Haus ist ein Museum, das dem literarischen, malerischen und plastischen Schaffen des Literaturnobelpreisträgers Günter Grass gewidmet ist, der im Alter bei Lübeck lebte. Träger des im Oktober 2002 eröffneten Hauses ist die Kulturstiftung Hansestadt Lübeck.", {PocketPC = 1}),
    Media = zmediaggrass
  })
end
function zitemInfo:OnHaasenhof()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
    Media = zmediaGang1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB111
  })
end
function zitemInfo:OnhalbrunderWehrturm()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lübecker Stadtbefestigung war eine der ausgedehntesten städtischen Befestigungsanlagen in Norddeutschland und Nordeuropa und ist in Teilen noch heute erhalten. \nMit der Besiedlung des Hügels Bucu zwischen Trave und Wakenitz im Zuge der Stadtgründung Lübecks im 12. Jahrhundert verbunden war die Erkenntnis, dass der Standort des weiter abwärts der Trave in flachem Grünland des Urstromtals gelegenen alten Liubice sich nicht hinreichend würde befestigen lassen. ", {PocketPC = 1}),
    Media = zmediawallanlagen1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB113
  })
end
function zitemInfo:OnHansemuseum()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Europäische Hansemuseum zeigt die Geschichte der Hanse und ist weltweit das größte seiner Art. \nHier standen zuvor ein Luftschutzbunker aus dem Zweiten Weltkrieg und ein Seemannsheim. \nDie Bürgerschaft der Hansestadt Lübeck beschloss im Juli 2010, den Bau eines Hansemuseums zu ermöglichen. Dem Beschluss waren jahrelange Überlegungen und Diskussionen vorausgegangen. Mit dem Abriss der bisherigen Gebäude an dem Standort wurde im Januar 2012 begonnen. Die Fertigstellung war ursprünglich zum Herbst 2013 geplant. Sie wurde zwischenzeitlich auf das Jahr 2014 zum 34. Hansetag der Neuzeit in Lübeck verschoben. ", {PocketPC = 1}),
    Media = zmediaHansemuseum1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB115
  })
end
function zitemInfo:OnHeiligenGeistHospital()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das 1286 in Backsteingotik erbaute Heiligen-Geist-Hospital am Koberg in Lübeck ist eine der ältesten bestehenden Sozialeinrichtungen der Welt und eines der bedeutendsten Bauwerke der Stadt. Es steht in der Tradition der Heilig-Geist-Spitäler nach dem Vorbild von Santo Spirito in Sassia in Rom. Betreut wurden die Spitäler von den Brüdern vom Orden des Heiligen Geistes. \nDem Hospital gehörten in und um Lübeck herum viele Ländereien, deren Einkünfte ausreichten, um die Armen und Kranken zu versorgen und andere Einrichtungen zu unterstützen.", {PocketPC = 1}),
    Media = zmediahospital1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB117
  })
end
function zitemInfo:OnHolstentor()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Holstentor (Holstein-Tor) gehört zu den Überresten der Lübecker Stadtbefestigung und zierte früher den 50DM Schein. \nDas spätgotisches Holstentor ist neben dem Burgtor das einzige erhaltene Stadttor Lübecks. Mehr als 300 Jahre lang stand es als Mittleres Holstentor in einer Reihe mit drei weiteren Holstentoren, die im 19. Jahrhundert abgerissen wurden.", {PocketPC = 1}),
    Media = zmediaholstentor2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB120
  })
end
function zitemInfo:OnKaisertor()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Kaisertor ist ein Teil der ehemaligen Stadtbefestigungsanlage Lübecks. \nZum Schutz des neuen Mühlendammes und der eingebauten lebenswichtigen Wassermühlen errichtete die Stadt um 1300 zwei Wehrtürme, den Buten- und den Kaiserturm. Der Butenturm wurde bereits Ende des 16. Jahrhunderts abgebrochen und durch einen runden Geschützturm, den Runden Zwinger oder Fischerturm ersetzt. Den Kaiserturm (angeblich nach seinem Erbauer so bezeichnet) flankierten Schutzwälle. Durch einen Tortunnel gelangten die Passanten in einen Zwinger. Von ihm führte eine Brücke über den Wassergraben ins Vorland.", {PocketPC = 1}),
    Media = zmediakaisertor1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB124
  })
end
function zitemInfo:OnKatharinenkirche()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Katharinenkirche, auch St. Katharinen zu Lübeck, ist die Kirche des ehemaligen Franziskaner-Klosters und die einzige erhaltene Klosterkirche in Lübeck. \nAls Klosterkirche eines Bettelordens erhielt sie keinen Turm, sondern lediglich einen Dachreiter.  \nDas Katharinenkloster bestand als Kloster der Franziskaner von 1225 bis zur Reformation 1531. Der mittelalterliche Gebäudekomplex ist heute Bestandteil des Weltkulturerbes und beinhaltet die ehemalige Klosterkirche (heute Museum), das altsprachliche Gymnasium Katharineum und die daran anschließende Stadtbibliothek.", {PocketPC = 1}),
    Media = zmediaKatharinenkirche1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB127
  })
end
function zitemInfo:OnKranenKonvent()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Gebäude des Kranen-Konvents ist eines der ältesten erhaltenen backsteingotischen Bauwerke in der Altstadt und Bestandteil des Weltkulturerbes. \nDie Bausubstanz geht auf das Jahr 1283 zurück. Sein dreischiffiger und mit drei Jochen Kreuzrippengewölben ausgestatteter Keller ist der älteste erhaltene Gewölbekeller in Lübeck. \nDas Haus wurde ursprünglich als Beginenhaus errichtet, also als Haus für Jungfrauen oder Witwen, die aus religiösen oder wirtschaftlichen Gründen wie Nonnen leben wollten oder mußten. In dem Haus fanden etwa 16 bis 20 Beginen eine Bleibe. ", {PocketPC = 1}),
    Media = zmediaKKonvent1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB130
  })
end
function zitemInfo:OnLISAvonLbeck()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lisa von Lübeck ist die einzige deutsche Rekonstruktion eines Hanseschiffs, genauer einer Kraweel, aus dem 15. Jahrhundert. \nDie Kiellegung war am 31. Juli 1999. 350 Mitarbeiter waren an der Rekonstruktion beteiligt, überwiegend ungelernte ABM-Kräfte. Die Initiatorin des Projektes, Lisa Dräger aus Lübeck, sagte in einem Zeitungsinterview, die Idee sei ihr schon 1936 gekommen, als die Lübecker Kogge, ein Nachbau einer Kogge, das Olympische Feuer von Lübeck zu den Segelwettbewerben der Olympischen Spiele nach Kiel gefahren hatte. 1991 wurde die Rekonstruktion der Kogge Ubena von Bremen in Lübeck ausgestellt, und Lisa Dräger nahm das Projekt in Angriff. ", {PocketPC = 1}),
    Media = zmediaLisa1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB132
  })
end
function zitemInfo:OnLwenapotheke()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Eines der ältesten Backsteinhäuser Lübecks. \nDer spätromanische Hintergiebel aus der Zeit um 1230, nach Einsturz 1942 rekonstruiert. Der gotische Vordergiebel aus der ersten Hälfte des 14. Jh. um 1460 bei der Verbindung der vorher selbständigen beiden Gebäude verändert. Seit 1812 die Löwen-Apotheke. \n \nBeim Besuch Kaiser Karls IV. in Lübeck 1375 wohnte die Kaiserin Elisabeth in diesem Haus, das für den Besuch extra mit einer hölzernen Brücke über die Königstraße zum benachbarten Eckhaus als der Residenz des Kaisers ausgestattet wurde, damit die beiden unbemerkt von den schaulustigen Bürgern Umgang pflegen konnten.", {PocketPC = 1}),
    Media = zmediaLoewenapotheke1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB134
  })
end
function zitemInfo:OnMarienkirche()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lübecker Bürger- und Marktkirche, 1277 bis 1351 erbaut und Teil des UNESCO-Welterbes, ist von jeher ein Symbol für Macht und Wohlstand der alten Hansestadt und befindet sich auf dem höchsten Punkt der Lübecker Altstadtinsel. \nSt. Marien gilt als Mutterkirche der Backsteingotik und war Vorbild für rund 70 Kirchen dieses Stils im Ostseeraum. Daher wird dem Bauwerk eine herausragende architektonische Bedeutung beigemessen. Mit der Marienkirche wurde der hochaufstrebende Gotik-Stil aus Frankreich mit norddeutschem Backstein umgesetzt. Sie beherbergt mit 38,5m das höchste Backsteingewölbe der Welt. \nZuvor hatte man keine Kirche aus Backstein so hoch gebaut und mit einem Gewölbe versehen. Ein System aus Stützen lenkt die Schubkräfte des Gewölbes nach außen über ein Strebewerk ab und ermöglicht so die enorme Höhe.", {PocketPC = 1}),
    Media = zmediaMarien1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB136
  })
end
function zitemInfo:OnMarktplatz()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ausgrabungen Ende der 1990er Jahre brachten sieben Schichten aus unterschiedlichen Zeiten zu Tage, was darauf hinweist, dass der Markt durchgehend benutzt wurde. Außerdem fand man römische Keramik, die in Schächten verborgen lag. Man vermutet, dass es sich um Opfergaben aus der frühgeschichtlichen Zeit handeln könnte. Dass der Platz bereits in der Frühgeschichte eine besondere Bedeutung innehatte, lässt sich den Schriften aus dem Jahr 1156 entnehmen, wo erwähnt wird, dass auf diesem Platz heidnische Stämme ihren Thing (Volks- / Gerichtsversammlung) abgehalten hatten.", {PocketPC = 1}),
    Media = zmediaMarkt1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB140
  })
end
function zitemInfo:OnMarstall()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Marstall wurde 1298 erstmals erwähnt. Seine verbliebenen Gebäude rund um den Marstallhof zwischen dem Burgkloster und dem Burgtor sind Bestandteil der Lübecker Stadtbefestigung und stehen als Bestandteile des Welterbes der Lübecker Altstadt unter Denkmalschutz. Sie werden heute als Jugendzentrum genutzt.", {PocketPC = 1}),
    Media = zmediaMarstall1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB143
  })
end
function zitemInfo:OnMuseumBehnhausDrgerhaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Behnhaus (Museum Behnhaus Drägerhaus, Galerie des 19. Jahrhunderts und der Klassischen Moderne) ist ein Lübecker Museum und Teil des Lübecker Museums für Kunst- und Kulturgeschichte. Es steht in der Stadt für die Malerei der Nazarener und den deutschen Impressionismus und Expressionismus, aber auch für die bürgerliche Wohnkultur von Rokoko, Klassizismus und Biedermeier.", {PocketPC = 1}),
    Media = zmediaBehnhaus
  })
end
function zitemInfo:OnMuseumshafen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Museumshafen Lübeck liegt eigentlich zwischen der denkmalgeschützten Drehbrücke und der Musik- und Kongresshalle Lübeck. \nZur Winterzeit, wenn die Oldtimer aufliegen, ist dieser innere Museumshafen am stärksten frequentiert. Neben vielen alten ostseetypischen Lastenseglern gehören auch ein altes Binnenschiff, ein Baggerschiff und ein Schlepper zum Bestand. Im Sommer liegen viele Museumsschiffe, bedingt durch die störanfällige Drehbrücke, jedoch jenseits und nördlich davon bevorzugt im äußeren Museumshafen, dem Hansehafen, direkt vor den Media Docks auf der Wallhalbinsel.", {PocketPC = 1}),
    Media = zmediaMuseumshafen
  })
end
function zitemInfo:OnNiederegger()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Niederegger ist einer der bekanntesten Hersteller von Lübecker Marzipan. \nDas Marzipan von Niederegger besteht zu 100 % aus Rohmasse. Nach Firmenangaben werden täglich bis zu 30.000 kg Marzipan hergestellt.  Die Produktpalette umfasst 300 Spezialitäten wie Marzipan und Nougat sowie Pralinen, Trüffel, Baumkuchen, Stollen und Gebäck. Außerdem werden Sonderfertigungen nach Wunsch ausgeführt. Die Produkte werden in weltweit mehr als 40 Länder versandt.", {PocketPC = 1}),
    Media = zmediaNiederegger2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB147
  })
end
function zitemInfo:OnPetrikirche()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die St.-Petri-Kirche zu Lübeck ist ein Gotteshaus, das erstmals im Jahr 1170 erwähnt wurde. Im Laufe der Jahrhunderte wurde sie mehrmals ausgebaut, bis sie im 15. Jahrhundert fertig gebaut war. Im Zweiten Weltkrieg erlitt sie starke Schäden und wurde erst 1987 vollständig restauriert. Da die Ausstattung nicht wiederhergestellt wurde, finden in ihr keine Gottesdienste mehr statt. Stattdessen wird sie für kulturelle und religiöse Veranstaltungen sowie Kunstausstellungen genutzt.", {PocketPC = 1}),
    Media = zmediaPetri1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB150
  })
end
function zitemInfo:OnPuppenbrcke()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Puppenbrücke ist die erste aus Stein gebaute Brücke der Hansestadt. \n1475 beschloss man die Befestigungen Lübecks weiter auszubauen. Innerhalb von sechs Jahren entstand vor dem Holstentor ein breiter Graben und hohe Erdwälle. Über diesen Graben führte eine Holzbrücke, die wegen hoher Unterhaltskosten knapp 300 Jahre später durch eine Brücke aus Stein ersetzt werden sollte. \nDie Steinquader wurden in Reinfeld, wo das alte Kloster niedergerissen wurde, gekauft und 1770 mit dem Bau der Brücke begonnen. Der Stadtgraben wurde nördlich der alten Brücke durch Einschütten geschmälert. Die neue Brücke war 51m lang, besaß eine 3m breite Zugbrücke und wurde binnen zwei Jahren vollendet.", {PocketPC = 1}),
    Media = zmediapuppen1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB153
  })
end
function zitemInfo:OnRathaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Rathaus der Hansestadt Lübeck zählt zu den bekanntesten Bauwerken der Backsteingotik. Es ist eines der größten mittelalterlichen Rathäuser in Deutschland. \nDie Geschichte des Rathauses ist voller An-/Umbauten über die Jahrhunderte und umfasst dadurch auch mehrere Stilrichtungen von Romanisch über Gotisch bis Renaissance.", {PocketPC = 1}),
    Media = zmediaRathaus1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB156
  })
end
function zitemInfo:OnSalzspeicher()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Salzspeicher sind eine Gruppe von Lagerhäusern, erbaut zwischen 1579 und 1745, an der Lübecker Obertrave direkt neben dem Holstentor. Sie wurden im Stil der Backsteinrenaissance und des Backsteinbarock erbaut.", {PocketPC = 1}),
    Media = zmediasalzspeicher1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB160
  })
end
function zitemInfo:OnSchiffergesellschaft()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Schiffergesellschaft wurde am 26. Dezember 1401 als St.-Nikolaus-Bruderschaft gegründet um: Zu Hilfe und Trost der Lebenden und Toten und aller, die ihren ehrlichen Unterhalt in der Schifffahrt suchen. \nDa sich im Zuge der Reformation fast alle religiösen Bruderschaften auflösten, vereinigte man sich mit der St.-Annen-Bruderschaft und nannte sich die Schippern Selschup. 1535 erwarb man für 940 Lübische Mark dies im 13. Jahrhundert erbaute Haus. \nIm Laufe der Jahre kamen der Schiffergesellschaft durch die seemännischen Kenntnisse ihrer Brüder Aufgaben wie das Ausstellen von Schiffspässen, Bewachung des Hafens und Beratung des Senats hinzu. So schrieb das hansische Seerecht von 1614 fest, dass Streitigkeiten zwischen Seeleuten der Schiffergesellschaft vorzutragen seien.", {PocketPC = 1}),
    Media = zmediaschiffergsell1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB163
  })
end
function zitemInfo:OnSchwansHof()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Rund 90 Gänge, Torwege und Höfe gibt es noch heute in der Altstadt. Ihre Vielfalt ist weltweit einzigartig. Die Gänge und Höfe sind ein Überrest aus dem mittelalterlichen Städtebau.  \nDie versteckt gelegenen Wohnbereiche wurden Gänge oder Gangviertel genannt. In ihnen wohnten Tagelöhner, Träger oder die Beschäftigten des Gewerbes, das im Straßenhaus ausgeübt wurde. \nErreichbar sind die Gänge oftmals durch einen Durchgang im Straßenhaus. Dieser musste mindestens so breit sein, dass man einen Sarg hindurch tragen konnte. Die Höfe dagegen weiten sich meist um einen zentralen Platz. \nDie meisten der Gänge und Höfe sind frei zugänglich, einige von ihnen sind über Nacht mit Tor oder Tür verschlossen, einige sind nicht zu betreten. ", {PocketPC = 1}),
    Media = zmediaGang1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB165
  })
end
function zitemInfo:OnStadtmauer()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lübecker Stadtbefestigung war eine der ausgedehntesten städtischen Befestigungsanlagen in Norddeutschland und Nordeuropa und ist in Teilen noch heute erhalten. \nMit der Besiedlung des Hügels Bucu zwischen Trave und Wakenitz im Zuge der Stadtgründung Lübecks im 12. Jahrhundert verbunden war die Erkenntnis, dass der Standort des weiter abwärts der Trave in flachem Grünland des Urstromtals gelegenen alten Liubice sich nicht hinreichend würde befestigen lassen. ", {PocketPC = 1}),
    Media = zmediawallanlagen1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB167
  })
end
function zitemInfo:OnStAegidienKirche()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die St.-Aegidien-Kirche, auch Aegidienkirche, ist die kleinste und östlichste Innenstadtkirche, Sie war das Zentrum des Viertels der Handwerker, das auf dem östlichen Abhang des Innenstadthügels in Richtung Wakenitz angesiedelt war. \n1227 wurde St. Aegidien das erste Mal urkundlich erwähnt. Nicht belegbar, aber aufgrund der für Norddeutschland ungewöhnlichen Namensgebung vermutet wird die ursprüngliche Errichtung einer Holzkirche bereits zwischen den Jahren 1172 und 1182 unter Bischof Heinrich I. von Brüssel, der zuvor Abt des Benediktinerklosters St. Aegidien in Braunschweig gewesen war.", {PocketPC = 1}),
    Media = zmediaAegidien1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB169
  })
end
function zitemInfo:OnStAnnenMuseumsquartier()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Museumsquartier St. Annen befindet sich in den Gebäuden des ehemaligen St.-Annen-Klosters, ein ehemaliges Kloster der Augustinerinnen und diente vor allem der Unterbringung unverheirateter Töchter Lübecker Bürger. \nDas Kloster und die dazugehörige Kirche, die aufgrund der beengten Grundstücksverhältnisse einen eigenständigen Baustil aufweist, wurden von 1502 bis 1515 im spätgotischen Stil errichtet. \nAuf Vorschlag des Lübecker Bischofs wurden Kloster und Kirche der Heiligen Anna geweiht. Nur wenige Jahre später wurde das Kloster im Zuge der Reformation wieder geschlossen, 1532 verließen die letzten Nonnen das Kloster. 1601 entstand in den Räumen ein Armenhaus, später wurden weitere Teile als Zuchthaus genutzt, wofür 1778 ein weiterer Flügel, das Spinnhaus, errichtet wurde. Armenpflege und Strafvollzug befanden sich unter einem Dach.", {PocketPC = 1}),
    Media = zmediaStAnnen1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB171
  })
end
function zitemInfo:OnStJakobiKirche()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("St. Jakobi ist eine der fünf evangelisch-lutherischen Hauptpfarrkirchen in der Lübecker Altstadt. \nSie wurde im Jahre 1334 als Kirche der Seefahrer und Fischer geweiht. Ihr Patron ist der Heilige Jakobus der Ältere. Die Kirche, das Heiligen-Geist-Hospital und die benachbarte Gertrudenherberge sind Stationen auf einem Zweig des Jakobswegs von Nordeuropa nach Santiago de Compostela. Seit September 2007 ist die nördliche Turmkapelle der Kirche als Pamir-Kapelle Nationale Gedenkstätte für die zivile Seefahrt. \nHier steht auch das Wrack eines Rettungsbootes der 1957 gesunkenen Viermastbark Pamir, bei deren Untergang 80 der 86 Besatzungsmitglieder ums Leben kamen.", {PocketPC = 1}),
    Media = zmediaJakobi1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB173
  })
end
function zitemInfo:OnTheaterfigurenmuseum()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das TheaterFigurenMuseum Lübeck ist ein Museum für die Geschichte und Gegenwart des Puppentheaters in Europa, Afrika und Asien. Im Museum sind Bühnen und Drehorgeln, Schattenspiele, Schlenkermarionetten und allerlei Kuriositäten ausgestellt. Das TheaterFigurenMuseum befindet sich in fünf historischen Kaufmannshäusern der Backsteingotik. \nDas Museum entstand aus der jahrzehntelangen Sammelleidenschaft von Fritz Fey, der aus einer Puppenspielerfamilie stammt und auf beruflich bedingten Reisen seinem Hobby nachging: Er sammelte Theaterfiguren, begeistert von der Vielfalt ihrer Ausdrucksmöglichkeiten in den verschiedenen Theatertraditionen des internationalen Puppentheaters. \nDas passende Figurentheater ist übrigens gleich ein paar Meter weiter.", {PocketPC = 1}),
    Media = zmediaTheaterfigurenmuseum
  })
end
function zitemInfo:OnWillyBrandtHaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Willy-Brandt-Haus Lübeck ist ein Museum und eine Gedenkstätte für den früheren deutschen SPD-Politiker, Bundeskanzler und Friedensnobelpreisträger Willy Brandt. \nDas Gebäude, eine Außenstelle der Bundeskanzler-Willy-Brandt-Stiftung mit Sitz in Berlin, ist außerdem Sitz des Amts für Denkmalschutz der Hansestadt Lübeck in Schleswig-Holstein.  \nWilly Brandt wurde nicht in dem Gebäude in der Lübecker Innenstadt, sondern im Stadtteil St. Lorenz geboren.", {PocketPC = 1}),
    Media = zmediaWBrandt
  })
end
function zitemInfo:OnZeughaus()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das Zeughaus am Großen Bauhof und dem Domkirchhof in Lübeck wurde 1594 neben dem Lübecker Dom im Stil der Niederländischen Renaissance erbaut. \nAls Zeughaus wird ein Gebäude bezeichnet, in dem Waffen und militärische Ausrüstungsgegenstände gelagert und instand gesetzt wurden.", {PocketPC = 1}),
    Media = zmediazeugenhaus
  })
end
function zitemSilbercache:OnFund()
  zitemSilbercache:MoveTo(zoneFinalSilber)
  zoneFinalSilber.Active = false
  ztaskFindedasSilberFinal.Active = false
  Wherigo.PlayAudio(zmediasoundapplaus)
  Wherigo.MessageBox({
    Text = [[Gut gemacht! Versteck sie wieder so, dass sie kaum zu sehen ist! Jezt ist Endspurt zum Gold! :D]],
    Media = zmediathavorianer
  })
end
function zitemSilbercache:OnHint()
  Wherigo.MessageBox({
    Text = [[Unten, da aber oben und ein wenig Bewegung ist gefragt! :D  Vorsicht bei Glatteis = Rutsche! ]],
    Media = zmediathavorianer
  })
end
function zinputFinal:OnGetInput(input)
  var_Final = input
  if var_Final ~= nil then
    if Wherigo.NoCaseEquals(var_Final, "Drache") or Wherigo.NoCaseEquals(var_Final, "drache") then
      cartILuebeck.Complete = true
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("" .. Player.CompletionCode .. " \n \nZum optionalen Unlocken auf wherigo.com nur die ersten 15 Buchstaben des Codes eingeben! \nDu hast ihn auch jetzt als Gegenstand im Inventar. \n \nDer Code ist user-bezogen. Wurde der Cache als Gruppe gemacht, muß man die 3. Option nehmen und den entsprechenden User nennen!", {PocketPC = 1}),
        Media = zmedialogo,
        Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB180
      })
      zitemUnlockCode.Description = WWB_multiplatform_string("" .. Player.CompletionCode .. "")
      zitemUnlockCode:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = [[Das war leider nicht korrekt. Versuch es anders.]],
        Media = zmediathavorianer,
        Buttons = {
          "Unlock-Code"
        },
        Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB181
      })
    end
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB3(action)
  zoneBuddenbrookhaus.Visible = true
  zitemInfo.Commands.Buddenbrookhaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB4(action)
  if action == "Button1" then
    zoneBurgkloster.Visible = true
    zitemInfo.Commands.Burgkloster.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nachdem die Dänen 1201 Lübeck erobert hatten, residierte hier als Statthalter Albrecht von Orlamünde, der Neffe des dänischen Königs. 1221 wurden Burg und Domstadt durch eine gemeinsame Ummauerung mit der bürgerlichen Stadt vereint. \nAls Albrecht in der Schlacht bei Mölln gefangengenommen worden war, nutzten die Lübecker die Gunst der Stunde, ließen sich 1226 das Barbarossa-Privileg durch einen Reichsfreiheitsbrief bestätigen und rissen die landesherrliche Burg nieder, um einem möglichen erneuten Anspruch auf die Stadtherrschaft zuvorzukommen. \nAls Dank für den Sieg über die Dänen, der auf die Hilfe der Heiligen zurückgeführt wurde, errichteten die Lübecker anstelle der Burg ein Kloster und übergaben es 1229 dem Dominikanerorden. Damit erhielt nach den Franziskanern ein zweiter Bettelorden einen Sitz in Lübeck.", {PocketPC = 1}),
      Media = zmediaburkloster1,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB5
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB5(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Mit der Einführung der Reformation 1531 wurde das Kloster aufgelöst. Im Gebäude wurde ein Armenhaus eingerichtet. Die Klosterkirche hatte schon immer statische Probleme. 1589 stürzte der Kanzelpfeiler ein, 1635 ein Stück Gewölbe, 1635 der erste Nordpfeiler und mit ihm das gesamte erste westliche Gewölbejoch. Als dann 1818 der zweite südliche Langhauspfeiler mit dem Gewölbe einstürzte, entschloss sich der Rat der Stadt mit Zustimmung der Bürgerschaft, die seit 1806 nicht mehr benutzte Kirche abzureißen. Lediglich die Nordwand, die an die Klosterbauten anschloss, und die darin eingebauten Kapellen blieben erhalten.", {PocketPC = 1}),
    Media = zmediaburkloster2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB6
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB6(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("An der Stelle der abgebrochenen Kirche entstand 1874-76 eine Schule. Von 1893-96 wurde das Burgkloster baulich stark verändert. In dieser Form diente das Burgkloster bis 1962 als Gerichtsgebäude. \nSeit 1976 wurden die mittelalterlichen Bauteile wieder freigelegt, das Gebäude wurde zu Museumszwecken umgestaltet und mit einer modernen Eingangshalle versehen. \nIm Zuge der Errichtung des Europäischen Hansemuseums wurden die Räumlichkeiten des Burgklosters in das 2015 eröffnete neue Museum einbezogen.", {PocketPC = 1}),
    Media = zmediaburkloster3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB7
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB7(action)
  zoneBurgkloster.Visible = true
  zitemInfo.Commands.Burgkloster.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB8(action)
  if action == "Button1" then
    zoneBurgtor.Visible = true
    zitemInfo.Commands.Burgtor.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das heutige Burgtor wurde 1444 anstelle eines romanischen Tores innerhalb einer Befestigungsanlage erbaut. An den anschließenden Gebäuden, Marstall wie Zöllnerhaus, finden sich Terrakottafriese.  \nIm 19. Jahrhundert wurde in der Lübecker Bürgerschaft erwogen, das Burgtor abzureißen, die Älterleute der zwölf bürgerlichen Kollegien wollten dort Bauplatz schaffen. Die Bürgerschaft lehnte diesen Vorschlag schließlich einstimmig ab. Man würde ein altertümliches Gebäude zerstören und das sei nicht tragbar. Stattdessen entschied man sich, den Durchgang durch das Burgtor zu erweitern. 1850 wurde der westliche Durchgang geschaffen, 1875 ein weiterer. Ende der 1920er kam ein letzter Durchgang hinzu, so dass es heute vier Durchgänge gibt.", {PocketPC = 1}),
      Media = zmediaburgtor1,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB9
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB9(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das heute erhaltene Tor war das innere von ursprünglich drei hintereinander gelegenen Toren, deren Modelle in kleinen Schaukästen am früheren Standort besichtigt werden können. \nDas Tor etwa 50m östlich wurde allerdings erst 1903 in die Stadtmauer gebrochen.", {PocketPC = 1}),
    Media = zmediaburgtor3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB10
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB10(action)
  zoneBurgtor.Visible = true
  zitemInfo.Commands.Burgtor.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB11(action)
  if action == "Button1" then
    zoneDom.Visible = true
    zitemInfo.Commands.Dom.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der damals romanische Dom wurde etwa 1230 fertiggestellt und mehrmals umgebaut und erweitert. \nDie romanische Apsis wurde nach Fertigstellung des gotischen Chors bis auf die Fundamente abgerissen. Der Unterschied zwischen den beiden Abschnitten ist auch für Laien deutlich erkennbar: Der ältere Bauteil wird von massiven, rechteckigen Pfeilern getragen, der jüngere Chor von schlanken, runden Säulen. \n \nBei dem schweren Luftangriff in der Nacht zum Palmsonntag 28./29.03.1942, bei dem 1/5 der Innenstadt zerstört wurde, stürzte der östliche Teil ein und zerstörte den Hochaltar von 1696. \nDer Brand des benachbarten Dommuseums griff auf den Dachstuhl über; gegen Mittag stürzten die Turmhelme ab. \nEs konnten jedoch Teile der Innenausstattung wie das Triumphkreuz und fast alle mittelalterlichen Flügelaltäre gerettet werden.", {PocketPC = 1}),
      Media = zmediaDom2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB12
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB12(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als Kriegsfolge brach 1946 der ungesicherte Giebel des nördlichen Querschiffs zusammen, begrub die Paradiesvorhalle unter sich und zerstörte sie fast völlig. \n \nDer Wiederaufbau dauerte einige Jahrzehnte, da die Prioritäten hier eher auf den Wiederaufbau der Marienkirche gelegt wurden.  \nZunächst wurden die Türme und der westliche Teil der Kirche instand gesetzt, es folgte dann der Ostchor und zuletzt die Paradies-Vorhalle an der Nordseite des Doms. \nDie Turmhelme erhielten wie alle nach dem Krieg wiederaufgebauten Turmhelme der Lübecker Hauptkirchen eine Unterkonstruktion aus Leichtbeton, nachdem zunächst die mittelalterlichen Fundamente der beiden Türme hydraulisch angehoben und verstärkt worden waren. \nDer Wiederaufbau wurde erst 1982 abgeschlossen.", {PocketPC = 1}),
    Media = zmediaDom3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB13
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB13(action)
  zoneDom.Visible = true
  zitemInfo.Commands.Dom.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB14(action)
  if action == "Button1" then
    zoneDunkelundHellgruenerGang.Visible = true
    zitemInfo.Commands.DunkelundHellgrnerGang.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Name Dunkelgrüner Gang erinnert an die Gärten und ehemaligen Wiesenflächen. \nDie im Süden gelegenen Gangteile wurden wegen ihrer lichten Bebauung Hellgrüner Gang genannt. \nDie Geschichte dieses Viertels geht zurück bis ins Jahr 1357, die erste Bebauung wurde um 1587 unternommen. Allmählich bildete sich eine kleine Kolonie in der Hafengegend, dicht am Wasser und nicht fern von der Hauptstraße nach Mecklenburg. \nAm 23. April 1596 erschütterte eine gewaltige Gasexplosion das Gangviertel, die sogar die Burgkirche ins Wanken brachte. Ein Spanier hatte heimlich ungekörntes Schießpulver gelagert, das durch Selbstentzündung den größten Teil des Gangviertels zerstörte. \nDie heutige Bebauung des Viertels stammt aus der Zeit der großen Explosion, also nach dem 17. Jahrhundert.", {PocketPC = 1}),
      Media = zmediaGangGruen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB15
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB15(action)
  zoneDunkelundHellgruenerGang.Visible = true
  zitemInfo.Commands.DunkelundHellgrnerGang.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB16(action)
  zoneFeuerschiffFehmarnbelt.Visible = true
  zitemInfo.Commands.FeuerschiffFehmarnbelt.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB20(action)
  if action == "Button1" then
    zoneFuechtingshof.Visible = true
    zitemInfo.Commands.Fchtingshof.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Um die Ärmsten der Armen vor Mietwucher zu schützen, gründeten angesehene Lübecker damals Stiftungen wie zum Beispiel den Füchtingshof, um nur den berühmtesten zu nennen. Der Ratsherr Johann Füchting bestimmte 1636 ein Drittel seines Erbes zum Nutzen und Besten der Armen. Als Gegenleistung erbat sich der Stifter oft das Gebet nach seinem Ableben. Das sollte ihm dann einen guten Platz im Himmel sichern. Noch heute sind 28 Wohnungen günstig an Pensionärinnen, oftmals auch Witwen und Lübecker Kaufleute, vermietet. \nDas Innere des Füchtingshofs diente Friedrich Wilhelm Murnau für seinen Film Nosferatu - Eine Symphonie des Grauens bei seinen Lübecker Außenaufnahmen in zwei Szenen als Kulisse.", {PocketPC = 1}),
      Media = zmediaGangFuechting2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB21
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB21(action)
  zoneFuechtingshof.Visible = true
  zitemInfo.Commands.Fchtingshof.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB22(action)
  zoneGuenterGrassHaus.Visible = true
  zitemInfo.Commands.GuenterGrassHaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB23(action)
  if action == "Button1" then
    zoneHaasenhof.Visible = true
    zitemInfo.Commands.Haasenhof.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der jüngste der großen Stiftshöfe, gestiftet von Elisabeth Haase, der Witwe des Weinhändlers Johann Haase, im Jahre 1725. Sie ließ 13 Wohnungen in einstöckigen Häusern für Witwen und ledige Frauen bauen. \nDer liebevoll restaurierte Hof wurde oft als Filmkulisse genutzt, beispielsweise für einen Weihnachtsfilm mit Heinz Rühmann und Sir Peter Ustinow. ", {PocketPC = 1}),
      Media = zmediaGangHaasen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB24
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB24(action)
  zoneHaasenhof.Visible = true
  zitemInfo.Commands.Haasenhof.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB25(action)
  if action == "Button1" then
    zonehalbrunderWehrturm.Visible = true
    zitemInfo.Commands.halbrunderWehrturm.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Hügel Bucu war zuvor bereits Standort einer wendischen Burg gewesen und wies topografisch bessere Voraussetzungen der Befestigung auf. Die Befestigung der Stadtgründung des 12. Jahrhunderts bestand aus der Lübecker Burg, die nach der Schlacht von Bornhöved zum Burgkloster wurde und einer Stadtmauer und vier Stadttoren, von denen das Burgtor und das Holstentor in ihren späteren baulichen Überformungen heute noch zeugen. \nDie Stadtmauer umgab die gesamte Altstadt. An der Trave war sie in regelmäßigen Abständen mit kleinen Toren versehen, um den Warentransport zwischen Hafen und Stadt zu ermöglichen. Am nördlichen Rand der Altstadt (entlang der Straßen An der Mauer und Wakenitzmauer) sind noch Reste der mittelalterlichen Stadtmauer erhalten, zum Teil in im 17. Jahrhundert errichteten Häusern verbaut.", {PocketPC = 1}),
      Media = zmediawallanlagen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB26
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB26(action)
  zonehalbrunderWehrturm.Visible = true
  zitemInfo.Commands.halbrunderWehrturm.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB27(action)
  if action == "Button1" then
    zoneHansemuseum.Visible = true
    zitemInfo.Commands.Hansemuseum.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Umfangreiche archäologische Funde haben zu einer weiteren Verschiebung der Eröffnung bis zum Mai 2015 geführt. Die bei der Baufeldfreimachung entdeckten archäologischen Funde wurden durch eine begehbare Grabungsstätte in den Rundgang einbezogen. Anhand der Ausgrabungen werden 1200 Jahre Geschichte gezeigt. \nDas Hansemuseum war im April 2015 Tagungsort der Außenminister der G7-Staaten. Offiziell eröffnet wurde es am 27. Mai 2015 von Bundeskanzlerin Angela Merkel. Der Museumsbetrieb wurde am 30. Mai 2015 aufgenommen.", {PocketPC = 1}),
      Media = zmediaHansemuseum2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB28
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB28(action)
  zoneHansemuseum.Visible = true
  zitemInfo.Commands.Hansemuseum.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB29(action)
  if action == "Button1" then
    zoneHeiligenGeistHospital.Visible = true
    zitemInfo.Commands.HeiligenGeistHospital.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Bewohner des Hospitals waren einer klosterähnlichen Regel unterworfen, doch erhielten sie Nahrungsmittel und seit dem 17. Jahrhundert acht Mal im Jahr ein warmes Bad. \nWährend der Reformationszeit wurde das Hospital in ein weltliches Altenheim umgewandelt, welches bis heute erhalten blieb. Ursprünglich standen die Betten der Hospitalbewohner in der Halle. 1820 wurden vier Quadratmeter große, hölzerne Kammern gebaut, getrennt nach Geschlechtern. Die Abteilungen sind nach oben offen. Es gab zusätzlich eine kleine Bücherei und Apotheke. An den Türen der Kammern kann man noch heute Namen und Nummern der damaligen Bewohner sehen. Bis 1970 waren die Kammern bewohnt. \nDas Heiligen-Geist-Hospital ist eine Stiftung des öffentlichen Rechts und wird treuhänderisch von der Hansestadt Lübeck verwaltet.", {PocketPC = 1}),
      Media = zmediahospital2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB30
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB30(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Raumbestimmend in der Kirchenhalle sind die beiden großformatigen mittelalterlichen Wandgemälde an der Nordseite, die auf ca. 1320/1325 datiert werden. Das westliche Bogenfeld zeigt eine komplexe typologische Szene: den salomonischen Thron. \nNach jahrhundertelanger Übermalung wurden die Wandmalereien 1866 wiederentdeckt. Von 1990 - 95 erfolgte eine eingehende Untersuchung im Rahmen eines Forschungsprojektes des Bundesministeriums für Forschung und Technologie (BMFT). Bis 1999 wurden beide Malereien nach den dabei gewonnenen Erkenntnissen konserviert. \nFür das Heiligen-Geist-Hospital sind zwölf mittelalterliche Grabplatten überliefert, von denen noch acht erhalten sind. Die restlichen sind definitiv abgängig.", {PocketPC = 1}),
    Media = zmediahospital3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB31
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB31(action)
  zoneHeiligenGeistHospital.Visible = true
  zitemInfo.Commands.HeiligenGeistHospital.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB32(action)
  if action == "Button1" then
    zoneHolstentor.Visible = true
    zitemInfo.Commands.Holstentor.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Über dem Durchgang ist auf der Stadt- wie auf der Feldseite je eine Inschrift angebracht. Auf der Stadtseite lautet die Inschrift S.P.Q.L., eingerahmt von den Jahreszahlen 1477 und 1871; ersteres war das vermeintliche Datum der Erbauung (korrektes Datum ist allerdings 1478), letzteres das Datum der Restaurierung sowie der Gründung des Deutschen Reiches. Diese Inschrift hatte das römische S.P.Q.R. (lateinisch Senatus populusque Romanus Senat und Volk Roms) zum Vorbild und sollte entsprechend für Senatus populusque Lubecensis stehen. Sie wurde allerdings erst 1871 angebracht.", {PocketPC = 1}),
      Media = zmediaholstentor1,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB33
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB33(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Eine andere Inschrift befindet sich auf der Feldseite. Dort steht CONCORDIA DOMI FORIS PAX (Eintracht innen, draußen Friede). Auch dieser Schriftzug stammt von 1871 und ist eine verkürzte Form der Inschrift, die zuvor auf dem (nicht erhaltenen) Vortor gestanden hatte: Concordia domi et foris pax sane res est omnium pulcherrima (Eintracht innen und Friede draußen sind in der Tat für alle am besten).", {PocketPC = 1}),
    Media = zmediaholstentor3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB34
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB34(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Durchgang war früher zur Feldseite mit zwei Torflügeln versehen, die nicht erhalten sind. Ein Fallgatter wurde erst 1934 angebracht und entspricht nicht den ursprünglichen Sicherungsanlagen. An dieser Stelle befand sich einst ein so genanntes Orgelwerk, bei dem die Eisenstangen einzeln und nicht als Ganzes heruntergelassen wurden. So war es möglich, alle Stangen bis auf eine oder zwei bereits zu senken und dann abzuwarten, um den eigenen Männern noch ein Hindurchkommen zu ermöglichen oder durch die Verengung des Durchganges ein Einfallen feindlicher Kavallerie oder Fahrzeuge unter geringstem Aufwand zu verhindern.", {PocketPC = 1}),
    Media = zmediaholstentor4,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB35
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB35(action)
  zoneHolstentor.Visible = true
  zitemInfo.Commands.Holstentor.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB36(action)
  if action == "Button1" then
    zoneKaisertor.Visible = true
    zitemInfo.Commands.Kaisertor.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Dieser Torausgang wurde im Gegensatz zu den Mühlentoren wenig genutzt, so dass ihn der Rat um 1500 zumauern ließ. Dies geschah nicht, wie eine Sage glaubhaft machen will, weil Kaiser Karl IV. das Tor 1375 durchschritt und nach ihm keiner mehr hindurchschreiten sollte. \nDer eigentliche Grund sei ein Streit zwischen dem Rat und den Domherren gewesen, berichtet der Chronist Hans Regkmann um 1540. Die Domherren wollten den Weg über den Mühlendamm verbieten oder aber beim Passieren Zoll erheben. Trotz eines Einspruchs des Senats hätte das Domkapitel auf seinem Anliegen bestanden, das Tor zugemauert und die Brücke abgebrochen.", {PocketPC = 1}),
      Media = zmediakaisertor2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB37
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB37(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als im 17. Jahrhundert die Wehranlagen verstärkt wurden, legte der Wallbaumeister die weit vorspringende Bastion Kaiser vor den Turm. In den ausgebauten Kasematten wurde Pulver gelagert. Den Turm selbst, der zur Verteidigung gegen neuzeitliche Geschütze sinnlos geworden war, brach man bis auf einen Stumpf ab, der den Wall vier Meter überragte. Im 19. Jahrhundert wurde ihm ein Obergeschoss aufgesetzt. Hier zog 1826 die Navigationsschule, die spätere Seefahrtschule ein. Als 1897 beim Bau des Elbe-Lübeck-Kanals die Bastion Kaiser durchschnitten und dabei die Zwingerruine freigelegt wurde, öffnete man auch das zugemauerte Tor und machte es durchgängig. Am 26. August 1900 durchschritt Kaiser Wilhelm II. das Kaisertor, um an Bord der Lubeca auf der Fahrt zum Stadthafen die Schifffahrt auf dem Elbe-Lübeck-Kanal zu eröffnen.", {PocketPC = 1}),
    Media = zmediakaisertor3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB38
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB38(action)
  zoneKaisertor.Visible = true
  zitemInfo.Commands.Kaisertor.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB39(action)
  if action == "Button1" then
    zoneKatharinenkirche.Visible = true
    zitemInfo.Commands.Katharinenkirche.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Noch zu Lebzeiten des heiligen Franz von Assisi erhielten die Franziskaner im Jahre 1225 ein Grundstück zum Bau von Kloster und Kirche. \nVermutlich um 1303, wurde zunächst der Ostteil mit Chorraum und Querschiff neu im Stil der Backsteingotik erbaut. 1329 wurde das Chorgestühl eingebaut, dann ab 1335 das Langhaus vollendet. Später kamen noch Kapelleneinbauten und -anbauten hinzu.", {PocketPC = 1}),
      Media = zmediaKatharinenkirche2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB40
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB40(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("In der Reformation wurde das Katharinenkloster 1531 zu einer Lateinschule. \nWährend der französischen Besetzung Lübecks (1806-1813) wurde die Kirche profaniert und als Pferdestall und Lazarett zweckentfremdet. \nNachdem zahlreiche andere Innenstadtkirchen beim Bombenangriff auf Lübeck am Palmsonntag 1942 ausgebrannt waren, wurde St. Katharinen vorübergehend wieder für regelmäßige Gottesdienste hergerichtet. \nIn der Museumskirche ist auch ein monumentaler Gipsabguss der St.-Jürgen (St.-Georg)-Gruppe aus der Nikolaikirche in Stockholm. Die reiche Ausmalung des 14. Jahrhunderts ist nur teilweise wieder freigelegt.", {PocketPC = 1}),
    Media = zmediaKatharinenkirche3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB41
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB41(action)
  zoneKatharinenkirche.Visible = true
  zitemInfo.Commands.Katharinenkirche.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB42(action)
  if action == "Button1" then
    zoneKranenKonvent.Visible = true
    zitemInfo.Commands.KranenKonvent.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die beiden Seitenflügel auf der Hofseite sind über die Gartenanlagen des Grundstücks der ehemaligen Niederlassung des Deutschen Ordens (1268-1806) rechts neben dem Kranen-Konvent zugänglich und stammen aus dem 14. bis 16. Jahrhundert. Der Kranen-Konvent wurde ab Ende des 18. Jahrhunderts als Armenhaus für Frauen und Siechenhaus genutzt, im 20. Jahrhundert als Altenheim und Beratungsstelle des Sozialamtes und jetzt von der benachbarten Ernestinenschule. Der Keller wurde nach archäologischen Grabungen und der erforderlichen denkmalpflegerischen Grundsanierung zu einer Mensa umgebaut.", {PocketPC = 1}),
      Media = zmediaKKonvent2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB43
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB43(action)
  zoneKranenKonvent.Visible = true
  zitemInfo.Commands.KranenKonvent.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB44(action)
  if action == "Button1" then
    zoneLISAvonLuebeck.Visible = true
    zitemInfo.Commands.LISAvonLbeck.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Weil noch nie eine vollständige Kraweel ausgegraben worden war, musste der Bauplan in Teilstücken erstellt werden. Das Schiff wurde eine authentische Rekonstruktion, die allerdings einen zusätzlichen Dieselmotor zur Fahrt ohne Segelleistung besitzt. \nAm 27. März 2004 wurde das Schiff zu Wasser gelassen; die Jungfernfahrt fand im April 2005 statt. Am Karfreitag 2006, dem 14. April, startete die Lisa von Lübeck zu ihrem ersten Auslandstörn. Ziel der Reise war die Hansestadt Danzig an der polnischen Ostseeküste, mit Zwischenstopps in Stralsund und Kolberg. 2013 wurde bei einer Kollision der vordere Teil beschädigt.", {PocketPC = 1}),
      Media = zmediaLisa2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB45
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB45(action)
  zoneLISAvonLuebeck.Visible = true
  zitemInfo.Commands.LISAvonLbeck.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB46(action)
  if action == "Button1" then
    zoneLoewenapotheke.Visible = true
    zitemInfo.Commands.Lwenapotheke.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bodenfliese aus der Löwenapotheke (14. Jahrhundert) \n \n1812 - 1816 arbeitete Friedlieb Ferdinand Runge hier, er entdeckte 1834 das Anilin und das Phenol, unentbehrliche Grundstoffe der heutigen Arzneimittel. \n \nDie Bewahrung dieses Hauses vor dem 1899 geplanten Abriß ist der Initiative des Dichters und pazifistischen AnarchistenErich Mühsam zu verdanken, welcher 1934 im KZ Oranienburg ermordet wurde.", {PocketPC = 1}),
      Media = zmediaLoewenapotheke2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB47
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB47(action)
  zoneLoewenapotheke.Visible = true
  zitemInfo.Commands.Lwenapotheke.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB48(action)
  if action == "Button1" then
    zoneMarienkirche.Visible = true
    zitemInfo.Commands.Marienkirche.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("In der Nacht zum Palmsonntag vom 28. zum 29. März 1942 brannte die Marienkirche bei dem Luftangriff auf Lübeck, bei dem ein Fünftel der Lübecker Innenstadt zerstört wurde, fast völlig aus. \nDabei wurde, neben zahlreichen anderen Kunstwerken, auch die berühmte Totentanzorgel vernichtet, auf der unter anderem Dietrich Buxtehude und mit großer Wahrscheinlichkeit Johann Sebastian Bach gespielt hatten. \nWährend des durch den Bombenangriff ausgelösten Brandes am Palmsonntag 1942 sollen die Kirchenglocken durch den Luftzug noch einmal geläutet haben, bevor sie herabstürzten. Die Reste zweier Glocken, der ältesten Glocke von 1508, der Sonntagsglocke und der Pulsglocke von 1668, wurden als Mahnmal in der ehemaligen Schinkel-Kapelle unter dem Süderturm erhalten.", {PocketPC = 1}),
      Media = zmediaMarien2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB49
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB49(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der eigentliche Wiederaufbau begann 1947 und wurde zwölf Jahre später größtenteils abgeschlossen. Dabei wurde aufgrund der Erfahrungen der Brandnacht darauf verzichtet, die Tragwerkskonstruktion des Daches und der Turmhelme wieder aus Holz auszuführen. Stattdessen sind alle nach dem Krieg wiederaufgebauten Turmspitzen von Lübecker Kirchen in einem speziell entwickelten Verfahren in Leichtbetonbauweise unter der Kupfereindeckung ausgeführt. \nDer vergoldete Dachreiter, der 30 Meter über das Hochschiffdach herausragt, wurde 1980 nach alten Zeichnungen und Fotografien neu geschaffen. \nDer südlich der Kirche gelegene Marienkirchhof vermittelt durch seine Abschlüsse, die Nordfassade des Rathauses, das Kanzleigebäude sowie das Marienwerkhaus den Eindruck des mittelalterlichen Stadtbildes.", {PocketPC = 1}),
    Media = zmediaMarien3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB50
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB50(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ein großer Granitquader rechts neben dem Eingang wurde nicht etwa von der Kirchenbauhütte dort zwischengelagert oder vergessen, sondern soll von des Teufels Hand dort hingekommen sein. Der Sage nach soll der Teufel an der Errichtung der Kirche beteiligt gewesen sein, in dem Glauben, dass es sich um den Bau eines Wirtshauses handele. An diese Geschichte erinnert eine von Rolf Goerler geschaffene Teufelsfigur im Marienkirchhof. \nIm Westen und Norden der Kirche zeigt sich der Kirchhof als freier Platz, die mittelalterliche, kleinteilige Bebauung wurde abgeräumt. Allein an der Ecke Schüsselbuden zur Mengstraße erinnern die Fundamentsteine an die Kapelle Maria am Stegel (1415). Gegen ihren Wiederaufbau nach dem Krieg wurde Ende der 50er Jahre entschieden und das noch stehende Außenmauerwerk der Ruine abgetragen.", {PocketPC = 1}),
    Media = zmediaMarien4,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB51
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB51(action)
  zoneMarienkirche.Visible = true
  zitemInfo.Commands.Marienkirche.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB52(action)
  if action == "Button1" then
    zoneMarkt.Visible = true
    zitemInfo.Commands.Marktplatz.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Trotz der Kriegszerstörungen durch den Luftangriff auf Lübeck am 29. März 1942 und einer Verkleinerung nach Süden beim Wiederaufbau der Innenstadt zeigt der Markt sich vor der mächtigen Kulisse der Marienkirche fast noch wie auf alten Ansichten. Der Kaak, eine mittelalterliche Gerichtslaube und Pranger, wurde nach dem Krieg 1952 abgebrochen und eingelagert; 1986 wurde er etwas nach Norden versetzt unter Verwendung alter Bauteile wiederaufgebaut.", {PocketPC = 1}),
      Media = zmediaMarkt2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB53
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB53(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der 1873 erbaute Marktbrunnen wurde 1934 abgerissen, da der Markt bis in die frühen 1980er Jahre als Parkplatz benutzt wurde. \nDer Kaak, eine mittelalterliche Gerichtslaube und Pranger, wurde nach dem Krieg 1952 abgebrochen und eingelagert; 1986 wurde er etwas nach Norden versetzt unter Verwendung alter Bauteile wiederaufgebaut.", {PocketPC = 1}),
    Media = zmediaMarkt3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB54(action)
  zoneMarkt.Visible = true
  zitemInfo.Commands.Marktplatz.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB55(action)
  if action == "Button1" then
    zoneMarstall.Visible = true
    zitemInfo.Commands.Marstall.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Marstallhof war vom Mittelalter bis in die Neuzeit die Wache der Lübecker Ordnungshüter, im Mittelalter Reitendiener genannt. Der Marstall unterstand jeweils zwei Ratsherren, den Stallherren oder Marstallherren und wurde unter ihrer Aufsicht von einem Hauptmann geführt. Der Marstall umfasste daher neben Stallungen für die Pferde auch eine Schmiede und bis zur Errichtung der JVA Lauerhof 1909 auch das Gefängnis der Stadt. Während die Marstallschmiede mit ihrer Renaissancefassade an der Großen Burgstraße für den neugotischen Neubau des Gerichtsgebäudes 1894 abgerissen wurde, ist das Torgebäude über der Einfahrt zum Marstallhof erhalten geblieben. Die weiter erhaltenen Gebäude des Marstalls schließen westlich an das Burgtor an.", {PocketPC = 1}),
      Media = zmediaMarstall2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB56
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB56(action)
  zoneMarstall.Visible = true
  zitemInfo.Commands.Marstall.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB57(action)
  zoneMuseumBehnhausDraegerhaus.Visible = true
  zitemInfo.Commands.MuseumBehnhausDrgerhaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB58(action)
  zoneMuseumshafen.Visible = true
  zitemInfo.Commands.Museumshafen.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB59(action)
  if action == "Button1" then
    zoneNiederegger.Visible = true
    zitemInfo.Commands.Niederegger.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Johann Georg Niederegger wurde 1777 in Ulm geboren. In Langenau absolvierte er eine Konditorlehre. Danach zog er 1803 nach Lübeck und arbeitete in der Konditorei Maret am Markt. Nach dem Tod des Besitzers übertrug dessen Witwe Niederegger das Geschäft, der somit am 1. März 1806 sein eigenes Unternehmen gründen konnte.  Kurz danach richtete Napoleon die Kontinentalsperre ein (Handelsembargo), so dass Niederegger die Rohstoffe Mandeln aus Sizilien und Zucker ausgingen. Zwischen 1811 und 1812 kam die Produktion gänzlich zum Erliegen. Zwischen 1812 und 1814 konnte der Nachschub durch Schmuggel via Helgoland gesichert werden.", {PocketPC = 1}),
      Media = zmediaNiederegger1,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB60
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB60(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("1873 wurde das Marzipan von Niederegger auf der Wiener Weltausstellung prämiert. \n1908 ernannte Kaiser Wilhelm II das Unternehmen zum Hoflieferanten. \nIm zweiten Obergeschoss des Cafes in der Breiten Straße befindet sich seit 1999 ein Marzipanmuseum mit historischen Holzformen für die Herstellung von reliefartigen Marzipanblöcken und einer Gruppe historischer Figuren in Menschengröße aus Marzipan.  \nAm 1. März 2006 feierte die Fa. Niederegger ihr 200-jähriges Bestehen. ", {PocketPC = 1}),
    Media = zmediaNiederegger3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB61
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB61(action)
  zoneNiederegger.Visible = true
  zitemInfo.Commands.Niederegger.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB62(action)
  if action == "Button1" then
    zonePetrikirche.Visible = true
    zitemInfo.Commands.Petrikirche.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Im 15. Jahrhundert erfolgte der Ausbau zur heutigen Erscheinung: Eine gotische, fünfschiffige Hallenkirche aus Backsteinen mit fünf Jochen. Damit wurde die Petrikirche eine der wenigen existierenden fünfschiffigen Kirchen. \nDie Reformation hielt in Lübeck 1529/30 einzug und die Petrikirche wurde evangelisch. \nWährend des Luftangriffs auf Lübeck am Palmsonntag 1942 brannte die Petrikirche völlig aus. Das Dach, der Turmhelm und die reiche Innenausstattung wurden zerstört. \nDie notdürftig abgedeckte Kirche diente der Lübecker Kirchbauhütte zunächst als Lapidarium, in dem geborgene skulpturale Fragmente aus allen kriegszerstörten Lübecker Kirchen zwischengelagert wurden. Erst 1987 war die Kirche äußerlich wieder vollständig aufgebaut.", {PocketPC = 1}),
      Media = zmediaPetri2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB63
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB63(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Turm ist 108m hoch und kann seit 1908 bestiegen werden. Per Aufzug kann die in 50 m Höhe gelegene Aussichtsplattform erreicht werden. Von dort bietet sich ein Rundblick über die gesamte Altstadt Lübecks und das Umland bis hin zur Lübecker Bucht. \nDie beiden vor dem Hauptportal stehenden Glocken gehörten ursprünglich Danziger Kirchen und waren im Zweiten Weltkrieg zur Rohstoffgewinnung auf den Hamburger Glockenfriedhof gekommen. Diese Glocken sind dem Einschmelzen entgangen. Nach 1945 wurden sie (wie auch die Glocken des Glockenspiels der Marienkirche und die Paramente der Danziger Marienkirche, die heute im St. Annen-Museum zu sehen sind) nach Lübeck gebracht, weil hier viele Flüchtlinge aus Danzig eine neue Heimat gefunden hatten.", {PocketPC = 1}),
    Media = zmediaPetri3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB64
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB64(action)
  zonePetrikirche.Visible = true
  zitemInfo.Commands.Petrikirche.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB65(action)
  if action == "Button1" then
    zonePuppenbruecke.Visible = true
    zitemInfo.Commands.Puppenbrcke.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Rat beschloss 1774 ein Übriges zu tun und die Brücke mit acht Statuen (vier männliche - Merkur, Römischer Krieger, Flussgott und Neptun - und vier weibliche - Friede, Eintracht, Vorsicht und Freiheit) und vier Vasen (Ackerbau, Fleiß, Sparsamkeit sowie die Freien Künste) aus Sandstein zu schmücken. \nSo erhielt sie im Volksmund schnell den Namen Puppenbrücke. \n1907 erbaute man den heute landesweit bekannten Neubau der Puppenbrücke. Anlass war die Verlegung des Bahnhofs und das steigende Verkehrsaufkommen. Die alte Brücke wurde einfach zu schmal. Das Skulpturenprogramm wurde in neuer Anordnung komplett übernommen.", {PocketPC = 1}),
      Media = zmediapuppen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB66
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB66(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im 1908 wurde die Brücke vollendet. Vier Reliefs wurden von dem Berliner Bildhauer Taschner für die Bogenzwickel an der Außenseite der Brücke geschaffen. Sie stellen die vier Elemente dar - Feuer und Wasser auf der Süd-, Luft und Erde auf der Nordseite der Brücke. \nAuf der Puppenbrücke sind allerdings nicht die Original-Statuen zu sehen. Diese stehen seit 1984 im St.-Annen-Museum, wo sie vor den Einflüssen der Luftverschmutzung geschützt sind. Das Material für die Statuen stammt aus einem sächsischen Steinbruch. \nDie Kopien wurden mit Fehlern erschaffen, Frieden fehlt der Zweig und der Vorsicht wurden beide Arme amputiert.", {PocketPC = 1}),
    Media = zmediapuppen3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB67
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB67(action)
  zonePuppenbruecke.Visible = true
  zitemInfo.Commands.Puppenbrcke.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB68(action)
  if action == "Button1" then
    zoneRathaus.Visible = true
    zitemInfo.Commands.Rathaus.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Ratskeller zu Lübeck unter dem Rathaus ist als Ratskeller seit 1220 belegt. \nDie runden Löcher in den Ziermauern der Fassade zum Markt hin haben den Zweck, den Wind zu brechen und die Fassade vor zu starkem Winddruck zu schützen. Die kleineren runden Löcher zur Marienkirche hin dienen nur der Zierde.", {PocketPC = 1}),
      Media = zmediaRathaus2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB69
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB69(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Von der Breiten Straße aus sieht man die Renaissancetreppe. Sie führte zu der in selbiger Zeit gestalteten so genannten Kriegsstube, dem dann prächtigsten Raum des Rathauses. Der Name des Saales zeigt, dass die Hanse nicht nur Einfluss auf die Wirtschaft hatte, sondern auch auf die Politik und oftmals über Krieg und Frieden entschied. \nDie Kriegsstube wurde im März 1942 beim ersten schweren Luftangriff auf Lübeck zerstört und ist heute kein Repräsentationsraum mehr.", {PocketPC = 1}),
    Media = zmediaRathaus3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB70
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB70(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im Rathaus tagte der Rat der Hansestadt auch als Gericht: der Oberhof Lübeck war bis 1820 Appellationsgericht für Entscheidungen aus anderen Städten, die dem Lübschen Rechtskreis angehörten. \nDie Türen zum ehemaligen Gerichtssaal im Erdgeschoss sind verschieden hoch. Freigesprochene Angeklagte durften das Gericht durch die hohe Tür verlassen, verurteilte Angeklagte mussten durch die niedrige Tür gehen und dabei den Kopf senken.", {PocketPC = 1}),
    Media = zmediaRathaus4,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB71
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB71(action)
  zoneRathaus.Visible = true
  zitemInfo.Commands.Rathaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB72(action)
  if action == "Button1" then
    zoneSalzspeicher.Visible = true
    zitemInfo.Commands.Salzspeicher.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Speichergebäude dienten ursprünglich der Lagerung des aus Lüneburg über die Alte Salzstraße und später über den Stecknitz-Kanal herbeigeführten Salzes sowie des aus der Saline Oldesloe gewonnenen und mit Lastkähnen auf der Trave herangebrachten Salzes, das von Lübeck als Grundlage seines damaligen Reichtums nach ganz Skandinavien ausgeführt wurde.  \nDas Salz wurde vornehmlich zum Konservieren von in Norwegen und Schonen gefangenem Fisch benötigt und ermöglichte so den Heringshandel als Fastenspeise mit dem Binnenland. Die Lage an der Holstenbrücke über die Trave als der ältesten festen Lübecker Brücke markierte im Mittelalter die Grenze zwischen dem Seehafen und dem Binnenhafen mit seiner Anbindung an die Elbe durch den Stecknitz-Kanal.", {PocketPC = 1}),
      Media = zmediasalzspeicher2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB73
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB73(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lübecker Salzspeicher waren Drehort für den Film Nosferatu Eine Symphonie des Grauens von Friedrich Wilhelm Murnau und dienten als Kulisse für das Haus, das der Vampir mietet. \nIm Bild eine Szene aus dem Film.", {PocketPC = 1}),
    Media = zmediasalzspeicher3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB74
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB74(action)
  zoneSalzspeicher.Visible = true
  zitemInfo.Commands.Salzspeicher.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB75(action)
  if action == "Button1" then
    zoneSchiffergesellschaft.Visible = true
    zitemInfo.Commands.Schiffergesellschaft.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Als der Zunftzwang 1866 durch ein Gewerbegesetz außer Kraft trat, entschied man, die Organisation als freie Genossenschaft weiterzuführen und die gewerblichen Interessen ihrer Mitglieder zu vertreten. Jedoch brachte der neue Rechtsstatus schnell hohe Schulden ein, so dass man sich genötigt sah, das historische Gebäude zu verkaufen. Fortan wurde es als Gaststätte betrieben und ist als solche bis heute erhalten. Mit Schiffergesellschaft ist heute das Gebäude der ehemaligen Bruderschaft gemeint. Die Gemeinschaft Schiffergesellschaft existiert jedoch auch heute noch und geht ihren sich verschriebenen Aufgaben nach.", {PocketPC = 1}),
      Media = zmediaschiffergsell2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB76
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB76(action)
  zoneSchiffergesellschaft.Visible = true
  zitemInfo.Commands.Schiffergesellschaft.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB77(action)
  if action == "Button1" then
    zoneSchwansHof.Visible = true
    zitemInfo.Commands.SchwansHof.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der älteste und auch der einzige Wohngang Lübecks, der von seiner Entstehung bis heute seinen Namen nicht änderte. Errichtet 1296 von Johannes von Swane. \nIm 16. Jahrhundert zog ein Wirtshaus in das Gangviertel, weitere Ställe und Verschläge für die Tiere der Wirtschaft wurden errichtet. Dies weckte keineswegs die Begeisterung der Bewohner des Gangviertels, da die ohnehin katastrophalen hygienischen Verhältnisse dadurch noch weiter verschlechtert wurden. Schon bald kam die Quittung: Die enge Bebauung und die übermäßige Tierhaltung auf engem Raum boten der Pest ideale Ausbreitungsbedingungen im Jahre 1597.", {PocketPC = 1}),
      Media = zmediaGangSchwan2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB78
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB78(action)
  zoneSchwansHof.Visible = true
  zitemInfo.Commands.SchwansHof.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB79(action)
  if action == "Button1" then
    zoneStAegidienKirche.Visible = true
    zitemInfo.Commands.StAegidienKirche.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Kirche hat alle kriegerischen Auseinandersetzungen überstanden. In der Schlacht bei Lübeck zu Beginn der Lübecker Franzosenzeit erhielt sie zwar 1806 den Treffer einer Haubitzgranate ins Gewölbe. Dieser Blindgänger zündete jedoch nicht. Eine Kanonenkugel im Mauerwerk beim Nordportal erinnert heute an diese Beinahekatastrophe. Beim Luftangriff auf Lübeck im März 1942 blieb die Kirche trotz schwerer Schäden in der näheren Umgebung von größeren Schäden verschont, allerdings wurden durch die Druckwelle einer Luftmine alle Fenster und damit die Glasmalereien zerstört.", {PocketPC = 1}),
      Media = zmediaAegidien2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB80
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB80(action)
  zoneStAegidienKirche.Visible = true
  zitemInfo.Commands.StAegidienKirche.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB81(action)
  if action == "Button1" then
    zoneStAnnenMuseumsquartier.Visible = true
    zitemInfo.Commands.StAnnenMuseumsquartier.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("1843 brannten Teile des Klosters und die Kirche aus. Während die Klostergebäude wiederhergestellt wurden, wurde die Kirche bis auf Fragmente abgerissen, die als Ruine stehen blieben. \nDie meisten Räume im Erdgeschoss des Klosters sind noch original aus der Erbauungszeit erhalten: der Kreuzgang, die Refektorien, der Remter (der größte Raum des Klosters, wahrscheinlich Arbeits- und Tagesraum der Nonnen, seit 1733 Esssaal des Armenhauses), der Kapitelsaal und die Sakristei der Klosterkirche. In der Südwestecke des Kreuzgangs befindet sich die Wärmekammer, das Kalefaktorium. \nVor dem Ersten Weltkrieg begann die Umnutzung zum St. Annen Museum, welches 1915 eröffnet wurde. \nDie Original-Statuen der Puppenbrücke befinden sich auch hier im Innenhof.", {PocketPC = 1}),
      Media = zmediaStAnnen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB82
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB82(action)
  zoneStAnnenMuseumsquartier.Visible = true
  zitemInfo.Commands.StAnnenMuseumsquartier.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB83(action)
  if action == "Button1" then
    zoneStJakobiKirche.Visible = true
    zitemInfo.Commands.StJakobiKirche.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der heutige Bau entstand um 1300 und ersetzte nach dem großen Stadtbrand von 1276 eine romanische Hallenkirche an gleicher Stelle, die bereits um 1227 erwähnt wurde. \nEs wird vermutet, dass Rundbogenfriese im Bereich des Kirchturms und der Seitenschiffsmauern Bestandteile dieses Vorgängerbaus sind. \nDie bedeutenden mittelalterlichen Fresken der Kirche wurden bei Renovierungsarbeiten Ende des 19. Jahrhunderts wiederentdeckt. \nDie Turmspitze wurde mehrfach, zuletzt 1901, vom Blitz getroffen und brannte 1901 etwa einen Tag lang. \nSt. Jakobi blieb als eine der wenigen Lübecker Kirchen während des Bombenangriffs in der Palmsonntagsnacht 1942 unbeschädigt. Sie verfügt daher über die zwei letzten historischen Orgeln Lübecks.", {PocketPC = 1}),
      Media = zmediaJakobi2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB84
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB84(action)
  zoneStJakobiKirche.Visible = true
  zitemInfo.Commands.StJakobiKirche.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB85(action)
  if action == "Button1" then
    zoneStadtmauer.Visible = true
    zitemInfo.Commands.Stadtmauer.Enabled = true
    Station(nil)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Hügel Bucu war zuvor bereits Standort einer wendischen Burg gewesen und wies topografisch bessere Voraussetzungen der Befestigung auf. Die Befestigung der Stadtgründung des 12. Jahrhunderts bestand aus der Lübecker Burg, die nach der Schlacht von Bornhöved zum Burgkloster wurde und einer Stadtmauer und vier Stadttoren, von denen das Burgtor und das Holstentor in ihren späteren baulichen Überformungen heute noch zeugen. \nDie Stadtmauer umgab die gesamte Altstadt. An der Trave war sie in regelmäßigen Abständen mit kleinen Toren versehen, um den Warentransport zwischen Hafen und Stadt zu ermöglichen. Am nördlichen Rand der Altstadt (entlang der Straßen An der Mauer und Wakenitzmauer) sind noch Reste der mittelalterlichen Stadtmauer erhalten, zum Teil in im 17. Jahrhundert errichteten Häusern verbaut.", {PocketPC = 1}),
      Media = zmediawallanlagen2,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB86
    })
  end
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB86(action)
  zoneStadtmauer.Visible = true
  zitemInfo.Commands.Stadtmauer.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB87(action)
  zoneTheaterfigurenmuseum.Visible = true
  zitemInfo.Commands.Theaterfigurenmuseum.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB88(action)
  zoneWillyBrandtHaus.Visible = true
  zitemInfo.Commands.WillyBrandtHaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB89(action)
  zoneZeughaus.Visible = true
  zitemInfo.Commands.Zeughaus.Enabled = true
  Station(nil)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB92(action)
  Wherigo.GetInput(zinputFinal)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB95(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Nachdem die Dänen 1201 Lübeck erobert hatten, residierte hier als Statthalter Albrecht von Orlamünde, der Neffe des dänischen Königs. 1221 wurden Burg und Domstadt durch eine gemeinsame Ummauerung mit der bürgerlichen Stadt vereint. \nAls Albrecht in der Schlacht bei Mölln gefangengenommen worden war, nutzten die Lübecker die Gunst der Stunde, ließen sich 1226 das Barbarossa-Privileg durch einen Reichsfreiheitsbrief bestätigen und rissen die landesherrliche Burg nieder, um einem möglichen erneuten Anspruch auf die Stadtherrschaft zuvorzukommen. \nAls Dank für den Sieg über die Dänen, der auf die Hilfe der Heiligen zurückgeführt wurde, errichteten die Lübecker anstelle der Burg ein Kloster und übergaben es 1229 dem Dominikanerorden. Damit erhielt nach den Franziskanern ein zweiter Bettelorden einen Sitz in Lübeck.", {PocketPC = 1}),
    Media = zmediaburkloster1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB96
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB96(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Mit der Einführung der Reformation 1531 wurde das Kloster aufgelöst. Im Gebäude wurde ein Armenhaus eingerichtet. Die Klosterkirche hatte schon immer statische Probleme. 1589 stürzte der Kanzelpfeiler ein, 1635 ein Stück Gewölbe, 1635 der erste Nordpfeiler und mit ihm das gesamte erste westliche Gewölbejoch. Als dann 1818 der zweite südliche Langhauspfeiler mit dem Gewölbe einstürzte, entschloss sich der Rat der Stadt mit Zustimmung der Bürgerschaft, die seit 1806 nicht mehr benutzte Kirche abzureißen. Lediglich die Nordwand, die an die Klosterbauten anschloss, und die darin eingebauten Kapellen blieben erhalten.", {PocketPC = 1}),
    Media = zmediaburkloster2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB97
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB97(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("An der Stelle der abgebrochenen Kirche entstand 1874-76 eine Schule. Von 1893-96 wurde das Burgkloster baulich stark verändert. In dieser Form diente das Burgkloster bis 1962 als Gerichtsgebäude. \nSeit 1976 wurden die mittelalterlichen Bauteile wieder freigelegt, das Gebäude wurde zu Museumszwecken umgestaltet und mit einer modernen Eingangshalle versehen. \nIm Zuge der Errichtung des Europäischen Hansemuseums wurden die Räumlichkeiten des Burgklosters in das 2015 eröffnete neue Museum einbezogen.", {PocketPC = 1}),
    Media = zmediaburkloster3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB99(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das heutige Burgtor wurde 1444 anstelle eines romanischen Tores innerhalb einer Befestigungsanlage erbaut. An den anschließenden Gebäuden, Marstall wie Zöllnerhaus, finden sich Terrakottafriese.  \nIm 19. Jahrhundert wurde in der Lübecker Bürgerschaft erwogen, das Burgtor abzureißen, die Älterleute der zwölf bürgerlichen Kollegien wollten dort Bauplatz schaffen. Die Bürgerschaft lehnte diesen Vorschlag schließlich einstimmig ab. Man würde ein altertümliches Gebäude zerstören und das sei nicht tragbar. Stattdessen entschied man sich, den Durchgang durch das Burgtor zu erweitern. 1850 wurde der westliche Durchgang geschaffen, 1875 ein weiterer. Ende der 1920er kam ein letzter Durchgang hinzu, so dass es heute vier Durchgänge gibt.", {PocketPC = 1}),
    Media = zmediaburgtor1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB100
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB100(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das heute erhaltene Tor war das innere von ursprünglich drei hintereinander gelegenen Toren, deren Modelle in kleinen Schaukästen am früheren Standort besichtigt werden können. \nDas Tor etwa 50m östlich wurde allerdings erst 1903 in die Stadtmauer gebrochen.", {PocketPC = 1}),
    Media = zmediaburgtor3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB102(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der damals romanische Dom wurde etwa 1230 fertiggestellt und mehrmals umgebaut und erweitert. \nDie romanische Apsis wurde nach Fertigstellung des gotischen Chors bis auf die Fundamente abgerissen. Der Unterschied zwischen den beiden Abschnitten ist auch für Laien deutlich erkennbar: Der ältere Bauteil wird von massiven, rechteckigen Pfeilern getragen, der jüngere Chor von schlanken, runden Säulen. \n \nBei dem schweren Luftangriff in der Nacht zum Palmsonntag 28./29.03.1942, bei dem 1/5 der Innenstadt zerstört wurde, stürzte der östliche Teil ein und zerstörte den Hochaltar von 1696. \nDer Brand des benachbarten Dommuseums griff auf den Dachstuhl über; gegen Mittag stürzten die Turmhelme ab. \nEs konnten jedoch Teile der Innenausstattung wie das Triumphkreuz und fast alle mittelalterlichen Flügelaltäre gerettet werden.", {PocketPC = 1}),
    Media = zmediaDom2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB103
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB103(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als Kriegsfolge brach 1946 der ungesicherte Giebel des nördlichen Querschiffs zusammen, begrub die Paradiesvorhalle unter sich und zerstörte sie fast völlig. \n \nDer Wiederaufbau dauerte einige Jahrzehnte, da die Prioritäten hier eher auf den Wiederaufbau der Marienkirche gelegt wurden.  \nZunächst wurden die Türme und der westliche Teil der Kirche instand gesetzt, es folgte dann der Ostchor und zuletzt die Paradies-Vorhalle an der Nordseite des Doms. \nDie Turmhelme erhielten wie alle nach dem Krieg wiederaufgebauten Turmhelme der Lübecker Hauptkirchen eine Unterkonstruktion aus Leichtbeton, nachdem zunächst die mittelalterlichen Fundamente der beiden Türme hydraulisch angehoben und verstärkt worden waren. \nDer Wiederaufbau wurde erst 1982 abgeschlossen.", {PocketPC = 1}),
    Media = zmediaDom3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB105(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Name Dunkelgrüner Gang erinnert an die Gärten und ehemaligen Wiesenflächen. \nDie im Süden gelegenen Gangteile wurden wegen ihrer lichten Bebauung Hellgrüner Gang genannt. \nDie Geschichte dieses Viertels geht zurück bis ins Jahr 1357, die erste Bebauung wurde um 1587 unternommen. Allmählich bildete sich eine kleine Kolonie in der Hafengegend, dicht am Wasser und nicht fern von der Hauptstraße nach Mecklenburg. \nAm 23. April 1596 erschütterte eine gewaltige Gasexplosion das Gangviertel, die sogar die Burgkirche ins Wanken brachte. Ein Spanier hatte heimlich ungekörntes Schießpulver gelagert, das durch Selbstentzündung den größten Teil des Gangviertels zerstörte. \nDie heutige Bebauung des Viertels stammt aus der Zeit der großen Explosion, also nach dem 17. Jahrhundert.", {PocketPC = 1}),
    Media = zmediaGangGruen2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB107(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Um die Ärmsten der Armen vor Mietwucher zu schützen, gründeten angesehene Lübecker damals Stiftungen wie zum Beispiel den Füchtingshof, um nur den berühmtesten zu nennen. Der Ratsherr Johann Füchting bestimmte 1636 ein Drittel seines Erbes zum Nutzen und Besten der Armen. Als Gegenleistung erbat sich der Stifter oft das Gebet nach seinem Ableben. Das sollte ihm dann einen guten Platz im Himmel sichern. Noch heute sind 28 Wohnungen günstig an Pensionärinnen, oftmals auch Witwen und Lübecker Kaufleute, vermietet. \nDas Innere des Füchtingshofs diente Friedrich Wilhelm Murnau für seinen Film Nosferatu - Eine Symphonie des Grauens bei seinen Lübecker Außenaufnahmen in zwei Szenen als Kulisse.", {PocketPC = 1}),
    Media = zmediaGangFuechting2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB111(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der jüngste der großen Stiftshöfe, gestiftet von Elisabeth Haase, der Witwe des Weinhändlers Johann Haase, im Jahre 1725. Sie ließ 13 Wohnungen in einstöckigen Häusern für Witwen und ledige Frauen bauen. \nDer liebevoll restaurierte Hof wurde oft als Filmkulisse genutzt, beispielsweise für einen Weihnachtsfilm mit Heinz Rühmann und Sir Peter Ustinow. ", {PocketPC = 1}),
    Media = zmediaGangHaasen2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB113(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Hügel Bucu war zuvor bereits Standort einer wendischen Burg gewesen und wies topografisch bessere Voraussetzungen der Befestigung auf. Die Befestigung der Stadtgründung des 12. Jahrhunderts bestand aus der Lübecker Burg, die nach der Schlacht von Bornhöved zum Burgkloster wurde und einer Stadtmauer und vier Stadttoren, von denen das Burgtor und das Holstentor in ihren späteren baulichen Überformungen heute noch zeugen. Die Stadtmauer umgab die gesamte Altstadt. An der Trave war sie in regelmäßigen Abständen mit kleinen Toren versehen, um den Warentransport zwischen Hafen und Stadt zu ermöglichen. Am nördlichen Rand der Altstadt (entlang der Straßen An der Mauer und Wakenitzmauer) sind noch Reste der mittelalterlichen Stadtmauer erhalten, zum Teil in im 17. Jahrhundert errichteten Häusern verbaut.", {PocketPC = 1}),
    Media = zmediawallanlagen2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB115(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Umfangreiche archäologische Funde haben zu einer weiteren Verschiebung der Eröffnung bis zum Mai 2015 geführt. Die bei der Baufeldfreimachung entdeckten archäologischen Funde wurden durch eine begehbare Grabungsstätte in den Rundgang einbezogen. Anhand der Ausgrabungen werden 1200 Jahre Geschichte gezeigt. \nDas Hansemuseum war im April 2015 Tagungsort der Außenminister der G7-Staaten. Offiziell eröffnet wurde es am 27. Mai 2015 von Bundeskanzlerin Angela Merkel. Der Museumsbetrieb wurde am 30. Mai 2015 aufgenommen.", {PocketPC = 1}),
    Media = zmediaHansemuseum2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB117(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Bewohner des Hospitals waren einer klosterähnlichen Regel unterworfen, doch erhielten sie Nahrungsmittel und seit dem 17. Jahrhundert acht Mal im Jahr ein warmes Bad. \nWährend der Reformationszeit wurde das Hospital in ein weltliches Altenheim umgewandelt, welches bis heute erhalten blieb. Ursprünglich standen die Betten der Hospitalbewohner in der Halle. 1820 wurden vier Quadratmeter große, hölzerne Kammern gebaut, getrennt nach Geschlechtern. Die Abteilungen sind nach oben offen. Es gab zusätzlich eine kleine Bücherei und Apotheke. An den Türen der Kammern kann man noch heute Namen und Nummern der damaligen Bewohner sehen. Bis 1970 waren die Kammern bewohnt. \nDas Heiligen-Geist-Hospital ist eine Stiftung des öffentlichen Rechts und wird treuhänderisch von der Hansestadt Lübeck verwaltet.", {PocketPC = 1}),
    Media = zmediahospital2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB118
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB118(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Raumbestimmend in der Kirchenhalle sind die beiden großformatigen mittelalterlichen Wandgemälde an der Nordseite, die auf ca. 1320/1325 datiert werden. Das westliche Bogenfeld zeigt eine komplexe typologische Szene: den salomonischen Thron. \nNach jahrhundertelanger Übermalung wurden die Wandmalereien 1866 wiederentdeckt. Von 1990 - 95 erfolgte eine eingehende Untersuchung im Rahmen eines Forschungsprojektes des Bundesministeriums für Forschung und Technologie (BMFT). Bis 1999 wurden beide Malereien nach den dabei gewonnenen Erkenntnissen konserviert. \nFür das Heiligen-Geist-Hospital sind zwölf mittelalterliche Grabplatten überliefert, von denen noch acht erhalten sind. Die restlichen sind definitiv abgängig.", {PocketPC = 1}),
    Media = zmediahospital3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB120(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Über dem Durchgang ist auf der Stadt- wie auf der Feldseite je eine Inschrift angebracht. Auf der Stadtseite lautet die Inschrift S.P.Q.L., eingerahmt von den Jahreszahlen 1477 und 1871; ersteres war das vermeintliche Datum der Erbauung (korrektes Datum ist allerdings 1478), letzteres das Datum der Restaurierung sowie der Gründung des Deutschen Reiches. Diese Inschrift hatte das römische S.P.Q.R. (lateinisch Senatus populusque Romanus Senat und Volk Roms) zum Vorbild und sollte entsprechend für Senatus populusque Lubecensis stehen. Sie wurde allerdings erst 1871 angebracht.", {PocketPC = 1}),
    Media = zmediaholstentor1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB121
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB121(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Eine andere Inschrift befindet sich auf der Feldseite. Dort steht CONCORDIA DOMI FORIS PAX (Eintracht innen, draußen Friede). Auch dieser Schriftzug stammt von 1871 und ist eine verkürzte Form der Inschrift, die zuvor auf dem (nicht erhaltenen) Vortor gestanden hatte: Concordia domi et foris pax sane res est omnium pulcherrima (Eintracht innen und Friede draußen sind in der Tat für alle am besten).", {PocketPC = 1}),
    Media = zmediaholstentor3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB122
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB122(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Durchgang war früher zur Feldseite mit zwei Torflügeln versehen, die nicht erhalten sind. Ein Fallgatter wurde erst 1934 angebracht und entspricht nicht den ursprünglichen Sicherungsanlagen. An dieser Stelle befand sich einst ein so genanntes Orgelwerk, bei dem die Eisenstangen einzeln und nicht als Ganzes heruntergelassen wurden. So war es möglich, alle Stangen bis auf eine oder zwei bereits zu senken und dann abzuwarten, um den eigenen Männern noch ein Hindurchkommen zu ermöglichen oder durch die Verengung des Durchganges ein Einfallen feindlicher Kavallerie oder Fahrzeuge unter geringstem Aufwand zu verhindern.", {PocketPC = 1}),
    Media = zmediaholstentor4
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB124(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Dieser Torausgang wurde im Gegensatz zu den Mühlentoren wenig genutzt, so dass ihn der Rat um 1500 zumauern ließ. Dies geschah nicht, wie eine Sage glaubhaft machen will, weil Kaiser Karl IV. das Tor 1375 durchschritt und nach ihm keiner mehr hindurchschreiten sollte. \nDer eigentliche Grund sei ein Streit zwischen dem Rat und den Domherren gewesen, berichtet der Chronist Hans Regkmann um 1540. Die Domherren wollten den Weg über den Mühlendamm verbieten oder aber beim Passieren Zoll erheben. Trotz eines Einspruchs des Senats hätte das Domkapitel auf seinem Anliegen bestanden, das Tor zugemauert und die Brücke abgebrochen.", {PocketPC = 1}),
    Media = zmediakaisertor2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB125
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB125(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als im 17. Jahrhundert die Wehranlagen verstärkt wurden, legte der Wallbaumeister die weit vorspringende Bastion Kaiser vor den Turm. In den ausgebauten Kasematten wurde Pulver gelagert. Den Turm selbst, der zur Verteidigung gegen neuzeitliche Geschütze sinnlos geworden war, brach man bis auf einen Stumpf ab, der den Wall vier Meter überragte. Im 19. Jahrhundert wurde ihm ein Obergeschoss aufgesetzt. Hier zog 1826 die Navigationsschule, die spätere Seefahrtschule ein. Als 1897 beim Bau des Elbe-Lübeck-Kanals die Bastion Kaiser durchschnitten und dabei die Zwingerruine freigelegt wurde, öffnete man auch das zugemauerte Tor und machte es durchgängig. Am 26. August 1900 durchschritt Kaiser Wilhelm II. das Kaisertor, um an Bord der Lubeca auf der Fahrt zum Stadthafen die Schifffahrt auf dem Elbe-Lübeck-Kanal zu eröffnen.", {PocketPC = 1}),
    Media = zmediakaisertor3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB127(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Noch zu Lebzeiten des heiligen Franz von Assisi erhielten die Franziskaner im Jahre 1225 ein Grundstück zum Bau von Kloster und Kirche. \nVermutlich um 1303, wurde zunächst der Ostteil mit Chorraum und Querschiff neu im Stil der Backsteingotik erbaut. 1329 wurde das Chorgestühl eingebaut, dann ab 1335 das Langhaus vollendet. Später kamen noch Kapelleneinbauten und -anbauten hinzu.", {PocketPC = 1}),
    Media = zmediaKatharinenkirche2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB128
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB128(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("In der Reformation wurde das Katharinenkloster 1531 zu einer Lateinschule. \nWährend der französischen Besetzung Lübecks (1806-1813) wurde die Kirche profaniert und als Pferdestall und Lazarett zweckentfremdet. \nNachdem zahlreiche andere Innenstadtkirchen beim Bombenangriff auf Lübeck am Palmsonntag 1942 ausgebrannt waren, wurde St. Katharinen vorübergehend wieder für regelmäßige Gottesdienste hergerichtet. \nIn der Museumskirche ist auch ein monumentaler Gipsabguss der St.-Jürgen (St.-Georg)-Gruppe aus der Nikolaikirche in Stockholm. Die reiche Ausmalung des 14. Jahrhunderts ist nur teilweise wieder freigelegt.", {PocketPC = 1}),
    Media = zmediaKatharinenkirche3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB130(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die beiden Seitenflügel auf der Hofseite sind über die Gartenanlagen des Grundstücks der ehemaligen Niederlassung des Deutschen Ordens (1268-1806) rechts neben dem Kranen-Konvent zugänglich und stammen aus dem 14. bis 16. Jahrhundert. Der Kranen-Konvent wurde ab Ende des 18. Jahrhunderts als Armenhaus für Frauen und Siechenhaus genutzt, im 20. Jahrhundert als Altenheim und Beratungsstelle des Sozialamtes und jetzt von der benachbarten Ernestinenschule. Der Keller wurde nach archäologischen Grabungen und der erforderlichen denkmalpflegerischen Grundsanierung zu einer Mensa umgebaut.", {PocketPC = 1}),
    Media = zmediaKKonvent2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB132(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Weil noch nie eine vollständige Kraweel ausgegraben worden war, musste der Bauplan in Teilstücken erstellt werden. Das Schiff wurde eine authentische Rekonstruktion, die allerdings einen zusätzlichen Dieselmotor zur Fahrt ohne Segelleistung besitzt. \nAm 27. März 2004 wurde das Schiff zu Wasser gelassen; die Jungfernfahrt fand im April 2005 statt. Am Karfreitag 2006, dem 14. April, startete die Lisa von Lübeck zu ihrem ersten Auslandstörn. Ziel der Reise war die Hansestadt Danzig an der polnischen Ostseeküste, mit Zwischenstopps in Stralsund und Kolberg. 2013 wurde bei einer Kollision der vordere Teil beschädigt.", {PocketPC = 1}),
    Media = zmediaLisa2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB134(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Bodenfliese aus der Löwenapotheke (14. Jahrhundert) \n \n1812 - 1816 arbeitete Friedlieb Ferdinand Runge hier, er entdeckte 1834 das Anilin und das Phenol, unentbehrliche Grundstoffe der heutigen Arzneimittel. \n \nDie Bewahrung dieses Hauses vor dem 1899 geplanten Abriß ist der Initiative des Dichters und pazifistischen AnarchistenErich Mühsam zu verdanken, welcher 1934 im KZ Oranienburg ermordet wurde.", {PocketPC = 1}),
    Media = zmediaLoewenapotheke2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB136(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("In der Nacht zum Palmsonntag vom 28. zum 29. März 1942 brannte die Marienkirche bei dem Luftangriff auf Lübeck, bei dem ein Fünftel der Lübecker Innenstadt zerstört wurde, fast völlig aus. \nDabei wurde, neben zahlreichen anderen Kunstwerken, auch die berühmte Totentanzorgel vernichtet, auf der unter anderem Dietrich Buxtehude und mit großer Wahrscheinlichkeit Johann Sebastian Bach gespielt hatten. \nWährend des durch den Bombenangriff ausgelösten Brandes am Palmsonntag 1942 sollen die Kirchenglocken durch den Luftzug noch einmal geläutet haben, bevor sie herabstürzten. Die Reste zweier Glocken, der ältesten Glocke von 1508, der Sonntagsglocke und der Pulsglocke von 1668, wurden als Mahnmal in der ehemaligen Schinkel-Kapelle unter dem Süderturm erhalten.", {PocketPC = 1}),
    Media = zmediaMarien2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB137
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB137(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der eigentliche Wiederaufbau begann 1947 und wurde zwölf Jahre später größtenteils abgeschlossen. Dabei wurde aufgrund der Erfahrungen der Brandnacht darauf verzichtet, die Tragwerkskonstruktion des Daches und der Turmhelme wieder aus Holz auszuführen. Stattdessen sind alle nach dem Krieg wiederaufgebauten Turmspitzen von Lübecker Kirchen in einem speziell entwickelten Verfahren in Leichtbetonbauweise unter der Kupfereindeckung ausgeführt. \nDer vergoldete Dachreiter, der 30 Meter über das Hochschiffdach herausragt, wurde 1980 nach alten Zeichnungen und Fotografien neu geschaffen. \nDer südlich der Kirche gelegene Marienkirchhof vermittelt durch seine Abschlüsse, die Nordfassade des Rathauses, das Kanzleigebäude sowie das Marienwerkhaus den Eindruck des mittelalterlichen Stadtbildes.", {PocketPC = 1}),
    Media = zmediaMarien3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB138
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB138(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ein großer Granitquader rechts neben dem Eingang wurde nicht etwa von der Kirchenbauhütte dort zwischengelagert oder vergessen, sondern soll von des Teufels Hand dort hingekommen sein. Der Sage nach soll der Teufel an der Errichtung der Kirche beteiligt gewesen sein, in dem Glauben, dass es sich um den Bau eines Wirtshauses handele. An diese Geschichte erinnert eine von Rolf Goerler geschaffene Teufelsfigur im Marienkirchhof. \nIm Westen und Norden der Kirche zeigt sich der Kirchhof als freier Platz, die mittelalterliche, kleinteilige Bebauung wurde abgeräumt. Allein an der Ecke Schüsselbuden zur Mengstraße erinnern die Fundamentsteine an die Kapelle Maria am Stegel (1415). Gegen ihren Wiederaufbau nach dem Krieg wurde Ende der 50er Jahre entschieden und das noch stehende Außenmauerwerk der Ruine abgetragen.", {PocketPC = 1}),
    Media = zmediaMarien4
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB140(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Trotz der Kriegszerstörungen durch den Luftangriff auf Lübeck am 29. März 1942 und einer Verkleinerung nach Süden beim Wiederaufbau der Innenstadt zeigt der Markt sich vor der mächtigen Kulisse der Marienkirche fast noch wie auf alten Ansichten. Der Kaak, eine mittelalterliche Gerichtslaube und Pranger, wurde nach dem Krieg 1952 abgebrochen und eingelagert; 1986 wurde er etwas nach Norden versetzt unter Verwendung alter Bauteile wiederaufgebaut.", {PocketPC = 1}),
    Media = zmediaMarkt2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB141
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB141(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der 1873 erbaute Marktbrunnen wurde 1934 abgerissen, da der Markt bis in die frühen 1980er Jahre als Parkplatz benutzt wurde. \nDer Kaak, eine mittelalterliche Gerichtslaube und Pranger, wurde nach dem Krieg 1952 abgebrochen und eingelagert; 1986 wurde er etwas nach Norden versetzt unter Verwendung alter Bauteile wiederaufgebaut.", {PocketPC = 1}),
    Media = zmediaMarkt3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB143(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Marstallhof war vom Mittelalter bis in die Neuzeit die Wache der Lübecker Ordnungshüter, im Mittelalter Reitendiener genannt. Der Marstall unterstand jeweils zwei Ratsherren, den Stallherren oder Marstallherren und wurde unter ihrer Aufsicht von einem Hauptmann geführt. Der Marstall umfasste daher neben Stallungen für die Pferde auch eine Schmiede und bis zur Errichtung der JVA Lauerhof 1909 auch das Gefängnis der Stadt. Während die Marstallschmiede mit ihrer Renaissancefassade an der Großen Burgstraße für den neugotischen Neubau des Gerichtsgebäudes 1894 abgerissen wurde, ist das Torgebäude über der Einfahrt zum Marstallhof erhalten geblieben. Die weiter erhaltenen Gebäude des Marstalls schließen westlich an das Burgtor an.", {PocketPC = 1}),
    Media = zmediaMarstall2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB147(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Johann Georg Niederegger wurde 1777 in Ulm geboren. In Langenau absolvierte er eine Konditorlehre. Danach zog er 1803 nach Lübeck und arbeitete in der Konditorei Maret am Markt. Nach dem Tod des Besitzers übertrug dessen Witwe Niederegger das Geschäft, der somit am 1. März 1806 sein eigenes Unternehmen gründen konnte. Kurz danach richtete Napoleon die Kontinentalsperre ein (Handelsembargo), so dass Niederegger die Rohstoffe Mandeln aus Sizilien und Zucker ausgingen. Zwischen 1811 und 1812 kam die Produktion gänzlich zum Erliegen. Zwischen 1812 und 1814 konnte der Nachschub durch Schmuggel via Helgoland gesichert werden.", {PocketPC = 1}),
    Media = zmediaNiederegger1,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB148
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB148(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("1873 wurde das Marzipan von Niederegger auf der Wiener Weltausstellung prämiert. \n1908 ernannte Kaiser Wilhelm II das Unternehmen zum Hoflieferanten. \nIm zweiten Obergeschoss des Cafes in der Breiten Straße befindet sich seit 1999 ein Marzipanmuseum mit historischen Holzformen für die Herstellung von reliefartigen Marzipanblöcken und einer Gruppe historischer Figuren in Menschengröße aus Marzipan.  \nAm 1. März 2006 feierte die Fa. Niederegger ihr 200-jähriges Bestehen. ", {PocketPC = 1}),
    Media = zmediaNiederegger3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB150(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im 15. Jahrhundert erfolgte der Ausbau zur heutigen Erscheinung: Eine gotische, fünfschiffige Hallenkirche aus Backsteinen mit fünf Jochen. Damit wurde die Petrikirche eine der wenigen existierenden fünfschiffigen Kirchen. Die Reformation hielt in Lübeck 1529/30 einzug und die Petrikirche wurde evangelisch. Während des Luftangriffs auf Lübeck am Palmsonntag 1942 brannte die Petrikirche völlig aus. Das Dach, der Turmhelm und die reiche Innenausstattung wurden zerstört. \nDie notdürftig abgedeckte Kirche diente der Lübecker Kirchbauhütte zunächst als Lapidarium, in dem geborgene skulpturale Fragmente aus allen kriegszerstörten Lübecker Kirchen zwischengelagert wurden. Erst 1987 war die Kirche äußerlich wieder vollständig aufgebaut.", {PocketPC = 1}),
    Media = zmediaPetri2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB151
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB151(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Turm ist 108m hoch und kann seit 1908 bestiegen werden. Per Aufzug kann die in 50 m Höhe gelegene Aussichtsplattform erreicht werden. Von dort bietet sich ein Rundblick über die gesamte Altstadt Lübecks und das Umland bis hin zur Lübecker Bucht. \nDie beiden vor dem Hauptportal stehenden Glocken gehörten ursprünglich Danziger Kirchen und waren im Zweiten Weltkrieg zur Rohstoffgewinnung auf den Hamburger Glockenfriedhof gekommen. Diese Glocken sind dem Einschmelzen entgangen. Nach 1945 wurden sie (wie auch die Glocken des Glockenspiels der Marienkirche und die Paramente der Danziger Marienkirche, die heute im St. Annen-Museum zu sehen sind) nach Lübeck gebracht, weil hier viele Flüchtlinge aus Danzig eine neue Heimat gefunden hatten.", {PocketPC = 1}),
    Media = zmediaPetri3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB153(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Rat beschloss 1774 ein Übriges zu tun und die Brücke mit acht Statuen (vier männliche - Merkur, Römischer Krieger, Flussgott und Neptun - und vier weibliche - Friede, Eintracht, Vorsicht und Freiheit) und vier Vasen (Ackerbau, Fleiß, Sparsamkeit sowie die Freien Künste) aus Sandstein zu schmücken. \nSo erhielt sie im Volksmund schnell den Namen Puppenbrücke. \n1907 erbaute man den heute landesweit bekannten Neubau der Puppenbrücke. Anlass war die Verlegung des Bahnhofs und das steigende Verkehrsaufkommen. Die alte Brücke wurde einfach zu schmal. Das Skulpturenprogramm wurde in neuer Anordnung komplett übernommen.", {PocketPC = 1}),
    Media = zmediapuppen2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB154
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB154(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im 1908 wurde die Brücke vollendet. Vier Reliefs wurden von dem Berliner Bildhauer Taschner für die Bogenzwickel an der Außenseite der Brücke geschaffen. Sie stellen die vier Elemente dar - Feuer und Wasser auf der Süd-, Luft und Erde auf der Nordseite der Brücke. \nAuf der Puppenbrücke sind allerdings nicht die Original-Statuen zu sehen. Diese stehen seit 1984 im St.-Annen-Museum, wo sie vor den Einflüssen der Luftverschmutzung geschützt sind. Das Material für die Statuen stammt aus einem sächsischen Steinbruch. \nDie Kopien wurden mit Fehlern erschaffen, Frieden fehlt der Zweig und der Vorsicht wurden beide Arme amputiert.", {PocketPC = 1}),
    Media = zmediapuppen3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB156(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Ratskeller zu Lübeck unter dem Rathaus ist als Ratskeller seit 1220 belegt. \nDie runden Löcher in den Ziermauern der Fassade zum Markt hin haben den Zweck, den Wind zu brechen und die Fassade vor zu starkem Winddruck zu schützen. Die kleineren runden Löcher zur Marienkirche hin dienen nur der Zierde.", {PocketPC = 1}),
    Media = zmediaRathaus2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB157
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB157(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Von der Breiten Straße aus sieht man die Renaissancetreppe. Sie führte zu der in selbiger Zeit gestalteten so genannten Kriegsstube, dem dann prächtigsten Raum des Rathauses. Der Name des Saales zeigt, dass die Hanse nicht nur Einfluss auf die Wirtschaft hatte, sondern auch auf die Politik und oftmals über Krieg und Frieden entschied. \nDie Kriegsstube wurde im März 1942 beim ersten schweren Luftangriff auf Lübeck zerstört und ist heute kein Repräsentationsraum mehr.", {PocketPC = 1}),
    Media = zmediaRathaus3,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB158
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB158(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im Rathaus tagte der Rat der Hansestadt auch als Gericht: der Oberhof Lübeck war bis 1820 Appellationsgericht für Entscheidungen aus anderen Städten, die dem Lübschen Rechtskreis angehörten. \nDie Türen zum ehemaligen Gerichtssaal im Erdgeschoss sind verschieden hoch. Freigesprochene Angeklagte durften das Gericht durch die hohe Tür verlassen, verurteilte Angeklagte mussten durch die niedrige Tür gehen und dabei den Kopf senken.", {PocketPC = 1}),
    Media = zmediaRathaus4
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB160(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Speichergebäude dienten ursprünglich der Lagerung des aus Lüneburg über die Alte Salzstraße und später über den Stecknitz-Kanal herbeigeführten Salzes sowie des aus der Saline Oldesloe gewonnenen und mit Lastkähnen auf der Trave herangebrachten Salzes, das von Lübeck als Grundlage seines damaligen Reichtums nach ganz Skandinavien ausgeführt wurde.  \nDas Salz wurde vornehmlich zum Konservieren von in Norwegen und Schonen gefangenem Fisch benötigt und ermöglichte so den Heringshandel als Fastenspeise mit dem Binnenland. Die Lage an der Holstenbrücke über die Trave als der ältesten festen Lübecker Brücke markierte im Mittelalter die Grenze zwischen dem Seehafen und dem Binnenhafen mit seiner Anbindung an die Elbe durch den Stecknitz-Kanal.", {PocketPC = 1}),
    Media = zmediasalzspeicher2,
    Buttons = {"Weiter"},
    Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB161
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB161(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Lübecker Salzspeicher waren Drehort für den Film Nosferatu Eine Symphonie des Grauens von Friedrich Wilhelm Murnau und dienten als Kulisse für das Haus, das der Vampir mietet. \nIm Bild eine Szene aus dem Film.", {PocketPC = 1}),
    Media = zmediasalzspeicher3
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB163(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als der Zunftzwang 1866 durch ein Gewerbegesetz außer Kraft trat, entschied man, die Organisation als freie Genossenschaft weiterzuführen und die gewerblichen Interessen ihrer Mitglieder zu vertreten. Jedoch brachte der neue Rechtsstatus schnell hohe Schulden ein, so dass man sich genötigt sah, das historische Gebäude zu verkaufen. Fortan wurde es als Gaststätte betrieben und ist als solche bis heute erhalten. Mit Schiffergesellschaft ist heute das Gebäude der ehemaligen Bruderschaft gemeint. Die Gemeinschaft Schiffergesellschaft existiert jedoch auch heute noch und geht ihren sich verschriebenen Aufgaben nach.", {PocketPC = 1}),
    Media = zmediaschiffergsell2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB165(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der älteste und auch der einzige Wohngang Lübecks, der von seiner Entstehung bis heute seinen Namen nicht änderte. Errichtet 1296 von Johannes von Swane. \nIm 16. Jahrhundert zog ein Wirtshaus in das Gangviertel, weitere Ställe und Verschläge für die Tiere der Wirtschaft wurden errichtet. Dies weckte keineswegs die Begeisterung der Bewohner des Gangviertels, da die ohnehin katastrophalen hygienischen Verhältnisse dadurch noch weiter verschlechtert wurden. Schon bald kam die Quittung: Die enge Bebauung und die übermäßige Tierhaltung auf engem Raum boten der Pest ideale Ausbreitungsbedingungen im Jahre 1597.", {PocketPC = 1}),
    Media = zmediaGangSchwan2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB167(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Hügel Bucu war zuvor bereits Standort einer wendischen Burg gewesen und wies topografisch bessere Voraussetzungen der Befestigung auf. Die Befestigung der Stadtgründung des 12. Jahrhunderts bestand aus der Lübecker Burg, die nach der Schlacht von Bornhöved zum Burgkloster wurde und einer Stadtmauer und vier Stadttoren, von denen das Burgtor und das Holstentor in ihren späteren baulichen Überformungen heute noch zeugen. \nDie Stadtmauer umgab die gesamte Altstadt. An der Trave war sie in regelmäßigen Abständen mit kleinen Toren versehen, um den Warentransport zwischen Hafen und Stadt zu ermöglichen. Am nördlichen Rand der Altstadt (entlang der Straßen An der Mauer und Wakenitzmauer) sind noch Reste der mittelalterlichen Stadtmauer erhalten, zum Teil in im 17. Jahrhundert errichteten Häusern verbaut.", {PocketPC = 1}),
    Media = zmediawallanlagen2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB169(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Kirche hat alle kriegerischen Auseinandersetzungen überstanden. In der Schlacht bei Lübeck zu Beginn der Lübecker Franzosenzeit erhielt sie zwar 1806 den Treffer einer Haubitzgranate ins Gewölbe. Dieser Blindgänger zündete jedoch nicht. Eine Kanonenkugel im Mauerwerk beim Nordportal erinnert heute an diese Beinahekatastrophe. Beim Luftangriff auf Lübeck im März 1942 blieb die Kirche trotz schwerer Schäden in der näheren Umgebung von größeren Schäden verschont, allerdings wurden durch die Druckwelle einer Luftmine alle Fenster und damit die Glasmalereien zerstört.", {PocketPC = 1}),
    Media = zmediaAegidien2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB171(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("1843 brannten Teile des Klosters und die Kirche aus. Während die Klostergebäude wiederhergestellt wurden, wurde die Kirche bis auf Fragmente abgerissen, die als Ruine stehen blieben. \nDie meisten Räume im Erdgeschoss des Klosters sind noch original aus der Erbauungszeit erhalten: der Kreuzgang, die Refektorien, der Remter (der größte Raum des Klosters, wahrscheinlich Arbeits- und Tagesraum der Nonnen, seit 1733 Esssaal des Armenhauses), der Kapitelsaal und die Sakristei der Klosterkirche. In der Südwestecke des Kreuzgangs befindet sich die Wärmekammer, das Kalefaktorium. \nVor dem Ersten Weltkrieg begann die Umnutzung zum St. Annen Museum, welches 1915 eröffnet wurde. \nDie Original-Statuen der Puppenbrücke befinden sich auch hier im Innenhof.", {PocketPC = 1}),
    Media = zmediaStAnnen2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB173(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der heutige Bau entstand um 1300 und ersetzte nach dem großen Stadtbrand von 1276 eine romanische Hallenkirche an gleicher Stelle, die bereits um 1227 erwähnt wurde. \nEs wird vermutet, dass Rundbogenfriese im Bereich des Kirchturms und der Seitenschiffsmauern Bestandteile dieses Vorgängerbaus sind. \nDie bedeutenden mittelalterlichen Fresken der Kirche wurden bei Renovierungsarbeiten Ende des 19. Jahrhunderts wiederentdeckt. \nDie Turmspitze wurde mehrfach, zuletzt 1901, vom Blitz getroffen und brannte 1901 etwa einen Tag lang. \nSt. Jakobi blieb als eine der wenigen Lübecker Kirchen während des Bombenangriffs in der Palmsonntagsnacht 1942 unbeschädigt. Sie verfügt daher über die zwei letzten historischen Orgeln Lübecks.", {PocketPC = 1}),
    Media = zmediaJakobi2
  })
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB180(action)
  cartILuebeck:RequestSync()
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB181(action)
  Wherigo.GetInput(zinputFinal)
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB182(action)
  cartILuebeck:RequestSync()
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB183(action)
  cartILuebeck:RequestSync()
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB184(action)
  cartILuebeck:RequestSync()
end
function cartILuebeck.MsgBoxCBFuncs.MsgBoxCB185(action)
  cartILuebeck:RequestSync()
end
function Station(x)
  var_Anzahl = var_Anzahl + 1
  ztaskFindedieSehenswrdigkeiten.Description = WWB_multiplatform_string("Du hast bereits " .. var_Anzahl .. " gefunden! Finde die Sehenswürdigkeiten, die kreuz und quer in der Innenstadt (Stadtgraben bis Kanal) verteilt sind. 15 für Bronze, 25 für Silber und 35 für Gold! ")
  if var_Anzahl == 15 then
    Wherigo.PlayAudio(zmediasoundjubel)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("15 Punkte! \nEs gibt nun eine Zone für den Bronzecache. \n \nSuche weiter für Silber- und Goldcache!", {PocketPC = 1}),
      Media = zmediabronze,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB182
    })
    local p = Wherigo.TranslatePoint(zoneFinalBronze.OriginalPoint, entfB, 156)
    zoneFinalBronze.OriginalPoint = p
    zoneFinalBronze.ObjectLocation = p
    zoneFinalBronze.Points = GetZonePoints(p, 11)
    zoneFinalBronze.Active = true
    ztaskFindedasBronzeFinal.Active = true
  elseif var_Anzahl == 25 then
    Wherigo.PlayAudio(zmediasoundjubel)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("25 Punkte! \nEs gibt nun eine Zone für den Silbercache. \n \nSuche weiter für den Goldcache! ", {PocketPC = 1}),
      Media = zmediasilber,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB183
    })
    local p = Wherigo.TranslatePoint(zoneFinalSilber.OriginalPoint, entfS, 92)
    zoneFinalSilber.OriginalPoint = p
    zoneFinalSilber.ObjectLocation = p
    zoneFinalSilber.Points = GetZonePoints(p, 11)
    zoneFinalSilber.Active = true
    ztaskFindedasSilberFinal.Active = true
  elseif var_Anzahl == 35 then
    Wherigo.PlayAudio(zmediasoundjubel)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("35 Punkte! \nEs gibt nun eine Zone für den Goldcache.", {PocketPC = 1}),
      Media = zmediagold,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB184
    })
    local p = Wherigo.TranslatePoint(zoneFinalGold.OriginalPoint, entfG, 241)
    zoneFinalGold.OriginalPoint = p
    zoneFinalGold.ObjectLocation = p
    zoneFinalGold.Points = GetZonePoints(p, 11)
    zoneFinalGold.Active = true
    ztaskFindedieSehenswrdigkeiten.Active = false
    ztaskFindedasGoldFinal.Active = true
  else
    Wherigo.PlayAudio(zmediasoundpoint)
    Wherigo.MessageBox({
      Text = [[Du hast einen mehr! Such weiter :D]],
      Media = zmediapunkt,
      Buttons = {"Weiter"},
      Callback = cartILuebeck.MsgBoxCBFuncs.MsgBoxCB185
    })
  end
end
function GetZonePoints(refPt, radi)
  local xdist = Wherigo.Distance(radi, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, xdist, 22.5),
    Wherigo.TranslatePoint(refPt, xdist, 67.5),
    Wherigo.TranslatePoint(refPt, xdist, 112.5),
    Wherigo.TranslatePoint(refPt, xdist, 157.5),
    Wherigo.TranslatePoint(refPt, xdist, 202.5),
    Wherigo.TranslatePoint(refPt, xdist, 247.5),
    Wherigo.TranslatePoint(refPt, xdist, 292.5),
    Wherigo.TranslatePoint(refPt, xdist, 337.5)
  }
  return pts
end
function round(num, idp)
  local mult = 10 ^ (idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
return cartILuebeck''';
